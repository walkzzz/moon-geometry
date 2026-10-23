///|
/// Compute the bounding box center of a convex polygon. / 计算凸多边形的包围盒中心。
pub fn bbox_center(poly : @core.Polygon) -> @core.Point2D {
  let n = poly.size()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut min_x = poly.get(0).x()
  let mut max_x = poly.get(0).x()
  let mut min_y = poly.get(0).y()
  let mut max_y = poly.get(0).y()
  for i in 1..<n {
    let p = poly.get(i)
    min_x = min_x.min(p.x())
    max_x = max_x.max(p.x())
    min_y = min_y.min(p.y())
    max_y = max_y.max(p.y())
  }
  @core.Point2D::new((min_x + max_x) / 2.0, (min_y + max_y) / 2.0)
}


///|
/// Compute the vertex average center of a convex polygon. / 计算凸多边形的顶点平均中心。
pub fn vertex_center(poly : @core.Polygon) -> @core.Point2D {
  let n = poly.size()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for i in 0..<n {
    sx += poly.get(i).x()
    sy += poly.get(i).y()
  }
  @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
}
