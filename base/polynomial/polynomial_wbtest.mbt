///|
test "poly_eval basic" {
  let coeffs = [1.0, 2.0, 3.0]
  let result = poly_eval(coeffs, 2.0)
  assert_true((result - 17.0).abs() < 0.001)
}

///|
test "poly_derivative basic" {
  let coeffs = [1.0, 2.0, 3.0]
  let deriv = poly_derivative(coeffs)
  assert_eq(deriv.length(), 2)
  assert_true((deriv[0] - 2.0).abs() < 0.001)
  assert_true((deriv[1] - 6.0).abs() < 0.001)
}

///|
test "poly_add basic" {
  let a = [1.0, 2.0, 3.0]
  let b = [4.0, 5.0]
  let result = poly_add(a, b)
  assert_true((result[0] - 5.0).abs() < 0.001)
  assert_true((result[1] - 7.0).abs() < 0.001)
}

///|
test "poly_mul basic" {
  let a = [1.0, 1.0]
  let b = [1.0, -1.0]
  let result = poly_mul(a, b)
  assert_true((result[0] - 1.0).abs() < 0.001)
  assert_true((result[1] - 0.0).abs() < 0.001)
  assert_true((result[2] - -1.0).abs() < 0.001)
}

///|
test "poly_roots quadratic" {
  let coeffs = [-6.0, 5.0, 1.0]
  let roots = poly_roots(coeffs)
  assert_eq(roots.length(), 2)
}

///|
test "poly_eval empty" {
  assert_eq(poly_eval([], 5.0), 0.0)
}

///|
test "poly_eval constant" {
  assert_true((poly_eval([42.0], 7.0) - 42.0).abs() < 0.001)
}

///|
test "poly_eval zero x" {
  let coeffs = [3.0, 2.0, 1.0]
  assert_true((poly_eval(coeffs, 0.0) - 3.0).abs() < 0.001)
}

///|
test "poly_eval negative x" {
  let coeffs = [1.0, 0.0, 1.0]
  let result = poly_eval(coeffs, -2.0)
  assert_true((result - 5.0).abs() < 0.001)
}

///|
test "poly_derivative constant" {
  let deriv = poly_derivative([5.0])
  assert_eq(deriv.length(), 1)
  assert_eq(deriv[0], 0.0)
}

///|
test "poly_derivative empty" {
  let deriv = poly_derivative([])
  assert_eq(deriv.length(), 1)
  assert_eq(deriv[0], 0.0)
}

///|
test "poly_derivative linear" {
  let deriv = poly_derivative([3.0, 7.0])
  assert_eq(deriv.length(), 1)
  assert_true((deriv[0] - 7.0).abs() < 0.001)
}

///|
test "poly_add same length" {
  let a = [1.0, 2.0, 3.0]
  let b = [4.0, 5.0, 6.0]
  let r = poly_add(a, b)
  assert_true((r[0] - 5.0).abs() < 0.001)
  assert_true((r[1] - 7.0).abs() < 0.001)
  assert_true((r[2] - 9.0).abs() < 0.001)
}

///|
test "poly_add empty" {
  let r = poly_add([], [])
  assert_eq(r.length(), 0)
}

///|
test "poly_add first longer" {
  let a = [1.0, 2.0, 3.0, 4.0]
  let b = [10.0, 20.0]
  let r = poly_add(a, b)
  assert_eq(r.length(), 4)
  assert_true((r[0] - 11.0).abs() < 0.001)
  assert_true((r[2] - 3.0).abs() < 0.001)
  assert_true((r[3] - 4.0).abs() < 0.001)
}

///|
test "poly_mul by constant" {
  let a = [2.0, 4.0, 6.0]
  let b = [1.0]
  let r = poly_mul(a, b)
  assert_eq(r.length(), 3)
  assert_true((r[0] - 2.0).abs() < 0.001)
  assert_true((r[1] - 4.0).abs() < 0.001)
  assert_true((r[2] - 6.0).abs() < 0.001)
}

///|
test "poly_mul quadratic" {
  let a = [1.0, 2.0, 1.0]
  let b = [1.0, 1.0]
  let r = poly_mul(a, b)
  assert_eq(r.length(), 4)
  assert_true((r[0] - 1.0).abs() < 0.001)
  assert_true((r[1] - 3.0).abs() < 0.001)
  assert_true((r[2] - 3.0).abs() < 0.001)
  assert_true((r[3] - 1.0).abs() < 0.001)
}

///|
test "poly_roots empty" {
  assert_eq(poly_roots([]).length(), 0)
}

///|
test "poly_roots constant" {
  assert_eq(poly_roots([5.0]).length(), 0)
}

///|
test "poly_roots linear" {
  let roots = poly_roots([-4.0, 2.0])
  assert_eq(roots.length(), 1)
  assert_true((roots[0] - 2.0).abs() < 0.001)
}

///|
test "poly_roots no real roots" {
  let coeffs = [1.0, 0.0, 1.0]
  let roots = poly_roots(coeffs)
  assert_eq(roots.length(), 0)
}

///|
test "poly_roots repeated root" {
  let coeffs = [1.0, -2.0, 1.0]
  let roots = poly_roots(coeffs)
  assert_eq(roots.length(), 2)
  assert_true((roots[0] - 1.0).abs() < 0.01)
  assert_true((roots[1] - 1.0).abs() < 0.01)
}

///|
test "poly_roots trailing zeros" {
  let coeffs = [1.0, 0.0, -1.0, 0.0, 0.0]
  let roots = poly_roots(coeffs)
  ignore(roots)
}
