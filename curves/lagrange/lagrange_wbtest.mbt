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
test "lagrange_eval empty" {
  let xs : Array[Double] = []
  let ys : Array[Double] = []
  let val = lagrange_eval(xs, ys, 0.5)
  assert_true(val.abs() < 0.001)
}

test "lagrange_eval mismatched lengths" {
  let xs = [0.0, 1.0, 2.0]
  let ys = [0.0, 1.0]
  let val = lagrange_eval(xs, ys, 0.5)
  assert_true(val.abs() < 0.001)
}

test "lagrange_eval duplicate nodes" {
  let xs = [0.0, 0.0, 1.0]
  let ys = [1.0, 2.0, 3.0]
  let val = lagrange_eval(xs, ys, 0.5)
  assert_true((val - 2.25).abs() < 0.001)
}

test "lagrange_basis empty" {
  let xs : Array[Double] = []
  let b = lagrange_basis(xs, 0, 0.5)
  assert_true(b.abs() < 0.001)
}

test "lagrange_basis duplicate nodes" {
  let xs = [0.0, 0.0, 1.0]
  let b = lagrange_basis(xs, 0, 0.5)
  assert_true((b - 0.5).abs() < 0.001)
}

test "lagrange_interpolate empty" {
  let pts : Array[@core.Point2D] = []
  let val = lagrange_interpolate(pts, 0.5)
  assert_true(val.abs() < 0.001)
}

test "lagrange_nodes_distinct empty" {
  assert_true(lagrange_nodes_distinct([]))
}

test "lagrange_nodes_distinct single" {
  assert_true(lagrange_nodes_distinct([1.0]))
}