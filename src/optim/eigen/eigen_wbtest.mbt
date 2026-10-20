test "power_iteration basic" {
  let matrix = [[2.0, 0.0], [0.0, 3.0]]
  let eigenvalue = power_iteration(matrix, 2, 100)
  assert_true((eigenvalue - 3.0).abs() < 0.1)
}

test "jacobi_eigenvalues basic" {
  let matrix = [[2.0, 1.0], [1.0, 2.0]]
  let eigenvalues = jacobi_eigenvalues(matrix, 2, 100)
  assert_eq(eigenvalues.length(), 2)
}

test "matrix_trace basic" {
  let matrix = [[1.0, 2.0], [3.0, 4.0]]
  let trace = matrix_trace(matrix, 2)
  assert_true((trace - 5.0).abs() < 0.001)
}

test "power_iteration diagonal" {
  let matrix = [[5.0, 0.0, 0.0], [0.0, 3.0, 0.0], [0.0, 0.0, 1.0]]
  let eigenvalue = power_iteration(matrix, 3, 100)
  assert_true((eigenvalue - 5.0).abs() < 0.1)
}

test "jacobi_eigenvalues diagonal" {
  let matrix = [[3.0, 0.0], [0.0, 7.0]]
  let eigenvalues = jacobi_eigenvalues(matrix, 2, 100)
  assert_true(eigenvalues[0].abs() + eigenvalues[1].abs() > 5.0)
}