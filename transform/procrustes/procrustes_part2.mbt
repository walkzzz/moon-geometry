///|
/// Error accessor. / 误差访问器。
pub fn ProcrustesResult::error(self : ProcrustesResult) -> Double {
  self.error
}


///|
/// Centroid of a point set. / 点集质心。
fn centroid(points : Array[@core.Point2D]) -> @core.Point2D {
  let n = points.length()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in points {
    sx += p.x()
    sy += p.y()
  }
  @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
}
