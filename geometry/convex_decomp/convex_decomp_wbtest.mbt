///|
test "is_convex_polygon" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_convex_polygon(sq))
  let concave = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_false(is_convex_polygon(concave))
}

///|
test "convex_decomposition_convex" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pieces = convex_decomposition(sq)
  assert_true(pieces.length() == 1)
}

///|
test "convex_decomp_count" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(convex_decomp_count(sq) == 1)
}

///|
test "convex_decomp_lower_bound" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(convex_decomp_lower_bound(sq) == 1)
}

///|
test "convex_decomp_area" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = convex_decomp_area(sq)
  assert_true((area - 16.0).abs() < 0.001)
}

///|
test "convex_decomposition_concave" {
  let concave = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pieces = convex_decomposition(concave)
  assert_true(pieces.length() >= 1)
}

///|
test "convex_decomposition_small" {
  let small = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  assert_true(convex_decomposition(small).length() == 0)
}

///|
test "convex_decomp_count_concave" {
  let concave = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(convex_decomp_count(concave) >= 1)
}

///|
test "convex_decomp_lower_bound_concave" {
  let concave = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(convex_decomp_lower_bound(concave) >= 1)
}

///|
test "convex_decomp_lower_bound_small" {
  let small = [@core.Point2D::new(0.0, 0.0)]
  assert_eq(convex_decomp_lower_bound(small), 0)
}

///|
test "convex_decomp_area_concave" {
  let concave = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = convex_decomp_area(concave)
  assert_true(area > 0.0)
}
