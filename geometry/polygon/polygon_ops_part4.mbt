///|
/// @core.Orientation of a polygon (CW / CCW / @core.Collinear) based on signed area.
/// 基于有符号面积的多边形方向（CW / CCW / Collinear）。
pub fn polygon_orientation(poly : @core.Polygon) -> @core.Orientation {
  let a = polygon_signed_area(poly)
  if a > 0.0 {
    @core.CounterClockwise
  } else if a < 0.0 {
    @core.Clockwise
  } else {
    @core.Collinear
  }
}
