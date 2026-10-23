///|
/// Bounding box of cubic Bezier. Returns (min_x, min_y, max_x, max_y).
/// 三次贝塞尔曲线包围盒，返回 (min_x, min_y, max_x, max_y)。
pub impl @core.Bounded2D for Bezier3 with fn bbox(self) {
  let samples = 200
  let mut min_x = self.p0.x()
  let mut max_x = min_x
  let mut min_y = self.p0.y()
  let mut max_y = min_y
  for i in 0..<=samples {
    let t = i.to_double() / samples.to_double()
    let p = self.eval(t)
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  (min_x, min_y, max_x, max_y)
}
