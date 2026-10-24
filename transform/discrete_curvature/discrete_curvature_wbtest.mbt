///|
test "discrete_gaussian_curvature" {
  assert_true((discrete_gaussian_curvature(0.5) - 0.5).abs() < 0.001)
}

///|
test "angle_defect" {
  let ad = angle_defect([
    1.5707963267948966, 1.5707963267948966, 1.5707963267948966,
  ])
  assert_true(ad > 0.5)
}

///|
test "voronoi_area" {
  assert_true((voronoi_area(2.0) - 0.5).abs() < 0.001)
}

///|
test "discrete_mean_curvature" {
  let h = discrete_mean_curvature(1.0, [1.0, 2.0], [0.5, 0.5])
  assert_true((h - 0.375).abs() < 0.001)
}

///|
test "discrete_mean_curvature empty edges" {
  let h = discrete_mean_curvature(1.0, [], [])
  assert_true(h.abs() < 0.0001)
}

///|
test "discrete_mean_curvature zero area" {
  let h = discrete_mean_curvature(0.0, [1.0, 2.0], [0.5, 0.5])
  assert_true(h.abs() < 0.0001)
}

///|
test "mixed_area" {
  assert_true((mixed_area(2.0, 4.0) - 3.0).abs() < 0.001)
}
