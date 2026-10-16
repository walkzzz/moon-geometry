test "gradient_descent quadratic" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * x[0], 2.0 * x[1]]
  }
  let x = gradient_descent(grad, [1.0, 1.0], 0.1, 200)
  assert_true(x[0].abs() < 0.01)
  assert_true(x[1].abs() < 0.01)
}

test "gradient_descent shifted" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * (x[0] - 3.0), 2.0 * (x[1] + 2.0)]
  }
  let x = gradient_descent(grad, [0.0, 0.0], 0.1, 200)
  assert_true((x[0] - 3.0).abs() < 0.01)
  assert_true((x[1] + 2.0).abs() < 0.01)
}

test "momentum_gd quadratic" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * x[0], 2.0 * x[1]]
  }
  let x = momentum_gd(grad, [1.0, 1.0], 0.1, 0.9, 200)
  assert_true(x[0].abs() < 0.01)
  assert_true(x[1].abs() < 0.01)
}

test "nesterov_gd quadratic" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * x[0], 2.0 * x[1]]
  }
  let x = nesterov_gd(grad, [1.0, 1.0], 0.1, 0.9, 200)
  assert_true(x[0].abs() < 0.01)
  assert_true(x[1].abs() < 0.01)
}

test "adam quadratic" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * x[0], 2.0 * x[1]]
  }
  let x = adam(grad, [1.0, 1.0], 0.1, 0.9, 0.999, 0.00000001, 500)
  assert_true(x[0].abs() < 0.05)
  assert_true(x[1].abs() < 0.05)
}

test "adam shifted" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * (x[0] - 3.0), 2.0 * (x[1] + 2.0)]
  }
  let x = adam(grad, [0.0, 0.0], 0.1, 0.9, 0.999, 0.00000001, 500)
  assert_true((x[0] - 3.0).abs() < 0.05)
  assert_true((x[1] + 2.0).abs() < 0.05)
}

test "gd_2d basic" {
  let grad = fn(x : Double, y : Double) -> (Double, Double) {
    (2.0 * x, 2.0 * y)
  }
  let p = gd_2d(grad, 1.0, 1.0, 0.1, 200)
  assert_true(p.x().abs() < 0.01)
  assert_true(p.y().abs() < 0.01)
}

test "rmsprop quadratic" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [2.0 * x[0], 2.0 * x[1]]
  }
  let x = rmsprop(grad, [1.0, 1.0], 0.05, 0.9, 0.00000001, 500)
  assert_true(x[0].abs() < 0.15)
  assert_true(x[1].abs() < 0.15)
}

test "gradient_descent 1d" {
  let grad = fn(x : Array[Double]) -> Array[Double] {
    [4.0 * x[0] * x[0] * x[0]]
  }
  let x = gradient_descent(grad, [1.0], 0.1, 2000)
  assert_true(x[0].abs() < 0.1)
}