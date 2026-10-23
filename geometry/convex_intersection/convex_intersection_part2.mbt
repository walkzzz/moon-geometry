///|
/// Check if two convex polygons intersect. / 检查两个凸多边形是否相交。
pub fn convex_polygons_intersect(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Bool {
  convex_polygon_intersection(poly1, poly2).length() > 0
}

///|
/// Compute the area of intersection of two convex polygons. / 计算两个凸多边形交集的面积。
pub fn intersection_area(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Double {
  let inter = convex_polygon_intersection(poly1, poly2)
  let n = inter.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area += inter[i].x() * inter[j].y() - inter[j].x() * inter[i].y()
  }
  (area / 2.0).abs()
}
