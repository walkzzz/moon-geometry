///| Robust 2D orientation sign of points a, b, c. / 鲁棒二维定向符号判定点 a, b, c 的方向。
pub fn robust_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  if det > 1.0e-12 { 1 } else if det < -1.0e-12 { -1 } else { 0 }
}
