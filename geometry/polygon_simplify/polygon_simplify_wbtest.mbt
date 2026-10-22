test "simplify_topology_preserve basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_topology_preserve(pts, 0.1)
  assert_true(result.length() <= pts.length())
}

test "simplify_visvalingam basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_visvalingam(pts, 4)
  assert_eq(result.length(), 4)
}

test "douglas_peucker basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = douglas_peucker(pts, 0.1)
  assert_true(result.length() < pts.length())
}

test "simplify_topology_preserve small" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let result = simplify_topology_preserve(pts, 0.1)
  assert_eq(result.length(), 3)
}

test "simplify_visvalingam target too large" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_visvalingam(pts, 10)
  assert_eq(result.length(), 4)
}