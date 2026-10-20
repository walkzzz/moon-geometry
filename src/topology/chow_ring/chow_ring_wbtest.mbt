test "chow_product" {
  assert_eq(chow_product(1, 1, 2), 2)
  assert_eq(chow_product(1, 2, 2), 0)
}

test "chow_top_class" {
  assert_eq(chow_top_class(3), 3)
}

test "chow_integral" {
  assert_eq(chow_integral(2, 2), 1)
  assert_eq(chow_integral(1, 2), 0)
}
