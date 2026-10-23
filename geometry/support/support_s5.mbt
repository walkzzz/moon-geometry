///|
/// Width of a point set in a direction (support - (-support)). / 点集在方向上的宽度。
pub fn width_in_direction(
  points : Array[@core.Point2D],
  dir : @core.Point2D,
) -> Double {
  match support_value(points, dir) {
    Some(max_val) => {
      let neg_dir = @core.Point2D::new(-dir.x(), -dir.y())
      match support_value(points, neg_dir) {
        Some(min_val) => max_val + min_val
        None => 0.0
      }
    }
    None => 0.0
  }
}
