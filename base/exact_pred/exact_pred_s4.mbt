///| Test if point p is strictly left of line a-b. / 测试点 p 是否严格在线段 a-b 的左侧。
pub fn exact_left_of_line(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  exact_orientation(ax, ay, bx, by, px, py) > 0
}


///| Test if points a, b, c are collinear. / 测试点 a, b, c 是否共线。
pub fn exact_collinear(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Bool {
  exact_orientation(ax, ay, bx, by, cx, cy) == 0
}
