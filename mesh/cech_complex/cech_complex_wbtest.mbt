///|
test "cech_complex_simplices" {
  let sc = cech_complex_simplices(5, 2)
  assert_true(sc.length() >= 1)
}

///|
test "cech_nerve" {
  let n = cech_nerve(3)
  assert_eq(n.length(), 3)
}

///|
test "cech_dimension" {
  assert_eq(cech_dimension(3), 3)
}
