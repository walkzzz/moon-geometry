test "convex centroid" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 6.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = convex_centroid(poly)
  assert_true((c.x() - 3.0).abs() < 0.01)
  assert_true((c.y() - 2.0).abs() < 0.01)
}

test "chebyshev center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = chebyshev_center(poly)
  assert_true((c.x() - 2.0).abs() < 0.1)
}

test "bbox center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = bbox_center(poly)
  assert_true((c.x() - 3.0).abs() < 0.01)
  assert_true((c.y() - 2.0).abs() < 0.01)
}

test "vertex center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = vertex_center(poly)
  assert_true((c.x() - 2.0).abs() < 0.01)
}

test "inradius" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let r = inradius(poly)
  assert_true(r > 0.0)
}
test "convex centroid empty" {
  let poly = @core.Polygon::new([])
  let c = convex_centroid(poly)
  assert_true(c.x() == 0.0 && c.y() == 0.0)
}

test "convex centroid single" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 5.0)])
  let c = convex_centroid(poly)
  assert_true((c.x() - 3.0).abs() < 0.001)
  assert_true((c.y() - 5.0).abs() < 0.001)
}

test "convex centroid degenerate collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let c = convex_centroid(poly)
  assert_true((c.x() - 2.0).abs() < 0.001)
  assert_true((c.y() - 2.0).abs() < 0.001)
}

test "bbox center empty" {
  let poly = @core.Polygon::new([])
  let c = bbox_center(poly)
  assert_true(c.x() == 0.0 && c.y() == 0.0)
}

test "bbox center single" {
  let poly = @core.Polygon::new([@core.Point2D::new(7.0, 8.0)])
  let c = bbox_center(poly)
  assert_true((c.x() - 7.0).abs() < 0.001)
  assert_true((c.y() - 8.0).abs() < 0.001)
}

test "vertex center empty" {
  let poly = @core.Polygon::new([])
  let c = vertex_center(poly)
  assert_true(c.x() == 0.0 && c.y() == 0.0)
}

test "chebyshev center empty" {
  let poly = @core.Polygon::new([])
  let c = chebyshev_center(poly)
  assert_true(c.x() == 0.0 && c.y() == 0.0)
}

test "inradius small polygon" {
  let poly = @core.Polygon::new([@core.Point2D::new(1.0, 1.0)])
  assert_true(inradius(poly) == 0.0)
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ])
  assert_true(inradius(poly2) == 0.0)
}

test "inradius triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let r = inradius(poly)
  assert_true(r > 0.0)
}