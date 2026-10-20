test "fxaa_luma" {
  let l = fxaa_luma((1.0, 1.0, 1.0))
  assert_true(l > 0.99 && l < 1.01)
}
test "msaa_average" {
  let c = msaa_average([(1.0, 0.0, 0.0), (0.0, 1.0, 0.0)])
  assert_true(c.0 > 0.49 && c.0 < 0.51)
}
test "taa_resolve" {
  let c = taa_resolve((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), 0.5)
  assert_true(c.0 > 0.49 && c.0 < 0.51)
  assert_true(c.2 > 0.49 && c.2 < 0.51)
}
