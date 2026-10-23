///|
test "element_stiffness" {
  let s = element_stiffness((1.0, 0.0), (1.0, 0.0), 0.5)
  assert_true((s - 0.5).abs() < 0.001)
}

///|
test "element_mass" {
  let m = element_mass(1.0, 1.0, 0.5)
  assert_true((m - 0.166667).abs() < 0.001)
}

///|
test "fem_l2_error" {
  let e = fem_l2_error([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}

///|
test "fem_l2_error nonzero" {
  let e = fem_l2_error([1.0, 2.0], [0.0, 0.0])
  assert_true((e - 2.236068).abs() < 0.001)
}

///|
test "element_stiffness orthogonal" {
  let s = element_stiffness((1.0, 0.0), (0.0, 1.0), 1.0)
  assert_true(s.abs() < 0.000001)
}

///|
test "element_mass zero" {
  let m = element_mass(0.0, 1.0, 0.5)
  assert_true(m.abs() < 0.000001)
}

///|
test "assemble_stiffness empty" {
  let k = assemble_stiffness(3, [])
  assert_eq(k.length(), 3)
  assert_true(k[0][0].abs() < 0.000001)
}

///|
test "assemble_stiffness single" {
  let k = assemble_stiffness(2, [(0, 1, 2, 5.0)])
  assert_true((k[0][1] - 5.0).abs() < 0.000001)
  assert_true((k[1][0] - 5.0).abs() < 0.000001)
}

///|
test "assemble_stiffness diagonal" {
  let k = assemble_stiffness(2, [(0, 0, 1, 3.0)])
  assert_true((k[0][0] - 6.0).abs() < 0.000001)
}

///|
test "apply_dirichlet single" {
  let k = [[1.0, 2.0], [3.0, 4.0]]
  let result = apply_dirichlet(k, [0])
  assert_true((result[0][0] - 1.0).abs() < 0.000001)
  assert_true(result[0][1].abs() < 0.000001)
  assert_true(result[1][0].abs() < 0.000001)
}

///|
test "apply_dirichlet multiple" {
  let k = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0], [7.0, 8.0, 9.0]]
  let result = apply_dirichlet(k, [0, 2])
  assert_true((result[0][0] - 1.0).abs() < 0.000001)
  assert_true((result[2][2] - 1.0).abs() < 0.000001)
  assert_true(result[2][1].abs() < 0.000001)
}
