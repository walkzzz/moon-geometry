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