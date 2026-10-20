test "gauss_bonnet_check" {
  assert_true(gauss_bonnet_check(12.566370614359172, 2))
}

test "euler_from_curvature" {
  assert_eq(euler_from_curvature(12.566370614359172), 2)
}

test "total_gaussian_curvature" {
  assert_true((total_gaussian_curvature([1.0, 2.0, 3.0]) - 6.0).abs() < 0.001)
}
