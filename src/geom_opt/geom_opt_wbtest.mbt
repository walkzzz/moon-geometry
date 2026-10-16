test "smallest enclosing circle" {
  let r = smallest_enclosing_circle_radius([(0.0, 0.0), (2.0, 0.0)])
  assert_eq(r, 1.0)
}

test "geometric mean" {
  let m = geometric_mean([1.0, 4.0])
  assert_true(m > 1.99 && m < 2.01)
}

test "fermat point approx" {
  let (x, y) = fermat_point_approx(0.0, 0.0, 6.0, 0.0, 3.0, 6.0)
  assert_eq(x, 3.0)
  assert_eq(y, 2.0)
}
