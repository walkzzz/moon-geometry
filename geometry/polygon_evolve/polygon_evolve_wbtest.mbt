test "curve_shortening_flow basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let flow = curve_shortening_flow(pts, 5, 0.01)
  assert_eq(flow.length(), 5)
}

test "evolve_step basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let next = evolve_step(pts, 0.01)
  assert_eq(next.length(), 4)
}

test "flow_perimeters decreasing" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let perims = flow_perimeters(pts, 10, 0.01)
  assert_true(perims.length() == 10)
}

test "flow_areas basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let areas = flow_areas(pts, 5, 0.01)
  assert_true(areas.length() == 5)
}

test "evolve_step degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let next = evolve_step(pts, 0.01)
  assert_eq(next.length(), 2)
}