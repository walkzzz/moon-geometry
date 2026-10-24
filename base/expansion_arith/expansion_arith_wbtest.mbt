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

///|
test "expansion length basic" {
  assert_eq(expansion_length([1.0, 2.0, 3.0]), 3)
  assert_eq(expansion_length([0.0, 0.0, 0.0]), 0)
  assert_eq(expansion_length([0.0, 5.0, 0.0]), 1)
}

///|
test "expansion length empty" {
  assert_eq(expansion_length([]), 0)
}

///|
test "expansion length negative values" {
  assert_eq(expansion_length([-1.0, -2.0]), 2)
  assert_eq(expansion_length([-0.0, 0.0]), 0)
}

///|
test "expansion norm basic" {
  let n = expansion_norm([3.0, 4.0])
  assert_true((n - 5.0).abs() < 0.001)
}

///|
test "expansion norm single" {
  let n = expansion_norm([7.0])
  assert_true((n - 7.0).abs() < 0.001)
}

///|
test "expansion norm empty" {
  assert_eq(expansion_norm([]), 0.0)
}

///|
test "expansion norm zero" {
  assert_eq(expansion_norm([0.0, 0.0, 0.0]), 0.0)
}

///|
test "expansion norm negative" {
  let n = expansion_norm([-3.0, -4.0])
  assert_true((n - 5.0).abs() < 0.001)
}

///|
test "scale expansion zero" {
  let r = scale_expansion([1.0, 2.0, 3.0], 0.0)
  assert_eq(r[0], 0.0)
  assert_eq(r[1], 0.0)
  assert_eq(r[2], 0.0)
}

///|
test "scale expansion negative" {
  let r = scale_expansion([1.0, -2.0], -2.0)
  assert_eq(r[0], -2.0)
  assert_eq(r[1], 4.0)
}

///|
test "scale expansion empty" {
  assert_eq(scale_expansion([], 5.0).length(), 0)
}

///|
test "compress expansion empty" {
  let r = compress_expansion([])
  assert_eq(r[0], 0.0)
}

///|
test "compress expansion single" {
  let r = compress_expansion([42.0])
  assert_eq(r[0], 42.0)
}

///|
test "compress expansion negatives" {
  let r = compress_expansion([10.0, -3.0, -7.0])
  assert_eq(r[0], 0.0)
}

///|
test "expansion negate empty" {
  assert_eq(expansion_negate([]).length(), 0)
}

///|
test "expansion negate zeros" {
  let r = expansion_negate([0.0, 0.0])
  assert_eq(r[0], 0.0)
  assert_eq(r[1], 0.0)
}
