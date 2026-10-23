///|
pub fn de9im_intersects(
  a_bounds : (@core.Point2D, @core.Point2D),
  b_bounds : (@core.Point2D, @core.Point2D),
) -> Bool {
  let (a_lo, a_hi) = a_bounds
  let (b_lo, b_hi) = b_bounds
  !(a_hi.x() < b_lo.x() ||
  b_hi.x() < a_lo.x() ||
  a_hi.y() < b_lo.y() ||
  b_hi.y() < a_lo.y())
}
