///| Preset: degenerate (all same point) | 预设：退化点集
pub fn preset_degenerate() -> Array[@core.Point2D] {
  [
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(3.0, 3.0),
  ]
}

// ============================================================
// 5. Mock Tests | 模拟测试
// ============================================================

test "mock grid points" {
  let pts = mock_grid_points(3, 3, 2.0)
  assert_eq(pts.length(), 9)
  assert_eq(pts[0].x(), 0.0)
  assert_eq(pts[0].y(), 0.0)
  assert_eq(pts[8].x(), 4.0)
  assert_eq(pts[8].y(), 4.0)
}

test "mock circle points" {
  let pts = mock_circle_points(0.0, 0.0, 5.0, 4)
  assert_eq(pts.length(), 4)
  assert_true(pts[0].x() > 4.99 && pts[0].x() < 5.01)
  assert_true(pts[0].y() > -0.01 && pts[0].y() < 0.01)
}

test "mock regular polygon" {
  let poly = mock_regular_polygon(0.0, 0.0, 3.0, 6)
  assert_eq(poly.size(), 6)
}

test "mock square" {
  let poly = mock_square(5.0)
  assert_eq(poly.size(), 4)
  let area = @polygon.polygon_area(poly)
  assert_true(area > 24.99 && area < 25.01)
}

test "mock triangle" {
  let poly = mock_triangle(6.0, 4.0)
  assert_eq(poly.size(), 3)
  let area = @polygon.polygon_area(poly)
  assert_true(area > 11.99 && area < 12.01)
}

test "fake RNG reproducibility" {
  let rng1 = FakeRNG::new(42)
  let rng2 = FakeRNG::new(42)
  assert_eq(rng1.next(), rng2.next())
  assert_eq(rng1.next(), rng2.next())
}

test "fake RNG range" {
  let rng = FakeRNG::new(123)
  for _ in 0..<100 {
    let v = rng.next_double(-10.0, 10.0)
    assert_true(v >= -10.0 && v < 10.0)
  }
}

test "stub manhattan distance" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(3.0, 4.0)
  assert_eq(stub_manhattan_distance(a, b), 7.0)
}

test "stub zero distance" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(7.0, 1.0)
  assert_eq(stub_zero_distance(a, b), 0.0)
}

test "preset star points" {
  let pts = preset_star_points()
  assert_eq(pts.length(), 8)
}

test "preset L-shape" {
  let pts = preset_l_shape()
  assert_eq(pts.length(), 6)
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() >= 4)
}

test "preset degenerate" {
  let pts = preset_degenerate()
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 3)
}

test "mock collinear points" {
  let pts = mock_collinear_points(5, 2.0, 3.0)
  assert_eq(pts.length(), 5)
  assert_eq(pts[0].x(), 0.0)
  assert_eq(pts[4].x(), 8.0)
}