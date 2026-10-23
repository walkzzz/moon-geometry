///|
/// Translate the conic so its center is at the origin (ellipse / hyperbola).
/// 平移圆锥曲线使中心位于原点（椭圆 / 双曲线）。
pub fn Conic::centered(conic : Conic) -> Conic {
  let center = match Conic::center(conic) {
    Some(c) => c
    None => return conic
  }
  let nf = Conic::eval(conic, center)
  { a: conic.a, b: conic.b, c: conic.c, d: 0.0, e: 0.0, f: nf, }
}

///|
/// Rotate the conic to eliminate the xy term. Returns new conic and rotation angle.
/// 旋转圆锥曲线消去 xy 项，返回新圆锥曲线和旋转角。
pub fn Conic::axis_aligned(conic : Conic) -> (Conic, Double) {
  let eps = 0.0000000001
  if conic.b.abs() < eps {
    return (conic, 0.0)
  }
  let theta = 0.5 * @math.atan2(conic.b, conic.a - conic.c)
  let cs = @math.cos(theta)
  let sn = @math.sin(theta)
  let c2 = cs * cs
  let s2 = sn * sn
  let sc = sn * cs
  let na = conic.a * c2 + conic.b * sc + conic.c * s2
  let nb = 0.0
  let nc = conic.a * s2 - conic.b * sc + conic.c * c2
  let nd = conic.d * cs + conic.e * sn
  let ne = -conic.d * sn + conic.e * cs
  ({ a: na, b: nb, c: nc, d: nd, e: ne, f: conic.f, }, theta)
}
