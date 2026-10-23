///|
test "convex diameter square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let d = convex_diameter(poly)
  assert_true((d - 5.6569).abs() < 0.01)
}

///|
test "convex diameter pair" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let (p1, p2) = convex_diameter_pair(poly)
  assert_true(p1.dist(p2) > 5.0)
}

///|
test "convex radius lower bound" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let r = convex_radius_lower_bound(poly)
  assert_true(r > 2.0)
}

///|
test "antipodal pairs" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let pairs = antipodal_pairs(poly)
  assert_true(pairs.length() >= 4)
}

///|
test "convex diameter triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let d = convex_diameter(poly)
  assert_true((d - 6.0).abs() < 0.01)
}
