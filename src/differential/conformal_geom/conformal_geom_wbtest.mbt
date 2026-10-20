test "is conformal" {
  assert_true(is_conformal(2.0, 1.0, -1.0, 2.0))
  assert_true(!is_conformal(1.0, 0.0, 0.0, 2.0))
}

test "mobius transform" {
  let (x, y) = mobius_transform(1.0, 0.0, 1.0, 0.0)
  assert_eq(x, 1.0)
  assert_eq(y, 0.0)
}

test "angle preserving" {
  let a = angle_preserving(1.0, 0.0, 0.0, 1.0)
  assert_true((a - 1.5707963267948966).abs() < 1.0e-10)
}
