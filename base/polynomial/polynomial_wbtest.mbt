test "poly_eval basic" {
  let coeffs = [1.0, 2.0, 3.0]
  let result = poly_eval(coeffs, 2.0)
  assert_true((result - 17.0).abs() < 0.001)
}

test "poly_derivative basic" {
  let coeffs = [1.0, 2.0, 3.0]
  let deriv = poly_derivative(coeffs)
  assert_eq(deriv.length(), 2)
  assert_true((deriv[0] - 2.0).abs() < 0.001)
  assert_true((deriv[1] - 6.0).abs() < 0.001)
}

test "poly_add basic" {
  let a = [1.0, 2.0, 3.0]
  let b = [4.0, 5.0]
  let result = poly_add(a, b)
  assert_true((result[0] - 5.0).abs() < 0.001)
  assert_true((result[1] - 7.0).abs() < 0.001)
}

test "poly_mul basic" {
  let a = [1.0, 1.0]
  let b = [1.0, -1.0]
  let result = poly_mul(a, b)
  assert_true((result[0] - 1.0).abs() < 0.001)
  assert_true((result[1] - 0.0).abs() < 0.001)
  assert_true((result[2] - (-1.0)).abs() < 0.001)
}

test "poly_roots quadratic" {
  let coeffs = [-6.0, 5.0, 1.0]
  let roots = poly_roots(coeffs)
  assert_eq(roots.length(), 2)
}
test "poly_eval empty" {
  let result = poly_eval([], 2.0)
  assert_true((result - 0.0).abs() < 0.001)
}

test "poly_eval constant" {
  let result = poly_eval([5.0], 100.0)
  assert_true((result - 5.0).abs() < 0.001)
}

test "poly_eval single" {
  let result = poly_eval([3.0, 2.0], 4.0)
  assert_true((result - 11.0).abs() < 0.001)
}

test "poly_derivative constant" {
  let deriv = poly_derivative([7.0])
  assert_eq(deriv.length(), 1)
  assert_true((deriv[0] - 0.0).abs() < 0.001)
}

test "poly_derivative empty" {
  let deriv = poly_derivative([])
  assert_eq(deriv.length(), 1)
  assert_true((deriv[0] - 0.0).abs() < 0.001)
}

test "poly_add equal length" {
  let a = [1.0, 2.0, 3.0]
  let b = [4.0, 5.0, 6.0]
  let result = poly_add(a, b)
  assert_true((result[0] - 5.0).abs() < 0.001)
  assert_true((result[1] - 7.0).abs() < 0.001)
  assert_true((result[2] - 9.0).abs() < 0.001)
}

test "poly_mul by zero" {
  let a = [1.0, 2.0]
  let b = [0.0]
  let result = poly_mul(a, b)
  assert_true((result[0] - 0.0).abs() < 0.001)
  assert_true((result[1] - 0.0).abs() < 0.001)
}

test "poly_roots linear" {
  let roots = poly_roots([-2.0, 1.0])
  assert_eq(roots.length(), 1)
  assert_true((roots[0] - 2.0).abs() < 0.001)
}

test "poly_roots no real roots" {
  let roots = poly_roots([1.0, 0.0, 1.0])
  assert_eq(roots.length(), 0)
}

test "poly_roots constant" {
  let roots = poly_roots([5.0])
  assert_eq(roots.length(), 0)
}

test "poly_roots empty" {
  let roots = poly_roots([])
  assert_eq(roots.length(), 0)
}