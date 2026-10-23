///|
/// # DE-9IM Topological Relations
/// # DE-9IM 拓扑关系
///
/// Dimensionally Extended 9-Intersection Model for spatial relations.
/// 维度扩展9交模型，用于空间关系判定。

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

///|
pub fn de9im_touches(
  a_bounds : (@core.Point2D, @core.Point2D),
  b_bounds : (@core.Point2D, @core.Point2D),
) -> Bool {
  let (a_lo, a_hi) = a_bounds
  let (b_lo, b_hi) = b_bounds
  let touching = a_hi.x() == b_lo.x() ||
    b_hi.x() == a_lo.x() ||
    a_hi.y() == b_lo.y() ||
    b_hi.y() == a_lo.y()
  touching && de9im_intersects(a_bounds, b_bounds)
}

///|
pub fn de9im_within(
  a_bounds : (@core.Point2D, @core.Point2D),
  b_bounds : (@core.Point2D, @core.Point2D),
) -> Bool {
  de9im_contains(b_bounds, a_bounds)
}
