///|
test "MedialBall3D construct" {
  let c = @core.Point3D::new(1.0, 2.0, 3.0)
  let ball = MedialBall3D::new(c, 5.0)
  assert_true((ball.radius() - 5.0).abs() < 0.0001)
  assert_true((ball.center().x - 1.0).abs() < 0.0001)
}

///|
test "medial_axis_from_pairs basic" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let balls = medial_axis_from_pairs(pts)
  assert_true(balls.length() == 1)
  assert_true((balls[0].radius() - 1.0).abs() < 0.001)
}

///|
test "medial_axis_from_pairs triangle" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.7320508, 0.0),
  ]
  let balls = medial_axis_from_pairs(pts)
  assert_true(balls.length() >= 1)
}

///|
test "medial_axis_from_triples basic" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.7320508, 0.0),
  ]
  let balls = medial_axis_from_triples(pts)
  assert_true(balls.length() >= 1)
}

///|
test "medial_axis_3d combined" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.7320508, 0.0),
    @core.Point3D::new(1.0, 0.5773503, 1.6329932),
  ]
  let balls = medial_axis_3d(pts)
  assert_true(balls.length() >= 1)
}

///|
test "medial_axis_filter basic" {
  let balls : Array[MedialBall3D] = [
    MedialBall3D::new(@core.Point3D::new(0.0, 0.0, 0.0), 1.0),
    MedialBall3D::new(@core.Point3D::new(0.0, 0.0, 0.0), 3.0),
    MedialBall3D::new(@core.Point3D::new(0.0, 0.0, 0.0), 5.0),
  ]
  let filtered = medial_axis_filter(balls, 2.0, 4.0)
  assert_true(filtered.length() == 1)
}

///|
test "medial_axis_sort basic" {
  let balls : Array[MedialBall3D] = [
    MedialBall3D::new(@core.Point3D::new(0.0, 0.0, 0.0), 1.0),
    MedialBall3D::new(@core.Point3D::new(0.0, 0.0, 0.0), 5.0),
    MedialBall3D::new(@core.Point3D::new(0.0, 0.0, 0.0), 3.0),
  ]
  let sorted = medial_axis_sort(balls)
  assert_true((sorted[0].radius() - 5.0).abs() < 0.0001)
  assert_true((sorted[1].radius() - 3.0).abs() < 0.0001)
  assert_true((sorted[2].radius() - 1.0).abs() < 0.0001)
}

///|
test "medial_axis_from_pairs collinear" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let balls = medial_axis_from_pairs(pts)
  assert_true(balls.length() >= 1)
}

///|
test "medial_axis_3d empty" {
  let balls = medial_axis_3d([])
  assert_true(balls.length() == 0)
}
