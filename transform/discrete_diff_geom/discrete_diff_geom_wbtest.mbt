///|
test "discrete connection" {
  let r = discrete_connection([1.0, 2.0, 3.0])
  assert_eq(r, 6.0)
}

///|
test "parallel transport" {
  let (x, y) = parallel_transport(1.0, 0.0, 1.5707963267948966)
  assert_true(x.abs() < 0.0001)
  assert_true(y > 0.99)
}

///|
test "discrete curvature" {
  let k = discrete_curvature2d([1.0, 1.0, 1.0])
  let expected = 2.0 * @math.PI - 3.0
  assert_true((k - expected).abs() < 1.0e-10)
}
