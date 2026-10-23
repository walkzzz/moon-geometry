///|
/// Approximate convex hull area using bounding box ratio. / 使用包围盒比率近似凸包面积。
pub fn approx_hull_area(points : Array[@core.Point2D]) -> Double {
  if points.length() < 3 {
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
  (max_x - min_x) * (max_y - min_y) * 0.785
}

///|
/// Approximate convex hull perimeter. / 近似凸包周长。
pub fn approx_hull_perimeter(points : Array[@core.Point2D]) -> Double {
  if points.length() < 2 {
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
  2.0 * (max_x - min_x + (max_y - min_y)) * 0.9
}
