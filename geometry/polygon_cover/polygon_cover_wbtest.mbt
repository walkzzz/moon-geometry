test "cover_by_rectangles" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let rects = cover_by_rectangles(poly)
  assert_true(rects.length() == 1)
  assert_true((rects[0].area() - 16.0).abs() < 0.001)
}

test "cover_by_triangles" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = cover_by_triangles(poly)
  assert_true(tris.length() == 2)
}

test "cover_area_rectangles" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ]
  let area = cover_area_rectangles(poly)
  assert_true((area - 18.0).abs() < 0.001)
}

test "cover_area_triangles" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = cover_area_triangles(poly)
  assert_true((area - 16.0).abs() < 0.001)
}

test "cover_count" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(cover_count_rectangles(poly) == 1)
  assert_true(cover_count_triangles(poly) == 2)
}
test "cover_by_rectangles_empty" {
  let empty : Array[@core.Point2D] = []
  assert_true(cover_by_rectangles(empty).length() == 0)
  let two = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  assert_true(cover_by_rectangles(two).length() == 0)
}

test "cover_by_triangles_empty" {
  let empty : Array[@core.Point2D] = []
  assert_true(cover_by_triangles(empty).length() == 0)
  let two = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  assert_true(cover_by_triangles(two).length() == 0)
}

test "cover_by_rectangles_irregular" {
  let poly = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(5.0, 1.0),
    @core.Point2D::new(7.0, 6.0),
    @core.Point2D::new(1.0, 5.0),
  ]
  let rects = cover_by_rectangles(poly)
  assert_true(rects.length() == 1)
  assert_true((rects[0].area() - 30.0).abs() < 0.001)
}

test "cover_by_triangles_pentagon" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 2.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(-1.0, 1.0),
  ]
  let tris = cover_by_triangles(poly)
  assert_true(tris.length() == 3)
}

test "cover_area_rectangles_empty" {
  let empty : Array[@core.Point2D] = []
  assert_true(cover_area_rectangles(empty) == 0.0)
}

test "cover_area_triangles_empty" {
  let empty : Array[@core.Point2D] = []
  assert_true(cover_area_triangles(empty) == 0.0)
}

test "cover_count_empty" {
  let empty : Array[@core.Point2D] = []
  assert_true(cover_count_rectangles(empty) == 0)
  assert_true(cover_count_triangles(empty) == 0)
}

test "cover_count_triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(1.5, 3.0),
  ]
  assert_true(cover_count_rectangles(tri) == 1)
  assert_true(cover_count_triangles(tri) == 1)
}