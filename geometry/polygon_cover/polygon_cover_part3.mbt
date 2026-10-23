///|
/// Count rectangles in cover. / 覆盖中矩形数量。
pub fn cover_count_rectangles(
  poly : Array[@core.Point2D],
) -> Int {
  cover_by_rectangles(poly).length()
}


///|
/// Count triangles in cover. / 覆盖中三角形数量。
pub fn cover_count_triangles(
  poly : Array[@core.Point2D],
) -> Int {
  cover_by_triangles(poly).length()
}