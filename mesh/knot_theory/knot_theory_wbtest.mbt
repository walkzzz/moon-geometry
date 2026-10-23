///|
test "crossing number" {
  let n = crossing_number([1, 2, 3, 2])
  assert_eq(n, 3)
}

///|
test "writhe" {
  let w = writhe([1, 1, -1, 1])
  assert_eq(w, 2)
}

///|
test "jones unknot" {
  assert_eq(jones_unknot(2.0), 1.0)
}
