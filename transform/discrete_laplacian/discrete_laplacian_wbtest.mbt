test "uniform_laplacian" {
  let l = uniform_laplacian([5.0], [3.0, 7.0])
  assert_true(l.abs() < 0.001)
}

test "cotangent_weight" {
  assert_true((cotangent_weight(1.0, 1.0) - 1.0).abs() < 0.001)
}

test "is_harmonic" {
  assert_true(is_harmonic(0.0001, 0.01))
}
test "uniform_laplacian_empty" {
  let l = uniform_laplacian([1.0], [])
  assert_true(l.abs() < 0.001)
}

test "uniform_laplacian_nonzero" {
  let l = uniform_laplacian([0.0], [2.0, 4.0])
  assert_true((l - 3.0).abs() < 0.001)
}

test "cotangent_weight_general" {
  let w = cotangent_weight(2.0, 4.0)
  assert_true((w - 3.0).abs() < 0.001)
}

test "cotangent_laplacian" {
  let l = cotangent_laplacian(0.0, [1.0, -1.0], [1.0, 1.0])
  assert_true(l.abs() < 0.001)
}

test "cotangent_laplacian_empty" {
  let l = cotangent_laplacian(1.0, [], [])
  assert_true(l.abs() < 0.001)
}

test "cotangent_laplacian_zero_weights" {
  let l = cotangent_laplacian(0.0, [1.0, -1.0], [0.0, 0.0])
  assert_true(l.abs() < 0.001)
}

test "laplacian_eigenvalue" {
  let e = laplacian_eigenvalue(1, 1.0)
  assert_true(e > 9.0 && e < 10.0)
}

test "laplacian_eigenvalue_zero_area" {
  let e = laplacian_eigenvalue(1, 0.0)
  assert_true(e.abs() < 0.001)
}

test "laplacian_eigenvalue_mode2" {
  let e1 = laplacian_eigenvalue(1, 1.0)
  let e2 = laplacian_eigenvalue(2, 1.0)
  assert_true((e2 - 4.0 * e1).abs() < 0.001)
}

test "is_harmonic_false" {
  assert_false(is_harmonic(1.0, 0.01))
}
