///|
/// Bounding box of quadratic Bezier. Returns (min_x, min_y, max_x, max_y).
/// 二次贝塞尔曲线包围盒，返回 (min_x, min_y, max_x, max_y)。
pub impl @core.Bounded2D for Bezier2 with bbox(self) {
  let mut min_x = self.p0.x()
  let mut max_x = min_x
  let mut min_y = self.p0.y()
  let mut max_y = min_y
  let dx = self.p0.x() - 2.0 * self.p1.x() + self.p2.x()
  if dx.abs() > @core.default_eps {
    let t = (self.p0.x() - self.p1.x()) / dx
    if t > 0.0 && t < 1.0 {
      let x = self.eval(t).x()
      if x < min_x {
        min_x = x
      }
      if x > max_x {
        max_x = x
      }
    }
  }
  let dy = self.p0.y() - 2.0 * self.p1.y() + self.p2.y()
  if dy.abs() > @core.default_eps {
    let t = (self.p0.y() - self.p1.y()) / dy
    if t > 0.0 && t < 1.0 {
      let y = self.eval(t).y()
      if y < min_y {
        min_y = y
      }
      if y > max_y {
        max_y = y
      }
    }
  }
  for p in [self.p2] {
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
