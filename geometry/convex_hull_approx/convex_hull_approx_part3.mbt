///|
/// Quick hull approximation error bound. / 快速凸包近似误差界。
pub fn approx_error_bound(
  points : Array[@core.Point2D],
  grid_size : Int,
) -> Double {
  if points.length() == 0 {
    return 0.0
  }
  let mut min_x = points[0].x()
  let mut max_x = points[0].x()
  let mut min_y = points[0].y()
  let mut max_y = points[0].y()
  for p in points {
    min_x = min_x.min(p.x())
    max_x = max_x.max(p.x())
    min_y = min_y.min(p.y())
    max_y = max_y.max(p.y())
  }
  let dx = (max_x - min_x) / grid_size.to_double()
  let dy = (max_y - min_y) / grid_size.to_double()
  (dx * dx + dy * dy).sqrt()
}