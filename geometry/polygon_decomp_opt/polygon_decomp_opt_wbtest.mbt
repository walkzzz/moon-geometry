///|
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

///|
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

///|
test "decomp_count convex" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_eq(decomp_count(pts), 1)
}

///|
test "is_convex_polygon square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_convex_polygon(pts))
}

///|
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

///|
test "optimal_convex_decomp too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let result = optimal_convex_decomp(pts)
  assert_eq(result.length(), 0)
}

///|
test "optimal_convex_decomp empty" {
  let pts : Array[@core.Point2D] = []
  let result = optimal_convex_decomp(pts)
  assert_eq(result.length(), 0)
}

///|
test "optimal_convex_decomp triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let result = optimal_convex_decomp(pts)
  assert_eq(result.length(), 1)
  assert_eq(result[0].length(), 3)
}

///|
test "is_convex_polygon too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  assert_false(is_convex_polygon(pts))
}

///|
test "is_convex_polygon empty" {
  let pts : Array[@core.Point2D] = []
  assert_false(is_convex_polygon(pts))
}

///|
test "is_convex_polygon with collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_convex_polygon(pts))
}

///|
test "optimal_convex_decomp arrow shape no valid cut" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(1.0, 2.0),
  ]
  let result = optimal_convex_decomp(pts)
  assert_true(result.length() >= 1)
}

///|
test "optimal_convex_decomp U-shape two reflex" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = optimal_convex_decomp(pts)
  assert_true(result.length() >= 2)
}

///|
test "decomp_count triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  assert_eq(decomp_count(pts), 1)
}

///|
test "decomp_count too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  assert_eq(decomp_count(pts), 0)
}
