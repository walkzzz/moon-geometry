test "half_plane_contains" {
  let hp = HalfPlane::new(1.0, 0.0, -3.0)
  assert_true(HalfPlane::contains(hp, @core.Point2D::new(2.0, 0.0)))
  assert_false(HalfPlane::contains(hp, @core.Point2D::new(4.0, 0.0)))
}

test "half_plane_eval" {
  let hp = HalfPlane::new(1.0, 1.0, -5.0)
  let v = HalfPlane::eval(hp, @core.Point2D::new(2.0, 2.0))
  assert_true(@core.approx_eq(v, -1.0, 0.000000000001))
}

test "half_plane_intersect" {
  let planes = [
    HalfPlane::new(-1.0, 0.0, 0.0),
    HalfPlane::new(1.0, 0.0, -2.0),
    HalfPlane::new(0.0, -1.0, 0.0),
    HalfPlane::new(0.0, 1.0, -2.0),
  ]
  let result = half_plane_intersect(planes)
  assert_true(result.length() >= 3)
}

test "half_plane_from_line" {
  let line = @core.Line::new(1.0, 0.0, -3.0)
  let hp = HalfPlane::from_line_left(line)
  assert_true(HalfPlane::contains(hp, @core.Point2D::new(2.0, 0.0)))
}

test "half_plane_empty" {
  let planes = [
    HalfPlane::new(1.0, 0.0, -1.0),
    HalfPlane::new(-1.0, 0.0, 2.0),
  ]
  let result = half_plane_intersect(planes)
  assert_eq(result.length(), 0)
}