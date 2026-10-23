///|
pub fn de9im_contains(
  a_bounds : (@core.Point2D, @core.Point2D),
  b_bounds : (@core.Point2D, @core.Point2D),
) -> Bool {
  let (a_lo, a_hi) = a_bounds
  let (b_lo, b_hi) = b_bounds
  a_lo.x() <= b_lo.x() &&
  b_hi.x() <= a_hi.x() &&
  a_lo.y() <= b_lo.y() &&
  b_hi.y() <= a_hi.y()
}

///|
pub fn de9im_disjoint(
  a_bounds : (@core.Point2D, @core.Point2D),
  b_bounds : (@core.Point2D, @core.Point2D),
) -> Bool {
  !de9im_intersects(a_bounds, b_bounds)
}
