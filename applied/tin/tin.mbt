///|
/// TIN (Triangulated Irregular Network) built from 3D points. / 由三维点构建的不规则三角网。
pub struct TIN {
  points : Array[@core.Point3D]
  triangles : Array[@triangulation.TriangleIdx]
}

///|
/// Construct a TIN from points and triangle indices. / 从点和三角形索引构造 TIN。
pub fn TIN::new(
  points : Array[@core.Point3D],
  triangles : Array[@triangulation.TriangleIdx],
) -> TIN {
  { points, triangles, }
}

///|
/// Build a TIN from 3D points using Delaunay triangulation of XY. / 用 XY 平面的 Delaunay 三角剖分从三维点构建 TIN。
pub fn build_tin(points : Array[@core.Point3D]) -> TIN {
  let n = points.length()
  if n < 3 {
    return { points, triangles: [], }
  }
  let pts2d : Array[@core.Point2D] = []
  for p in points {
    pts2d.push(@core.Point2D::new(p.x, p.y))
  }
  let tris = @triangulation.delaunay_triangulation(pts2d)
  { points, triangles: tris, }
}

///|
/// Number of points in the TIN. / TIN 中的点数。
pub fn TIN::point_count(t : TIN) -> Int32 {
  t.points.length()
}

///|
/// Number of triangles in the TIN. / TIN 中的三角形数。
pub fn TIN::triangle_count(t : TIN) -> Int32 {
  t.triangles.length()
}

///|
/// Barycentric interpolation of elevation at a 2D point. / 二维点处的高程重心插值。
/// Returns None if the point is outside all triangles. / 点在所有三角形外时返回 None。
pub fn TIN::interpolate(t : TIN, p : @core.Point2D) -> Double? {
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let w0 = ((b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)) /
      (2.0 * area)
    let w1 = ((c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)) /
      (2.0 * area)
    let w2 = 1.0 - w0 - w1
    if w0 >= -0.0000000001 && w1 >= -0.0000000001 && w2 >= -0.0000000001 {
      let z = w0 * a.z + w1 * b.z + w2 * c.z
      return Some(z)
    }
  }
  None
}

///|
/// Volume between TIN surface and z=0 datum. / TIN 表面与 z=0 基准面之间的体积。
pub fn TIN::volume(t : TIN) -> Double {
  let mut vol = 0.0
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    vol += area * (a.z + b.z + c.z) / 3.0
  }
  vol
}

///|
/// Slope (radians) at a triangle containing point p. / 包含点 p 的三角形处的坡度（弧度）。
pub fn TIN::slope_at(t : TIN, p : @core.Point2D) -> Double? {
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let w0 = ((b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)) /
      (2.0 * area)
    let w1 = ((c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)) /
      (2.0 * area)
    let w2 = 1.0 - w0 - w1
    if w0 >= -0.0000000001 && w1 >= -0.0000000001 && w2 >= -0.0000000001 {
      let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) /
        (2.0 * area)
      let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) /
        (2.0 * area)
      let grad = (dz_dx * dz_dx + dz_dy * dz_dy).sqrt()
      return Some(@math.atan(grad))
    }
  }
  None
}

///|
/// Aspect (radians, 0=East, counterclockwise) at a triangle containing p. / 包含点 p 的三角形处的坡向（弧度，0=东，逆时针）。
pub fn TIN::aspect_at(t : TIN, p : @core.Point2D) -> Double? {
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let w0 = ((b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)) /
      (2.0 * area)
    let w1 = ((c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)) /
      (2.0 * area)
    let w2 = 1.0 - w0 - w1
    if w0 >= -0.0000000001 && w1 >= -0.0000000001 && w2 >= -0.0000000001 {
      let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) /
        (2.0 * area)
      let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) /
        (2.0 * area)
      return Some(@math.atan2(dz_dy, dz_dx))
    }
  }
  None
}

///|
/// Min and max elevation in the TIN. / TIN 中的最低和最高高程。
pub fn TIN::elevation_range(t : TIN) -> (Double, Double) {
  let n = t.points.length()
  if n == 0 {
    return (0.0, 0.0)
  }
  let mut zmin = t.points[0].z
  let mut zmax = t.points[0].z
  for i in 1..<n {
    let z = t.points[i].z
    if z < zmin {
      zmin = z
    }
    if z > zmax {
      zmax = z
    }
  }
  (zmin, zmax)
}
