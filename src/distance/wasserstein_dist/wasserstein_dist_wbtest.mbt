test "wasserstein_1_distance" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 3.0)]
  assert_true((wasserstein_1_distance(d1, d2) - 1.0).abs() < 0.001)
}

test "wasserstein_inf_distance" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  assert_true(wasserstein_inf_distance(d1, d2).abs() < 0.001)
}
