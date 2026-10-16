test "zigzag_intervals" {
  let iv = zigzag_intervals([0, 1], [3, 4])
  assert_eq(iv.length(), 2)
}

test "zigzag_length" {
  assert_eq(zigzag_length((1, 5)), 4)
}

test "zigzag_max_length" {
  assert_eq(zigzag_max_length([(1, 3), (0, 5)]), 5)
}
