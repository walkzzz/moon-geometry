///|
/// Exact 2D orientation sign of points a, b, c. / 精确二维定向符号判定点 a, b, c 的方向。
pub fn exact_orientation(
  x_a : Double,
  y_a : Double,
  x_b : Double,
  y_b : Double,
  x_c : Double,
  y_c : Double,
) -> Int32 {
  let det = (x_b - x_a) * (y_c - y_a) - (x_c - x_a) * (y_b - y_a)
  if det > 1.0e-10 {
    1
  } else if det < -1.0e-10 {
    -1
  } else {
    0
  }
}
