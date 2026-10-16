test "lagrange_eval_linear" {
  let xs = [0.0, 1.0]
  let ys = [0.0, 2.0]
  let val = lagrange_eval(xs, ys, 0.5)
  assert_true((val - 1.0).abs() < 0.001)
}

test "lagrange_eval_quadratic" {
  let xs = [0.0, 1.0, 2.0]
  let ys = [0.0, 1.0, 4.0]
  let val = lagrange_eval(xs, ys, 0.5)
  assert_true((val - 0.25).abs() < 0.001)
}

test "lagrange_basis" {
  let xs = [0.0, 1.0, 2.0]
  let b0 = lagrange_basis(xs, 0, 0.0)
  assert_true((b0 - 1.0).abs() < 0.001)
  let b1 = lagrange_basis(xs, 1, 1.0)
  assert_true((b1 - 1.0).abs() < 0.001)
}

test "lagrange_interpolate" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let val = lagrange_interpolate(pts, 0.5)
  assert_true((val - 0.25).abs() < 0.001)
}

test "lagrange_nodes_distinct" {
  assert_true(lagrange_nodes_distinct([0.0, 1.0, 2.0]))
  assert_false(lagrange_nodes_distinct([0.0, 1.0, 1.0]))
}