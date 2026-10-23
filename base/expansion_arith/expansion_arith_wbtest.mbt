///|
test "scale expansion" {
  let r = scale_expansion([1.0, 2.0], 3.0)
  assert_eq(r[0], 3.0)
  assert_eq(r[1], 6.0)
}

///|
test "compress expansion" {
  let r = compress_expansion([1.0, 2.0, 3.0])
  assert_eq(r[0], 6.0)
}

///|
test "expansion negate" {
  let r = expansion_negate([1.0, -2.0])
  assert_eq(r[0], -1.0)
  assert_eq(r[1], 2.0)
}
