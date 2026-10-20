test "gaussian_kernel basic" {
  let v = gaussian_kernel(0.0, 1.0)
  assert_true(v > 0.39 && v < 0.40)
}
test "epanechnikov zero" {
  let v = epanechnikov_kernel(0.0, 1.0)
  assert_true(v > 0.74 && v < 0.76)
}
test "silverman bandwidth" {
  let h = silverman_bandwidth(100, 1.0)
  assert_true(h > 0.0)
}
