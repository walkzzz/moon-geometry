///|
/// Solve two lines a*x+b*y=c by Cramer's rule. / 用克拉默法则求解两条直线 a*x+b*y=c 的交点。
pub fn robust_line_line(
  a1 : Double,
  b1 : Double,
  c1 : Double,
  a2 : Double,
  b2 : Double,
  c2 : Double,
) -> (Double, Double, Bool) {
  let det = a1 * b2 - a2 * b1
  if det.abs() < 1.0e-15 {
    (0.0, 0.0, false)
  } else {
    ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det, true)
  }
}
