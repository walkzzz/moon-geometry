///|
/// Asymptote lines of a hyperbola. / 双曲线的渐近线。
/// Returns two lines (a, b, c) or None if not a hyperbola.
/// 返回两条直线 (a, b, c)，非双曲线返回 None。
pub fn Conic::asymptotes(
  conic : Conic,
) -> ((Double, Double, Double), (Double, Double, Double))? {
  let eps = 0.0000000001
  let disc = Conic::discriminant(conic)
  if disc <= eps {
    return None
  }
  let center = match Conic::center(conic) {
    Some(c) => c
    None => return None
  }
  let h = center.x()
  let k = center.y()
  let sq = disc.sqrt()
  let m1 = (-conic.b + sq) / (2.0 * conic.a)
  let m2 = (-conic.b - sq) / (2.0 * conic.a)
  let l1 = (m1, -1.0, k - m1 * h)
  let l2 = (m2, -1.0, k - m2 * h)
  Some((l1, l2))
}
