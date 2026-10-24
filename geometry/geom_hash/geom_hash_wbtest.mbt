///|
test "hash point 2d" {
  let (hx, hy) = hash_point_2d(5.5, 3.2, 1.0)
  assert_eq(hx, 5)
  assert_eq(hy, 3)
}

///|
test "hash key" {
  let k = hash_key(0.5, 0.0, 10)
  assert_eq(k, 5)
}

///|
test "similarity score" {
  let s = similarity_score([1, 2, 3, 4], [1, 0, 3, 0])
  assert_eq(s, 0.5)
}

///|
test "hash_point_2d negative" {
  let (hx, hy) = hash_point_2d(-5.5, -3.2, 1.0)
  assert_eq(hx, -6)
  assert_eq(hy, -4)
}

///|
test "hash_basis_invariant basic" {
  let (tx, ty) = hash_basis_invariant(0.0, 0.0, 1.0, 0.0, 0.5, 0.5)
  assert_true((tx - 0.5).abs() < 0.0001)
  assert_true((ty - 0.5).abs() < 0.0001)
}

///|
test "hash_basis_invariant degenerate" {
  let (tx, ty) = hash_basis_invariant(1.0, 1.0, 1.0, 1.0, 2.0, 2.0)
  assert_true(tx.abs() < 0.0001)
  assert_true(ty.abs() < 0.0001)
}

///|
test "hash_key negative" {
  let k = hash_key(-0.3, -0.2, 10)
  assert_eq(k, 0)
}

///|
test "hash_key overflow" {
  let k = hash_key(1.5, 0.5, 10)
  assert_eq(k, 9)
}

///|
test "similarity_score different length" {
  let s = similarity_score([1, 2, 3], [1, 2, 3, 4, 5])
  assert_true((s - 1.0).abs() < 0.0001)
}
