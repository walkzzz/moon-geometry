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
