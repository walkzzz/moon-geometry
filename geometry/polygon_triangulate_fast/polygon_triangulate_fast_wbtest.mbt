///|
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

///|
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

///|
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

///|
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

///|
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

///|
test "fast_triangulate too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let tris = fast_triangulate(pts)
  assert_eq(tris.length(), 0)
}

///|
test "fast_triangulate empty" {
  let pts : Array[@core.Point2D] = []
  let tris = fast_triangulate(pts)
  assert_eq(tris.length(), 0)
}

///|
test "fast_triangulate triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let tris = fast_triangulate(pts)
  assert_eq(tris.length(), 1)
  assert_eq(tris[0], (0, 1, 2))
}

///|
test "fast_triangulate clockwise forces fallback" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let tris = fast_triangulate(pts)
  assert_true(tris.length() >= 1)
}

///|
test "fast_triangulate_points triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let tris = fast_triangulate_points(pts)
  assert_eq(tris.length(), 1)
}

///|
test "triangle_count too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  assert_eq(triangle_count(pts), 0)
}

///|
test "triangle_count triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  assert_eq(triangle_count(pts), 1)
}

///|
test "total_triangle_area pentagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(-1.0, 3.0),
  ]
  let area = total_triangle_area(pts)
  assert_true(area > 0.0)
}

///|
test "total_triangle_area triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = total_triangle_area(pts)
  assert_true((area - 8.0).abs() < 0.001)
}
