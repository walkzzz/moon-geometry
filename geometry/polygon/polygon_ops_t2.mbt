///|
/// Absolute area of a polygon (Shoelace formula).
/// 多边形绝对面积（Shoelace 公式）。
pub fn polygon_area(poly : @core.Polygon) -> Double {
  polygon_signed_area(poly).abs()
}
