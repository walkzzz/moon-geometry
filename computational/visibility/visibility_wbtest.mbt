test "is_visible_convex" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_visible(sq, @core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0)))
  assert_true(is_visible(sq, @core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 1.0)))
}

test "is_visible_concave" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_visible(poly, @core.Point2D::new(0.5, 0.5), @core.Point2D::new(3.5, 0.5)))
  assert_false(is_visible(poly, @core.Point2D::new(0.25, 3.5), @core.Point2D::new(3.75, 3.5)))
}

test "visibility_polygon_convex" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let vis = visibility_polygon_convex(sq, @core.Point2D::new(2.0, 2.0))
  assert_true(vis.length() == 4)
}

test "visible_vertex_count" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let count = visible_vertex_count(sq, @core.Point2D::new(2.0, 2.0))
  assert_true(count == 4)
}

test "visibility_polygon_general" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let vis = visibility_polygon(sq, @core.Point2D::new(2.0, 2.0))
  assert_true(vis.length() >= 3)
}