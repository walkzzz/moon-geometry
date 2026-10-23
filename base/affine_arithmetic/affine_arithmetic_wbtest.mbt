///|
test "AffineForm::new" {
  let a = AffineForm::new(1.0, [0.1, 0.2])
  let (lo, hi) = affine_to_interval(a)
  assert_true((lo - 0.7).abs() < 0.001)
  assert_true((hi - 1.3).abs() < 0.001)
}

///|
test "affine_add" {
  let a = AffineForm::new(1.0, [0.1])
  let b = AffineForm::new(2.0, [0.2])
  let c = affine_add(a, b)
  assert_true((c.center - 3.0).abs() < 0.001)
}

///|
test "affine_scale" {
  let a = AffineForm::new(2.0, [0.1])
  let c = affine_scale(a, 3.0)
  assert_true((c.center - 6.0).abs() < 0.001)
}
