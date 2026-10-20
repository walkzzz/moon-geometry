test "persistence" {
  let p = PersistencePoint::new(1.0, 3.0)
  assert_true((persistence(p) - 2.0).abs() < 0.001)
}

test "is_essential" {
  let p = PersistencePoint::new(1.0, 999999999.0)
  assert_true(is_essential(p))
}

test "max_persistence" {
  let d = [PersistencePoint::new(0.0, 2.0), PersistencePoint::new(1.0, 4.0)]
  assert_true((max_persistence(d) - 3.0).abs() < 0.001)
}
