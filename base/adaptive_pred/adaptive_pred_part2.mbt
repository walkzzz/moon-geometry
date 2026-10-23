///|
/// Adaptive 2D orientation sign of points a, b, c. / 自适应二维定向符号判定点 a, b, c 的方向。
pub fn adaptive_orient2d(
  ax : Double,
  ay : Double,
  bx : Double,
  by : Double,
  cx : Double,
  cy : Double,
) -> Int32 {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  let maxc = [ax.abs(), ay.abs(), bx.abs(), by.abs(), cx.abs(), cy.abs()]
  let mut m = 0.0
  for v in maxc {
    if v > m {
      m = v
    }
  }
  let bound = 3.0 * @math.pow(2.0, -52.0) * m * m
  if det.abs() > bound {
    if det > 0.0 {
      1
    } else {
      -1
    }
  } else if det.abs() < bound * 1.0e-10 {
    0
  } else if det > 0.0 {
    1
  } else if det < 0.0 {
    -1
  } else {
    0
  }
}
