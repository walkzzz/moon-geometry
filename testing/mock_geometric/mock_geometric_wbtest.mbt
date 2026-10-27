///|
test "wb fake RNG negative value handling" {
  let rng = FakeRNG::new(3)
  let v = rng.next()
  assert_true(v >= 0)
}

///|
test "wb fake RNG next point" {
  let rng = FakeRNG::new(42)
  let p = rng.next_point(-10.0, 10.0)
  assert_true(p.x() >= -10.0 && p.x() < 10.0)
  assert_true(p.y() >= -10.0 && p.y() < 10.0)
}

///|
test "wb fake RNG next points" {
  let rng = FakeRNG::new(42)
  let pts = rng.next_points(5, -10.0, 10.0)
  assert_eq(pts.length(), 5)
  for i in 0..<5 {
    assert_true(pts[i].x() >= -10.0 && pts[i].x() < 10.0)
  }
}

///|
test "wb stub identity" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = stub_identity(p)
  assert_eq(q.x(), 3.0)
  assert_eq(q.y(), 4.0)
}

///|
test "wb mock grid points single" {
  let pts = mock_grid_points(1, 1, 5.0)
  assert_eq(pts.length(), 1)
  assert_eq(pts[0].x(), 0.0)
  assert_eq(pts[0].y(), 0.0)
}

///|
test "wb mock circle points single" {
  let pts = mock_circle_points(2.0, 3.0, 5.0, 1)
  assert_eq(pts.length(), 1)
  assert_true((pts[0].x() - 7.0).abs() < 0.001)
  assert_true((pts[0].y() - 3.0).abs() < 0.001)
}

///|
test "wb mock collinear points zero" {
  let pts = mock_collinear_points(0, 2.0, 3.0)
  assert_eq(pts.length(), 0)
}

///|
test "wb fake RNG next double positive range" {
  let rng = FakeRNG::new(42)
  let v = rng.next_double(0.0, 1.0)
  assert_true(v >= 0.0 && v < 1.0)
}

///|
test "wb stub manhattan distance same point" {
  let a = @core.Point2D::new(5.0, 5.0)
  assert_eq(stub_manhattan_distance(a, a), 0.0)
}
