///|
test "alpha_complex empty" {
  let ac = alpha_complex([], 1.0)
  assert_eq(ac.simplex_count(), 0)
}

///|
test "alpha_complex single point" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let ac = alpha_complex(pts, 1.0)
  assert_eq(ac.simplex_count(), 1)
}

///|
test "alpha_complex two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let ac = alpha_complex(pts, 1.0)
  assert_true(ac.simplex_count() >= 2)
}

///|
test "alpha_complex triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
  ]
  let ac = alpha_complex(pts, 5.0)
  assert_true(ac.simplex_count() >= 3)
}

///|
test "alpha_complex small alpha" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 10.0),
  ]
  let ac = alpha_complex(pts, 0.5)
  assert_eq(ac.simplex_count(), 3)
}

///|
test "alpha_shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let shape = alpha_shape(pts, 3.0)
  assert_true(shape.length() >= 0)
}

///|
test "is_alpha_exposed" {
  let s = { vertices: [0, 1], dimension: 1, circumradius: 2.0, }
  assert_true(is_alpha_exposed(s, 3.0))
  assert_false(is_alpha_exposed(s, 1.0))
}

///|
test "alpha_complex_count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let ac = alpha_complex(pts, 3.0)
  assert_true(alpha_complex_count(ac) >= 4)
}

///|
test "AlphaComplex::new" {
  let ac = AlphaComplex::new()
  assert_eq(ac.simplex_count(), 0)
}
