///|
/// Axis-aligned bounding box of a polygon.
/// 多边形的轴对齐包围盒。
pub fn aabb_polygon(poly : @core.Polygon) -> @core.Rectangle {
  let n = poly.size()
  if n == 0 {
    return @core.Rectangle::new(0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = poly.get(0).x
  let mut max_x = poly.get(0).x
  let mut min_y = poly.get(0).y
  let mut max_y = poly.get(0).y
  for i in 1..<n {
    let v = poly.get(i)
    if v.x < min_x {
      min_x = v.x
    }
    if v.x > max_x {
      max_x = v.x
    }
    if v.y < min_y {
      min_y = v.y
    }
    if v.y > max_y {
      max_y = v.y
    }
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}
