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
