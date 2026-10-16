test "critical_points" {
  let mf = MorseFunction::new([1.0, 0.0, 1.0])
  let cp = critical_points(mf)
  assert_eq(cp.length(), 1)
}

test "is_morse" {
  let mf = MorseFunction::new([1.0, 2.0, 3.0])
  assert_true(is_morse(mf))
}

test "is_morse duplicate" {
  let mf = MorseFunction::new([1.0, 1.0, 3.0])
  assert_false(is_morse(mf))
}
