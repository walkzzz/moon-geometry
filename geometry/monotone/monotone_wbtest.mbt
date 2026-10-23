///|
test "is_y_monotone_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_y_monotone(sq))
}

///|
test "is_x_monotone_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_x_monotone(sq))
}

///|
test "is_y_monotone_non_monotone" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 6.0),
    @core.Point2D::new(0.0, 6.0),
  ]
  assert_false(is_y_monotone(poly))
}

///|
test "triangulate_monotone_triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let tris = triangulate_monotone(tri)
  assert_true(tris.length() == 1)
}

///|
test "monotone_triangulate_count" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let count = monotone_triangulate_count(sq)
  assert_true(count == 2)
}
