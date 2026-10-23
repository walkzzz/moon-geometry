///|
/// Check if two convex polygons are separated. / 检查两凸多边形是否分离。
pub fn are_separated(poly1 : @core.Polygon, poly2 : @core.Polygon) -> Bool {
  match find_separating_axis(poly1, poly2) {
    Some(_) => true
    None => false
  }
}
