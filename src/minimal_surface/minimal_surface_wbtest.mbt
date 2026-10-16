test "is_minimal" {
  assert_true(is_minimal(0.0001, 0.01))
  assert_false(is_minimal(0.1, 0.01))
}

test "minimal_surface_energy" {
  assert_true((minimal_surface_energy(5.0) - 5.0).abs() < 0.001)
}

test "area_gradient" {
  let g = area_gradient([0.0, 0.0], [1.0, 2.0])
  assert_true(g[0].abs() < 0.001)
}
