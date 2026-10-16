test "convex intersection basic" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ]
  let poly1 = @core.Polygon::new(pts1)
  let poly2 = @core.Polygon::new(pts2)
  let inter = convex_polygon_intersection(poly1, poly2)
  assert_true(inter.length() >= 3)
}

test "convex polygons intersect" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ]
  let poly1 = @core.Polygon::new(pts1)
  let poly2 = @core.Polygon::new(pts2)
  assert_true(convex_polygons_intersect(poly1, poly2))
}

test "convex polygons no intersect" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let pts2 = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(7.0, 5.0),
    @core.Point2D::new(7.0, 7.0),
    @core.Point2D::new(5.0, 7.0),
  ]
  let poly1 = @core.Polygon::new(pts1)
  let poly2 = @core.Polygon::new(pts2)
  assert_false(convex_polygons_intersect(poly1, poly2))
}

test "intersection area" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ]
  let poly1 = @core.Polygon::new(pts1)
  let poly2 = @core.Polygon::new(pts2)
  let area = intersection_area(poly1, poly2)
  assert_true(area > 0.0)
}

test "intersection contained" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(8.0, 8.0),
    @core.Point2D::new(0.0, 8.0),
  ]
  let pts2 = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let poly1 = @core.Polygon::new(pts1)
  let poly2 = @core.Polygon::new(pts2)
  let area = intersection_area(poly1, poly2)
  assert_true((area - 4.0).abs() < 0.1)
}