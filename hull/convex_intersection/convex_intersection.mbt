///|
/// Compute the intersection of two convex polygons (Sutherland-Hodgman clipping). / 计算两个凸多边形的交集（Sutherland-Hodgman 裁剪）。
pub fn convex_polygon_intersection(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Array[@core.Point2D] {
  let mut result : Array[@core.Point2D] = []
  for i in 0..<poly1.size() {
    result.push(poly1.get(i))
  }
  let n2 = poly2.size()
  for i in 0..<n2 {
    let edge_start = poly2.get(i)
    let edge_end = poly2.get((i + 1) % n2)
    result = clip_polygon(result, edge_start, edge_end)
    if result.length() == 0 {
      return []
    }
  }
  result
}

fn clip_polygon(
  polygon : Array[@core.Point2D],
  edge_start : @core.Point2D,
  edge_end : @core.Point2D,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = polygon.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let current = polygon[i]
    let next = polygon[(i + 1) % n]
    let current_inside = is_inside_edge(current, edge_start, edge_end)
    let next_inside = is_inside_edge(next, edge_start, edge_end)
    if current_inside {
      result.push(current)
    }
    if current_inside != next_inside {
      match line_intersect(current, next, edge_start, edge_end) {
        Some(pt) => result.push(pt)
        None => continue
      }
    }
  }
  result
}

fn is_inside_edge(
  p : @core.Point2D,
  edge_start : @core.Point2D,
  edge_end : @core.Point2D,
) -> Bool {
  let dx = edge_end.x() - edge_start.x()
  let dy = edge_end.y() - edge_start.y()
  dx * (p.y() - edge_start.y()) - dy * (p.x() - edge_start.x()) >= 0.0
}

fn line_intersect(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> @core.Point2D? {
  let d1x = p2.x() - p1.x()
  let d1y = p2.y() - p1.y()
  let d2x = p4.x() - p3.x()
  let d2y = p4.y() - p3.y()
  let denom = d1x * d2y - d1y * d2x
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return None
  }
  let t = ((p3.x() - p1.x()) * d2y - (p3.y() - p1.y()) * d2x) / denom
  Some(@core.Point2D::new(p1.x() + t * d1x, p1.y() + t * d1y))
}

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