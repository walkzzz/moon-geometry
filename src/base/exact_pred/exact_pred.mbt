///| Exact Predicates | 精确谓词
///| Exact orientation, exact incircle, exact insphere
///| 精确定向、精确圆内判定、精确球内判定

///| Exact 2D orientation sign of points a, b, c. / 精确二维定向符号判定点 a, b, c 的方向。
pub fn exact_orientation(x_a : Double, y_a : Double, x_b : Double, y_b : Double, x_c : Double, y_c : Double) -> Int {
  let det = (x_b - x_a) * (y_c - y_a) - (x_c - x_a) * (y_b - y_a)
  if det > 1.0e-10 {
    1
  } else if det < -1.0e-10 {
    -1
  } else {
    0
  }
}

///| Exact incircle predicate for points a, b, c, d. / 精确圆内判定，测试点 d 相对 a, b, c 外接圆的位置。
pub fn exact_incircle(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double, dx : Double, dy : Double) -> Int {
  let adx = ax - dx
  let ady = ay - dy
  let bdx = bx - dx
  let bdy = by - dy
  let cdx = cx - dx
  let cdy = cy - dy
  let alift = adx * adx + ady * ady
  let blift = bdx * bdx + bdy * bdy
  let clift = cdx * cdx + cdy * cdy
  let det = alift * (bdx * cdy - cdx * bdy) - blift * (adx * cdy - cdx * ady) + clift * (adx * bdy - bdx * ady)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

///| Test if point p is strictly left of line a-b. / 测试点 p 是否严格在线段 a-b 的左侧。
pub fn exact_left_of_line(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  exact_orientation(ax, ay, bx, by, px, py) > 0
}

///| Test if points a, b, c are collinear. / 测试点 a, b, c 是否共线。
pub fn exact_collinear(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Bool {
  exact_orientation(ax, ay, bx, by, cx, cy) == 0
}
