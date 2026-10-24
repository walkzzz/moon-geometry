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
///|
test "lazy_approx" {
  let le = LazyExact::new(3.14, 3.14159)
  assert_true((lazy_approx(le) - 3.14).abs() < 0.001)
}

///|
test "lazy_value" {
  let le = LazyExact::new(1.0, 2.5)
  assert_true((lazy_value(le) - 2.5).abs() < 0.001)
}

///|
test "lazy_error_zero" {
  let le = LazyExact::new(2.0, 2.0)
  assert_true(lazy_error(le) == 0.0)
}

///|
test "lazy_error_negative_approx" {
  let le = LazyExact::new(1.0, 3.0)
  assert_true((lazy_error(le) - 2.0).abs() < 0.001)
}
