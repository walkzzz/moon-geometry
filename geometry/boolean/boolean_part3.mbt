///|
/// Union area of two polygons (via inclusion-exclusion).
/// Returns the combined area; for the union polygon shape use Greiner-Hormann.
/// 返回合并面积；如需并集多边形形状请用 Greiner-Hormann。
pub fn polygon_union_area(p1 : @core.Polygon, p2 : @core.Polygon) -> Double {
  let a1 = @polygon.polygon_area(p1)
  let a2 = @polygon.polygon_area(p2)
  let inter = match polygon_intersection(p1, p2) {
    Some(p) => @polygon.polygon_area(p)
    None => 0.0
  }
  a1 + a2 - inter
}


///|
/// Difference area (p1 minus p2).
/// 差集面积（p1 减 p2）。
pub fn polygon_difference_area(
  p1 : @core.Polygon,
  p2 : @core.Polygon,
) -> Double {
  let a1 = @polygon.polygon_area(p1)
  let inter = match polygon_intersection(p1, p2) {
    Some(p) => @polygon.polygon_area(p)
    None => 0.0
  }
  a1 - inter
}
