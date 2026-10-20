test "Filtration::new" {
  let f = Filtration::new([[0], [1], [0, 1]], [0.0, 1.0, 2.0])
  assert_eq(filtration_length(f), 3)
}

test "sublevel_set" {
  let f = Filtration::new([[0], [1], [0, 1]], [0.0, 1.0, 2.0])
  let s = sublevel_set(f, 1.0)
  assert_eq(s.length(), 2)
}

test "critical_values" {
  let f = Filtration::new([[0], [1]], [2.0, 1.0])
  let cv = critical_values(f)
  assert_true((cv[0] - 1.0).abs() < 0.001)
}
