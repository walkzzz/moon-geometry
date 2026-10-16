test "multivector add" {
  let a = Multivector::new(1.0, 2.0, 3.0, 4.0)
  let b = Multivector::new(5.0, 6.0, 7.0, 8.0)
  let c = a.add(b)
  assert_eq(c.scalar, 6.0)
  assert_eq(c.e1, 8.0)
}

test "multivector norm" {
  let a = Multivector::new(3.0, 0.0, 4.0, 0.0)
  assert_eq(a.norm(), 5.0)
}

test "rotate vector" {
  let (rx, ry) = rotate_vector(1.0, 0.0, 1.5707963267948966)
  assert_true(rx > -0.0001 && rx < 0.0001)
  assert_true(ry > 0.99 && ry < 1.01)
}
