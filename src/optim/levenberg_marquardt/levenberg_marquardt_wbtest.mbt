test "lm quadratic fit" {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    let r : Array[Double] = Array::make(3, 0.0)
    r[0] = p[0] - 1.0
    r[1] = p[0] - 1.0
    r[2] = p[0] - 1.0
    r
  }
  let result = levenberg_marquardt(residual, [0.0], 100)
  assert_true((result.x[0] - 1.0).abs() < 0.001)
  assert_true(result.residual < 0.001)
}

test "lm two param" {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    let r : Array[Double] = Array::make(2, 0.0)
    r[0] = p[0] - 2.0
    r[1] = p[1] - 3.0
    r
  }
  let result = levenberg_marquardt(residual, [0.0, 0.0], 100)
  assert_true((result.x[0] - 2.0).abs() < 0.01)
  assert_true((result.x[1] - 3.0).abs() < 0.01)
}

test "lm with jacobian" {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    [p[0] - 5.0, p[1] + 2.0]
  }
  let jacobian = fn(_p : Array[Double]) -> Array[Array[Double]] {
    [[1.0, 0.0], [0.0, 1.0]]
  }
  let result = levenberg_marquardt_jac(residual, jacobian, [0.0, 0.0], 100)
  assert_true((result.x[0] - 5.0).abs() < 0.001)
  assert_true((result.x[1] + 2.0).abs() < 0.001)
}

test "lm nonlinear" {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    let r : Array[Double] = Array::make(4, 0.0)
    r[0] = p[0] * p[0] - 4.0
    r[1] = p[0] * p[0] - 4.0
    r[2] = p[0] * p[0] - 4.0
    r[3] = p[0] * p[0] - 4.0
    r
  }
  let result = levenberg_marquardt(residual, [1.0], 200)
  assert_true((result.x[0] - 2.0).abs() < 0.01)
}

test "lm_line_fit perfect" {
  let xs = [0.0, 1.0, 2.0, 3.0]
  let ys = [1.0, 3.0, 5.0, 7.0]
  let (a, b) = lm_line_fit(xs, ys)
  assert_true((a - 1.0).abs() < 0.01)
  assert_true((b - 2.0).abs() < 0.01)
}

test "lm_line_fit noisy" {
  let xs = [0.0, 1.0, 2.0, 3.0, 4.0]
  let ys = [0.1, 1.9, 4.1, 5.9, 8.1]
  let (_a, b) = lm_line_fit(xs, ys)
  assert_true((b - 2.0).abs() < 0.1)
}

test "lm_result construct" {
  let r = LMResult::new([1.0, 2.0], 0.5, 10, true)
  assert_eq(r.iterations, 10)
  assert_true(r.success)
  assert_true((r.residual - 0.5).abs() < 0.000001)
}

test "lm exponential fit" {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    let r : Array[Double] = Array::make(3, 0.0)
    r[0] = @math.exp(p[0]) - 2.0
    r[1] = @math.exp(p[0]) - 2.0
    r[2] = @math.exp(p[0]) - 2.0
    r
  }
  let result = levenberg_marquardt(residual, [0.0], 200)
  assert_true((result.x[0] - 0.693147).abs() < 0.02)
}

test "lm reduces residual" {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    [p[0] * p[0] - 1.0, p[0] * p[0] - 1.0]
  }
  let result = levenberg_marquardt(residual, [0.1], 100)
  assert_true(result.residual < 0.01)
}
test "lm_rms_error basic" {
  let rms = lm_rms_error(12.0, 3)
  assert_true((rms - 2.0).abs() < 0.0001)
}

test "lm_rms_error zero for zero residual" {
  let rms = lm_rms_error(0.0, 5)
  assert_true(rms < 0.0001)
}

test "lm_log_residual negative for small" {
  let lr = lm_log_residual(0.001)
  assert_true(lr < 0.0)
}