test "solve_linear basic" {
  let a = [[2.0, 1.0], [1.0, 3.0]]
  let b = [3.0, 4.0]
  let x = solve_linear(a, b, 2)
  assert_eq(x.length(), 2)
  assert_true((2.0 * x[0] + x[1] - 3.0).abs() < 0.001)
  assert_true((x[0] + 3.0 * x[1] - 4.0).abs() < 0.001)
}

test "determinant basic" {
  let a = [[1.0, 2.0], [3.0, 4.0]]
  let det = determinant(a, 2)
  assert_true((det - (-2.0)).abs() < 0.001)
}

test "matrix_inverse basic" {
  let a = [[2.0, 0.0], [0.0, 4.0]]
  let inv = matrix_inverse(a, 2)
  match inv {
    Some(m) => {
      assert_true((m[0][0] - 0.5).abs() < 0.001)
      assert_true((m[1][1] - 0.25).abs() < 0.001)
    }
    None => assert_true(false)
  }
}

test "solve_linear singular" {
  let a = [[1.0, 2.0], [2.0, 4.0]]
  let b = [1.0, 2.0]
  let x = solve_linear(a, b, 2)
  assert_eq(x.length(), 0)
}

test "determinant identity" {
  let a = [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  let det = determinant(a, 3)
  assert_true((det - 1.0).abs() < 0.001)
}