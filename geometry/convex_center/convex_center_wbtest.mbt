///|
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

///|
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

///|
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

///|
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

///|
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

///|
test "convex centroid empty" {
  let poly = @core.Polygon::new([])
  let c = convex_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 0.0, 0.000000001))
}

///|
test "convex centroid single vertex" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 5.0)])
  let c = convex_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 3.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 5.0, 0.000000001))
}

///|
test "convex centroid degenerate collinear" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ])
  let c = convex_centroid(poly)
  assert_true(@core.approx_eq(c.x(), 1.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 1.0, 0.000000001))
}

///|
test "bbox center empty" {
  let poly = @core.Polygon::new([])
  let c = bbox_center(poly)
  assert_true(@core.approx_eq(c.x(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 0.0, 0.000000001))
}

///|
test "bbox center single vertex" {
  let poly = @core.Polygon::new([@core.Point2D::new(3.0, 5.0)])
  let c = bbox_center(poly)
  assert_true(@core.approx_eq(c.x(), 3.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 5.0, 0.000000001))
}

///|
test "vertex center empty" {
  let poly = @core.Polygon::new([])
  let c = vertex_center(poly)
  assert_true(@core.approx_eq(c.x(), 0.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 0.0, 0.000000001))
}

///|
test "vertex center single" {
  let poly = @core.Polygon::new([@core.Point2D::new(7.0, 8.0)])
  let c = vertex_center(poly)
  assert_true(@core.approx_eq(c.x(), 7.0, 0.000000001))
  assert_true(@core.approx_eq(c.y(), 8.0, 0.000000001))
}

///|
test "inradius degenerate" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ])
  let r = inradius(poly)
  assert_true(@core.approx_eq(r, 0.0, 0.000000001))
}

///|
test "inradius triangle" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 6.0),
  ])
  let r = inradius(poly)
  assert_true(r > 0.0)
}

///|
test "chebyshev center equals centroid" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 6.0),
  ])
  let cc = chebyshev_center(poly)
  let ce = convex_centroid(poly)
  assert_true(@core.approx_eq(cc.x(), ce.x(), 0.000000001))
  assert_true(@core.approx_eq(cc.y(), ce.y(), 0.000000001))
}
