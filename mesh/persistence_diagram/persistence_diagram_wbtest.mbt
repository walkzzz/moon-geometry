///|
test "persistence" {
  let p = PersistencePoint::new(1.0, 3.0)
  assert_true((persistence(p) - 2.0).abs() < 0.001)
}

///|
test "is_essential" {
  let p = PersistencePoint::new(1.0, 999999999.0)
  assert_true(is_essential(p))
}

///|
test "max_persistence" {
  let d = [PersistencePoint::new(0.0, 2.0), PersistencePoint::new(1.0, 4.0)]
  assert_true((max_persistence(d) - 3.0).abs() < 0.001)
}

///|
test "diagram_dimension" {
  let d = [PersistencePoint::new(0.0, 1.0), PersistencePoint::new(2.0, 5.0)]
  assert_eq(diagram_dimension(d), 2)
}

///|
test "diagram_dimension_empty" {
  let d : Array[PersistencePoint] = []
  assert_eq(diagram_dimension(d), 0)
}

///|
test "max_persistence_empty" {
  let d : Array[PersistencePoint] = []
  assert_true(max_persistence(d) == 0.0)
}

///|
test "is_essential_not_essential" {
  let p = PersistencePoint::new(1.0, 3.0)
  assert_false(is_essential(p))
}

///|
test "persistence_negative" {
  let p = PersistencePoint::new(3.0, 1.0)
  assert_true((persistence(p) - -2.0).abs() < 0.001)
}

///|
test "PersistencePoint::new" {
  let p = PersistencePoint::new(2.0, 7.0)
  assert_true((persistence(p) - 5.0).abs() < 0.001)
}
