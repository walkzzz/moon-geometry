///|
/// WGS84 semi-major axis (meters). / WGS84 长半轴（米）。
pub let wgs84_a : Double = 6378137.0

///|
/// WGS84 inverse flattening. / WGS84 反扁率。
pub let wgs84_inv_f : Double = 298.257223563

///|
/// CGCS2000 semi-major axis (meters). / CGCS2000 长半轴（米）。
pub let cgcs2000_a : Double = 6378137.0

///|
/// CGCS2000 inverse flattening. / CGCS2000 反扁率。
pub let cgcs2000_inv_f : Double = 298.257222101

///|
/// Degree to radian. / 度转弧度。
pub let deg2rad : Double = 0.017453292519943295

///|
/// Radian to degree. / 弧度转度。
pub let rad2deg : Double = 57.29577951308232

///|
/// ECEF (Earth-Centered Earth-Fixed) coordinate. / 地心地固坐标。
pub struct ECEF {
  x : Double
  y : Double
  z : Double
}

///|
/// Construct ECEF coordinate. / 构造 ECEF 坐标。
pub fn ECEF::new(x : Double, y : Double, z : Double) -> ECEF {
  { x, y, z, }
}

///|
/// Geodetic coordinate (lat/lon in degrees, h in meters). / 大地坐标（纬度/经度单位为度，高程单位为米）。
pub struct Geodetic {
  lat : Double
  lon : Double
  h : Double
}

///|
/// Construct geodetic coordinate. / 构造大地坐标。
pub fn Geodetic::new(lat : Double, lon : Double, h : Double) -> Geodetic {
  { lat, lon, h, }
}

///|
/// WGS84 flattening. / WGS84 扁率。
fn wgs84_f() -> Double {
  1.0 / wgs84_inv_f
}

///|
/// CGCS2000 flattening. / CGCS2000 扁率。
fn cgcs2000_f() -> Double {
  1.0 / cgcs2000_inv_f
}

///|
/// Prime vertical radius of curvature (N). / 卯酉圈曲率半径。
fn prime_vertical(lat_r : Double, a : Double, f : Double) -> Double {
  let e2 = f * (2.0 - f)
  a / (1.0 - e2 * @math.sin(lat_r) * @math.sin(lat_r)).sqrt()
}

///|
/// Convert WGS84 geodetic to ECEF. / WGS84 大地坐标转 ECEF。
pub fn wgs84_to_ecef(g : Geodetic) -> ECEF {
  let a = wgs84_a
  let f = wgs84_f()
  let e2 = f * (2.0 - f)
  let lat_r = g.lat * deg2rad
  let lon_r = g.lon * deg2rad
  let n = prime_vertical(lat_r, a, f)
  let x = (n + g.h) * @math.cos(lat_r) * @math.cos(lon_r)
  let y = (n + g.h) * @math.cos(lat_r) * @math.sin(lon_r)
  let z = (n * (1.0 - e2) + g.h) * @math.sin(lat_r)
  { x, y, z, }
}

///|
/// Convert ECEF to WGS84 geodetic (iterative). / ECEF 转 WGS84 大地坐标（迭代法）。
pub fn ecef_to_wgs84(e : ECEF) -> Geodetic {
  let a = wgs84_a
  let f = wgs84_f()
  let e2 = f * (2.0 - f)

  let p = (e.x * e.x + e.y * e.y).sqrt()
  let mut lat = @math.atan2(e.z, p * (1.0 - e2))
  let mut iter = 0
  let mut n = 0.0
  while iter < 10 {
    n = a / (1.0 - e2 * @math.sin(lat) * @math.sin(lat)).sqrt()
    let new_lat = @math.atan2(e.z + e2 * n * @math.sin(lat), p)
    if (new_lat - lat).abs() < 0.0000000000001 {
      lat = new_lat
      break
    }
    lat = new_lat
    iter += 1
  }
  let lon = @math.atan2(e.y, e.x)
  let h = p / @math.cos(lat) - n
  { lat: lat * rad2deg, lon: lon * rad2deg, h, }
}

///|
/// Convert CGCS2000 geodetic to ECEF. / CGCS2000 大地坐标转 ECEF。
pub fn cgcs2000_to_ecef(g : Geodetic) -> ECEF {
  let a = cgcs2000_a
  let f = cgcs2000_f()
  let e2 = f * (2.0 - f)
  let lat_r = g.lat * deg2rad
  let lon_r = g.lon * deg2rad
  let n = prime_vertical(lat_r, a, f)
  let x = (n + g.h) * @math.cos(lat_r) * @math.cos(lon_r)
  let y = (n + g.h) * @math.cos(lat_r) * @math.sin(lon_r)
  let z = (n * (1.0 - e2) + g.h) * @math.sin(lat_r)
  { x, y, z, }
}

///|
/// Convert ECEF to CGCS2000 geodetic. / ECEF 转 CGCS2000 大地坐标。
pub fn ecef_to_cgcs2000(e : ECEF) -> Geodetic {
  let a = cgcs2000_a
  let f = cgcs2000_f()
  let e2 = f * (2.0 - f)
  let p = (e.x * e.x + e.y * e.y).sqrt()
  let mut lat = @math.atan2(e.z, p * (1.0 - e2))
  let mut iter = 0
  let mut n = 0.0
  while iter < 10 {
    n = a / (1.0 - e2 * @math.sin(lat) * @math.sin(lat)).sqrt()
    let new_lat = @math.atan2(e.z + e2 * n * @math.sin(lat), p)
    if (new_lat - lat).abs() < 0.0000000000001 {
      lat = new_lat
      break
    }
    lat = new_lat
    iter += 1
  }
  let lon = @math.atan2(e.y, e.x)
  let h = p / @math.cos(lat) - n
  { lat: lat * rad2deg, lon: lon * rad2deg, h, }
}

///|
/// Convert WGS84 to CGCS2000 (via ECEF). / WGS84 转 CGCS2000（经 ECEF）。
pub fn wgs84_to_cgcs2000(g : Geodetic) -> Geodetic {
  let e = wgs84_to_ecef(g)
  ecef_to_cgcs2000(e)
}

///|
/// Convert CGCS2000 to WGS84 (via ECEF). / CGCS2000 转 WGS84（经 ECEF）。
pub fn cgcs2000_to_wgs84(g : Geodetic) -> Geodetic {
  let e = cgcs2000_to_ecef(g)
  ecef_to_wgs84(e)
}

///|
/// ECEF distance (Euclidean, meters). / ECEF 欧氏距离（米）。
pub fn ecef_distance(e1 : ECEF, e2 : ECEF) -> Double {
  let dx = e1.x - e2.x
  let dy = e1.y - e2.y
  let dz = e1.z - e2.z
  (dx * dx + dy * dy + dz * dz).sqrt()
}
