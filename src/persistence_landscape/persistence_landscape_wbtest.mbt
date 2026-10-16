test "landscape_k" {
  let p = @persistence_diagram.PersistencePoint::new(0.0, 4.0)
  assert_true((landscape_k(p, 1, 2.0) - 2.0).abs() < 0.001)
  assert_true(landscape_k(p, 1, 5.0).abs() < 0.001)
}

test "landscape_sup" {
  let p = @persistence_diagram.PersistencePoint::new(0.0, 4.0)
  assert_true((landscape_sup(p) - 2.0).abs() < 0.001)
}

test "landscape_norm_1" {
  let d = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  assert_true((landscape_norm_1(d) - 1.0).abs() < 0.001)
}
