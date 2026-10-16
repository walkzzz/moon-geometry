test "fast_triangulate square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = fast_triangulate(pts)
  assert_eq(tris.length(), 2)
}

test "fast_triangulate pentagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(-1.0, 3.0),
  ]
  let tris = fast_triangulate(pts)
  assert_eq(tris.length(), 3)
}

test "fast_triangulate_points square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = fast_triangulate_points(pts)
  assert_eq(tris.length(), 2)
}

test "triangle_count hexagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(4.0, 6.0),
    @core.Point2D::new(0.0, 6.0),
    @core.Point2D::new(-2.0, 3.0),
  ]
  let count = triangle_count(pts)
  assert_eq(count, 4)
}

test "total_triangle_area square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = total_triangle_area(pts)
  assert_true((area - 16.0).abs() < 0.001)
}