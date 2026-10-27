///|
test "resultant sylvester matrix" {
  let p = [1.0, 2.0]
  let q = [3.0, 4.0]
  let m = sylvester_matrix(p, q)
  assert_eq(m.length(), 2)
  assert_true((m[0][0] - 1.0).abs() < 0.000000001)
  assert_true((m[0][1] - 2.0).abs() < 0.000000001)
}

///|
test "resultant matrix determinant 2x2" {
  let m = [[1.0, 2.0], [3.0, 4.0]]
  let d = matrix_determinant(m)
  assert_true((d - -2.0).abs() < 0.000000001)
}

///|
test "resultant matrix determinant 3x3" {
  let m = [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  let d = matrix_determinant(m)
  assert_true((d - 1.0).abs() < 0.000000001)
}

///|
test "resultant no common root" {
  let p = [-2.0, 1.0]
  let q = [-3.0, 1.0]
  let r = resultant(p, q)
  assert_true(r.abs() > 0.000000001)
}

///|
test "resultant common root" {
  let p = [-2.0, 1.0]
  let q = [-2.0, 1.0]
  let r = resultant(p, q)
  assert_true(r.abs() < 0.000000001)
}

///|
test "resultant common root quadratic" {
  let p = [-6.0, 5.0, 1.0]
  let q = [-1.0, 1.0]
  let r = resultant(p, q)
  assert_true(r.abs() < 0.0000001)
}

///|
test "discriminant quadratic" {
  let coeffs = [-6.0, 5.0, 1.0]
  let d = discriminant(coeffs)
  assert_true((d - 49.0).abs() < 0.0000001)
}

///|
test "discriminant zero repeated root" {
  let coeffs = [1.0, -2.0, 1.0]
  let d = discriminant(coeffs)
  assert_true(d.abs() < 0.0000001)
}

///|
test "poly degree" {
  assert_eq(poly_degree([1.0, 2.0, 3.0]), 2)
  assert_eq(poly_degree([1.0, 2.0, 0.0]), 1)
  assert_eq(poly_degree([0.0, 0.0]), -1)
}

///|
test "poly sub" {
  let a = [5.0, 7.0, 9.0]
  let b = [1.0, 2.0]
  let r = poly_sub(a, b)
  assert_true((r[0] - 4.0).abs() < 0.000000001)
  assert_true((r[1] - 5.0).abs() < 0.000000001)
  assert_true((r[2] - 9.0).abs() < 0.000000001)
}

///|
test "poly gcd common factor" {
  let a = [-1.0, 0.0, 1.0]
  let b = [-1.0, 1.0]
  let g = poly_gcd(a, b)
  assert_true(poly_degree(g) >= 0)
}

///|
test "have common root" {
  let p = [-2.0, 1.0]
  let q = [-2.0, 1.0]
  assert_true(have_common_root(p, q, 0.0000001))
  let r = [-3.0, 1.0]
  assert_false(have_common_root(p, r, 0.0000001))
}

///|
test "matrix_determinant empty" {
  let d = matrix_determinant([])
  assert_true((d - 1.0).abs() < 0.000000001)
}

///|
test "matrix_determinant singular" {
  let m = [[1.0, 2.0], [2.0, 4.0]]
  let d = matrix_determinant(m)
  assert_true(d.abs() < 0.000000001)
}

///|
test "matrix_determinant pivot swap 3x3" {
  let m = [[0.0, 1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 0.0, 1.0]]
  let d = matrix_determinant(m)
  assert_true((d + 1.0).abs() < 0.000000001)
}

///|
test "matrix_determinant 1x1" {
  let m = [[5.0]]
  let d = matrix_determinant(m)
  assert_true((d - 5.0).abs() < 0.000000001)
}

///|
test "resultant zero polynomial" {
  let r = resultant([0.0], [1.0, 2.0])
  assert_true(r.abs() < 0.000000001)
}

///|
test "resultant both constants" {
  let r = resultant([2.0], [3.0])
  assert_true((r - 1.0).abs() < 0.000000001)
}

///|
test "resultant p constant" {
  let r = resultant([2.0], [1.0, 1.0])
  assert_true((r - 2.0).abs() < 0.000000001)
}

///|
test "resultant q constant" {
  let r = resultant([1.0, 1.0], [2.0])
  assert_true((r - 2.0).abs() < 0.000000001)
}

///|
test "discriminant linear" {
  let d = discriminant([1.0, 2.0])
  assert_true(d.abs() < 0.000000001)
}

///|
test "discriminant constant" {
  let d = discriminant([5.0])
  assert_true(d.abs() < 0.000000001)
}

///|
test "discriminant cubic odd degree" {
  // x^3 - x = x(x-1)(x+1), discriminant = 4 (sign-independent via square)
  let d = discriminant([0.0, -1.0, 0.0, 1.0])
  assert_true((d * d - 16.0).abs() < 0.5)
}

///|
test "poly_gcd both zero" {
  let g = poly_gcd([0.0], [0.0])
  assert_eq(poly_degree(g), -1)
}

///|
test "poly_gcd zero and constant" {
  let g = poly_gcd([0.0], [1.0])
  assert_eq(poly_degree(g), 0)
}

///|
test "poly_gcd coprime" {
  // x^2 + 1 and x + 1 are coprime -> gcd is a constant
  let g = poly_gcd([1.0, 0.0, 1.0], [1.0, 1.0])
  assert_eq(poly_degree(g), 0)
}

///|
test "poly_sub b longer" {
  let a = [1.0]
  let b = [1.0, 2.0, 3.0]
  let r = poly_sub(a, b)
  assert_true(r[0].abs() < 0.000000001)
  assert_true((r[1] + 2.0).abs() < 0.000000001)
  assert_true((r[2] + 3.0).abs() < 0.000000001)
}

///|
test "sylvester_matrix 3x3" {
  let p = [1.0, 0.0, 1.0]
  let q = [1.0, 1.0]
  let m = sylvester_matrix(p, q)
  assert_eq(m.length(), 3)
  assert_eq(m[0].length(), 3)
}

///|
test "poly_degree empty" {
  assert_eq(poly_degree([0.0]), -1)
}

///|
test "have_common_root no common" {
  // x^2 - 1 = (x-1)(x+1) and x + 2 share no root
  let p = [1.0, 0.0, -1.0]
  let q = [2.0, 1.0]
  assert_false(have_common_root(p, q, 0.0000001))
}
