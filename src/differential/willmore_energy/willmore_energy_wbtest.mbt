test "willmore_energy" {
  let e = willmore_energy([1.0, 2.0], [1.0, 1.0])
  assert_true((e - 5.0).abs() < 0.001)
}

test "willmore_of_sphere" {
  let w = willmore_of_sphere(1.0)
  assert_true((w - 50.26548245743669).abs() < 0.01)
}

test "is_willmore_minimal" {
  assert_true(is_willmore_minimal(0.0001, 0.01))
}
