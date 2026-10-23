///|
/// Discriminant B^2 - 4AC. / 判别式 B^2 - 4AC。
pub fn Conic::discriminant(conic : Conic) -> Double {
  conic.b * conic.b - 4.0 * conic.a * conic.c
}

///|
/// Classify the conic section. / 分类圆锥曲线。
pub fn Conic::classify(conic : Conic) -> ConicType {
  let disc = Conic::discriminant(conic)
  let eps = 0.0000000001
  if disc.abs() < eps {
    Parabola
  } else if disc < 0.0 {
    let i3 = Conic::det3(conic)
    if i3.abs() < eps {
      Degenerate
    } else {
      Ellipse
    }
  } else {
    let i3 = Conic::det3(conic)
    if i3.abs() < eps {
      Degenerate
    } else {
      Hyperbola
    }
  }
}

///|
/// Determinant of the 3x3 matrix of the conic (invariant I3).
/// 圆锥曲线 3x3 矩阵行列式（不变量 I3）。
pub fn Conic::det3(conic : Conic) -> Double {
  let a = conic.a
  let b = conic.b / 2.0
  let c = conic.c
  let d = conic.d / 2.0
  let e = conic.e / 2.0
  let f = conic.f
  a * (c * f - e * e) - b * (b * f - e * d) + d * (b * e - c * d)
}
