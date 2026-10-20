test "prm_connection_radius" {
  let r = prm_connection_radius(100, 2, 100.0)
  assert_true(r > 0.0)
}
test "prm_edge_valid no obstacle" {
  let v = prm_edge_valid((0.0, 0.0), (1.0, 1.0), [])
  assert_true(v)
}
test "prm_edge_valid with obstacle" {
  let v = prm_edge_valid((0.0, 0.0), (1.0, 1.0), [(0.5, 0.5, 0.1)])
  assert_false(v)
}
