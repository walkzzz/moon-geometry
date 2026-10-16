test "delaunay_refine basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 8.0),
  ]
  let refined = delaunay_refine(pts, 20.0, 5)
  assert_true(refined.length() >= pts.length())
}

test "circumcenter equilateral" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(2.0, 3.464101615)
  let cc = circumcenter(a, b, c)
  assert_true((cc.x() - 2.0).abs() < 0.01)
}

test "min_triangle_angle right" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(0.0, 4.0)
  let angle = min_triangle_angle(a, b, c)
  assert_true((angle - 45.0).abs() < 1.0)
}

test "triangle_count basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_eq(triangle_count(pts), 2)
}

test "delaunay_refine no refinement" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.464101615),
  ]
  let refined = delaunay_refine(pts, 10.0, 3)
  assert_eq(refined.length(), 3)
}