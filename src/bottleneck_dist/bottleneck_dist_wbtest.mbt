test "bottleneck_distance" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  assert_true(bottleneck_distance(d1, d2).abs() < 0.001)
}

test "bottleneck_upper_bound" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 3.0)]
  assert_true(bottleneck_upper_bound(d1, d2) > 0.0)
}
