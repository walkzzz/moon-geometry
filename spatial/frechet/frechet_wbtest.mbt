///|
test "frechet_distance_identical" {
  let c = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  assert_true((frechet_distance(c, c) - 0.0).abs() < 0.001)
}

///|
test "frechet_distance_translated" {
  let c1 = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let c2 = [@core.Point2D::new(0.0, 1.0), @core.Point2D::new(1.0, 1.0)]
  assert_true((frechet_distance(c1, c2) - 1.0).abs() < 0.001)
}

///|
test "frechet_within" {
  let c1 = [@core.Point2D::new(0.0, 0.0)]
  let c2 = [@core.Point2D::new(0.0, 0.5)]
  assert_true(frechet_within(c1, c2, 1.0))
  assert_false(frechet_within(c1, c2, 0.1))
}

///|
test "frechet_point_distance" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(3.0, 4.0)
  assert_true((frechet_point_distance(p1, p2) - 5.0).abs() < 0.001)
}

///|
test "frechet_distance_empty" {
  let c : Array[@core.Point2D] = []
  assert_true(frechet_distance(c, c) == 0.0)
}

///|
test "frechet_distance single to single" {
  let c1 = [@core.Point2D::new(0.0, 0.0)]
  let c2 = [@core.Point2D::new(3.0, 4.0)]
  assert_true((frechet_distance(c1, c2) - 5.0).abs() < 0.001)
}

///|
test "frechet_distance multi point" {
  let c1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let c2 = [
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
  ]
  assert_true((frechet_distance(c1, c2) - 1.0).abs() < 0.001)
}

///|
test "frechet_distance single to multi" {
  let c1 = [@core.Point2D::new(0.0, 0.0)]
  let c2 = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(3.0, 4.0)]
  // Fréchet from single point to curve = max distance to any point
  assert_true((frechet_distance(c1, c2) - 5.0).abs() < 0.001)
}

///|
test "frechet_distance reversed curve" {
  let c1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let c2 = [
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  assert_true((frechet_distance(c1, c2) - 2.0).abs() < 0.001)
}

///|
test "frechet_within boundary equal" {
  let c1 = [@core.Point2D::new(0.0, 0.0)]
  let c2 = [@core.Point2D::new(0.0, 1.0)]
  // distance == 1.0, eps == 1.0 → within (<=)
  assert_true(frechet_within(c1, c2, 1.0))
}

///|
test "frechet_distance one empty one not" {
  let c1 : Array[@core.Point2D] = []
  let c2 = [@core.Point2D::new(1.0, 1.0)]
  assert_true(frechet_distance(c1, c2) == 0.0)
}
