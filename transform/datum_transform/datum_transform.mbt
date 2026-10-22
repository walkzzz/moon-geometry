///|
/// 7-parameter Helmert/Bursa-Wolf transformation. / 七参数 Helmert/Bursa-Wolf 变换。
pub struct Helmert7 {
  tx : Double
  ty : Double
  tz : Double
  rx : Double
  ry : Double
  rz : Double
  scale : Double
}

///|
/// Construct 7-parameter transform. / 构造七参数变换。
/// tx/ty/tz: translation (meters), rx/ry/rz: rotation (radians), scale: ppm. / tx/ty/tz: 平移（米），rx/ry/rz: 旋转（弧度），scale: ppm。
pub fn Helmert7::new(
  tx : Double,
  ty : Double,
  tz : Double,
  rx : Double,
  ry : Double,
  rz : Double,
  scale : Double,
) -> Helmert7 {
  { tx, ty, tz, rx, ry, rz, scale }
}

///|
/// 3-parameter translation only. / 仅平移的三参数变换。
pub struct Helmert3 {
  tx : Double
  ty : Double
  tz : Double
}

///|
/// Construct 3-parameter transform. / 构造三参数变换。
pub fn Helmert3::new(tx : Double, ty : Double, tz : Double) -> Helmert3 {
  { tx, ty, tz }
}

///|
/// Apply 7-parameter Bursa-Wolf transform to ECEF point. / 对 ECEF 点应用七参数 Bursa-Wolf 变换。
pub fn apply_helmert7(h : Helmert7, x : Double, y : Double, z : Double) -> (Double, Double, Double) {
  let s = 1.0 + h.scale / 1000000.0
  let rx = h.rx
  let ry = h.ry
  let rz = h.rz
  // Full rotation matrix R = Rz(rz) * Ry(ry) * Rx(rx)
  let cos_rx = @math.cos(rx)
  let sin_rx = @math.sin(rx)
  let cos_ry = @math.cos(ry)
  let sin_ry = @math.sin(ry)
  let cos_rz = @math.cos(rz)
  let sin_rz = @math.sin(rz)
  // R = Rz * Ry * Rx
  let r00 = cos_rz * cos_ry
  let r01 = cos_rz * sin_ry * sin_rx - sin_rz * cos_rx
  let r02 = cos_rz * sin_ry * cos_rx + sin_rz * sin_rx
  let r10 = sin_rz * cos_ry
  let r11 = sin_rz * sin_ry * sin_rx + cos_rz * cos_rx
  let r12 = sin_rz * sin_ry * cos_rx - cos_rz * sin_rx
  let r20 = -sin_ry
  let r21 = cos_ry * sin_rx
  let r22 = cos_ry * cos_rx
  let x2 = r00 * x + r01 * y + r02 * z
  let y2 = r10 * x + r11 * y + r12 * z
  let z2 = r20 * x + r21 * y + r22 * z
  (h.tx + s * x2, h.ty + s * y2, h.tz + s * z2)
}

///|
/// Apply 3-parameter translation to ECEF point. / 对 ECEF 点应用三参数平移。
pub fn apply_helmert3(h : Helmert3, x : Double, y : Double, z : Double) -> (Double, Double, Double) {
  (x + h.tx, y + h.ty, z + h.tz)
}

///|
/// Inverse of 7-parameter transform (approximate). / 七参数变换的逆（近似）。
pub fn inverse_helmert7(h : Helmert7) -> Helmert7 {
  let s = 1.0 + h.scale / 1000000.0
  let inv_s = 1.0 / s
  // Inverse rotation (negate for small angles)
  let inv_rx = -h.rx
  let inv_ry = -h.ry
  let inv_rz = -h.rz
  // Inverse translation: -R^(-1) * t / s
  let tx2 = h.tx - h.rz * h.ty + h.ry * h.tz
  let ty2 = h.rz * h.tx + h.ty - h.rx * h.tz
  let tz2 = -h.ry * h.tx + h.rx * h.ty + h.tz
  {
    tx: -tx2 * inv_s,
    ty: -ty2 * inv_s,
    tz: -tz2 * inv_s,
    rx: inv_rx,
    ry: inv_ry,
    rz: inv_rz,
    scale: -h.scale,
  }
}

///|
/// Inverse of 3-parameter transform. / 三参数变换的逆。
pub fn inverse_helmert3(h : Helmert3) -> Helmert3 {
  { tx: -h.tx, ty: -h.ty, tz: -h.tz }
}

///|
/// Identity 7-parameter transform. / 单位七参数变换。
pub fn helmert7_identity() -> Helmert7 {
  { tx: 0.0, ty: 0.0, tz: 0.0, rx: 0.0, ry: 0.0, rz: 0.0, scale: 0.0 }
}

///|
/// WGS84 to CGCS2000 7-parameter (approximate, very small). / WGS84 转 CGCS2000 七参数（近似，极小）。
pub fn wgs84_to_cgcs2000_params() -> Helmert7 {
  helmert7_identity()
}

///|
/// Compose two 7-parameter transforms (A after B). / 复合两个七参数变换（A 后 B）。
pub fn compose_helmert7(a : Helmert7, b : Helmert7) -> Helmert7 {
  let s_b = 1.0 + b.scale / 1000000.0
  let (bx2, by2, bz2) = apply_helmert7(a, b.tx * s_b, b.ty * s_b, b.tz * s_b)
  {
    tx: bx2,
    ty: by2,
    tz: bz2,
    rx: a.rx + b.rx,
    ry: a.ry + b.ry,
    rz: a.rz + b.rz,
    scale: a.scale + b.scale,
  }
}