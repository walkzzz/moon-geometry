test "laplacian spectrum 1d" {
  let s = laplacian_spectrum_1d(3, 1.0)
  assert_true(s[0] > 9.0 && s[0] < 10.0)
}

test "weyl law 2d" {
  let n = weyl_law_2d(100.0, 4.0 * @math.PI)
  assert_eq(n, 100.0)
}

test "heat trace" {
  let r = heat_trace([1.0, 2.0, 3.0], 0.0)
  assert_eq(r, 3.0)
}
