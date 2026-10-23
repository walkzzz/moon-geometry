///|
test "solve_linear identity" {
  let a = [[1.0, 0.0], [0.0, 1.0]]
  let b = [3.0, 5.0]
  match solve_linear(a, b, 2) {
    Some(x) => {
      assert_true((x[0] - 3.0).abs() < 0.000001)
      assert_true((x[1] - 5.0).abs() < 0.000001)
    }
    None => assert_true(false)
  }
}

///|
test "solve_linear 2x2" {
  let a = [[2.0, 1.0], [1.0, 3.0]]
  let b = [3.0, 4.0]
  match solve_linear(a, b, 2) {
    Some(x) => {
      assert_true((x[0] - 1.0).abs() < 0.000001)
      assert_true((x[1] - 1.0).abs() < 0.000001)
    }
    None => assert_true(false)
  }
}

///|
test "solve_linear singular" {
  let a = [[1.0, 2.0], [2.0, 4.0]]
  let b = [1.0, 2.0]
  match solve_linear(a, b, 2) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "solve_unconstrained_qp" {
  let q = [[2.0, 0.0], [0.0, 2.0]]
  let c = [-2.0, -4.0]
  match solve_unconstrained_qp(q, c, 2) {
    Some(x) => {
      assert_true((x[0] - 1.0).abs() < 0.000001)
      assert_true((x[1] - 2.0).abs() < 0.000001)
    }
    None => assert_true(false)
  }
}

///|
test "active_set_qp unconstrained" {
  let q = [[2.0, 0.0], [0.0, 2.0]]
  let c = [-2.0, -4.0]
  let a : Array[Array[Double]] = []
  let b : Array[Double] = []
  let r = active_set_qp(q, c, a, b, 2, 50)
  assert_true((r.x[0] - 1.0).abs() < 0.001)
  assert_true((r.x[1] - 2.0).abs() < 0.001)
}

///|
test "active_set_qp with constraint" {
  let q = [[2.0, 0.0], [0.0, 2.0]]
  let c = [-2.0, -4.0]
  let a = [[-1.0, 0.0]]
  let b = [0.0]
  let r = active_set_qp(q, c, a, b, 2, 50)
  assert_true(r.x[0] >= -0.001)
}

///|
test "qp_2d_box" {
  let p = qp_2d_box(2.0, 0.0, 2.0, -2.0, -4.0, 0.0, 10.0, 0.0, 10.0)
  assert_true((p.x() - 1.0).abs() < 0.01)
  assert_true((p.y() - 2.0).abs() < 0.01)
}

///|
test "qp_2d_box constrained" {
  let p = qp_2d_box(2.0, 0.0, 2.0, -2.0, -4.0, 0.0, 0.5, 0.0, 10.0)
  assert_true(p.x() <= 0.5 + 0.01)
  assert_true(p.x() >= 0.0 - 0.01)
}

///|
test "qp_objective" {
  let q = [[2.0, 0.0], [0.0, 2.0]]
  let c = [-2.0, -4.0]
  let x = [1.0, 2.0]
  let v = qp_objective(q, c, x, 2)
  assert_true((v - -5.0).abs() < 0.000001)
}

///|
test "solve_linear 3x3" {
  let a = [[4.0, 3.0, 0.0], [3.0, 4.0, -1.0], [0.0, -1.0, 4.0]]
  let b = [24.0, 30.0, -24.0]
  match solve_linear(a, b, 3) {
    Some(x) => {
      assert_true((x[0] - 3.0).abs() < 0.0001)
      assert_true((x[1] - 4.0).abs() < 0.0001)
      assert_true((x[2] + 5.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}
