test "lorenz step" {
  let (x, y, z) = lorenz_step(1.0, 1.0, 1.0, 10.0, 28.0, 8.0 / 3.0, 0.01)
  assert_true(x > 0.99 && x < 1.01)
}

test "henon map" {
  let (x, y) = henon_map(0.0, 0.0, 1.4, 0.3)
  assert_eq(x, 1.0)
  assert_eq(y, 0.0)
}

test "bifurcation point" {
  let b = bifurcation_point_logistic()
  assert_true(b > 3.56 && b < 3.57)
}
