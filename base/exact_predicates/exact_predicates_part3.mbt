///|
/// Collinear predicate. / 共线谓词。
pub fn exact_collinear(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  exact_orientation(a, b, c) == 0
}
