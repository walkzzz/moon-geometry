test "lagrange_interp basic" {
  let xs = [0.0, 1.0, 2.0]
  let ys = [0.0, 1.0, 4.0]
  let result = lagrange_interp(xs, ys, 1.5)
  assert_true((result - 2.25).abs() < 0.001)
}

test "newton_interp basic" {
  let xs = [0.0, 1.0, 2.0]
  let ys = [0.0, 1.0, 4.0]
  let result = newton_interp(xs, ys, 1.5)
  assert_true((result - 2.25).abs() < 0.001)
}

test "linear_interp basic" {
  let result = linear_interp(0.0, 0.0, 2.0, 4.0, 1.0)
  assert_true((result - 2.0).abs() < 0.001)
}

test "bilinear_interp basic" {
  let result = bilinear_interp(0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 2.0, 0.5, 0.5)
  assert_true((result - 1.0).abs() < 0.001)
}

test "lagrange_interp exact" {
  let xs = [0.0, 1.0, 2.0]
  let ys = [0.0, 1.0, 4.0]
  let result = lagrange_interp(xs, ys, 0.0)
  assert_true(result.abs() < 0.001)
}