test "approx convex hull" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let hull = approx_convex_hull(pts, 10)
  assert_true(hull.length() >= 3)
}

test "approx hull area" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = approx_hull_area(pts)
  assert_true(area > 0.0)
}

test "approx hull perimeter" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let per = approx_hull_perimeter(pts)
  assert_true(per > 0.0)
}

test "approx error bound" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
  ]
  let err = approx_error_bound(pts, 10)
  assert_true(err > 0.0)
}

test "approx hull small" {
  let pts = [@core.Point2D::new(1.0, 1.0)]
  let hull = approx_convex_hull(pts, 10)
  assert_eq(hull.length(), 1)
}