test "optimal_convex_decomp convex" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = optimal_convex_decomp(pts)
  assert_eq(result.length(), 1)
}

test "optimal_convex_decomp L-shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = optimal_convex_decomp(pts)
  assert_true(result.length() >= 1)
}

test "decomp_count convex" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_eq(decomp_count(pts), 1)
}

test "is_convex_polygon square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_convex_polygon(pts))
}

test "is_convex_polygon L-shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_false(is_convex_polygon(pts))
}