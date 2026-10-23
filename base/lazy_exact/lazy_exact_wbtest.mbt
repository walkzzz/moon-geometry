///|
test "LazyExact::new" {
  let le = LazyExact::new(3.14, 3.14159)
  assert_true((lazy_value(le) - 3.14159).abs() < 0.001)
}

///|
test "lazy_error" {
  let le = LazyExact::new(3.14, 3.14159)
  assert_true(lazy_error(le) > 0.0)
}
