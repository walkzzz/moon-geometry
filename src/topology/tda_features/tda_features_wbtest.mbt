test "tda_total_persistence" {
  let d = [@persistence_diagram.PersistencePoint::new(0.0, 2.0), @persistence_diagram.PersistencePoint::new(1.0, 3.0)]
  assert_true((tda_total_persistence(d) - 4.0).abs() < 0.001)
}

test "tda_feature_vector" {
  let d = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let fv = tda_feature_vector(d)
  assert_true((fv[0] - 2.0).abs() < 0.001)
  assert_eq(fv[2].to_int(), 1)
}
