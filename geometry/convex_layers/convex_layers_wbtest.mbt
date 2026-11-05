///|
test "convex layers basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let layers = convex_layers(pts)
  assert_true(layers.length() >= 1)
}

///|
test "layer count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_eq(layer_count(pts), 1)
}

///|
test "outermost layer" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let outer = outermost_layer(pts)
  assert_eq(outer.length(), 4)
}

///|
test "convex layers nested" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(8.0, 8.0),
    @core.Point2D::new(0.0, 8.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ]
  let layers = convex_layers(pts)
  assert_true(layers.length() >= 2)
}

///|
test "convex layers triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  assert_eq(layer_count(pts), 1)
}

///|
test "convex layers collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let layers = convex_layers(pts)
  assert_eq(layers.length(), 0)
}

///|
test "convex layers same x different y" {
  let pts = [
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
  ]
  let layers = convex_layers(pts)
  assert_true(layers.length() >= 1)
}

///|
test "convex layers duplicate points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let layers = convex_layers(pts)
  ignore(layers)
}

///|
test "outermost layer too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let outer = outermost_layer(pts)
  assert_eq(outer.length(), 0)
}
