test "pso_1d quadratic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = pso_1d(f, -5.0, 5.0, 20, 100, 42U)
  assert_true(result.abs() < 0.5)
}

test "pso_1d shifted" {
  let f = fn(x : Double) -> Double { (x - 3.0) * (x - 3.0) }
  let result = pso_1d(f, -5.0, 10.0, 20, 100, 42U)
  assert_true((result - 3.0).abs() < 0.5)
}

test "pso global 2d" {
  let f = fn(x : Array[Double]) -> Double {
    x[0] * x[0] + x[1] * x[1]
  }
  let config = PSOConfig::new(20, 2, 0.7, 1.5, 1.5, [-5.0, -5.0], [5.0, 5.0], 2.0)
  let result = pso(f, config, Global, 200, 42U)
  assert_true(result.value < 0.5)
}

test "pso local topology" {
  let f = fn(x : Array[Double]) -> Double {
    (x[0] - 2.0) * (x[0] - 2.0) + (x[1] + 1.0) * (x[1] + 1.0)
  }
  let config = PSOConfig::new(20, 2, 0.7, 1.5, 1.5, [-5.0, -5.0], [5.0, 5.0], 2.0)
  let result = pso(f, config, Local(2), 200, 42U)
  assert_true(result.value < 1.0)
}

test "pso_decreasing_w" {
  let f = fn(x : Array[Double]) -> Double {
    x[0] * x[0] + x[1] * x[1]
  }
  let config = PSOConfig::new(20, 2, 0.9, 1.5, 1.5, [-5.0, -5.0], [5.0, 5.0], 2.0)
  let result = pso_decreasing_w(f, config, 0.9, 0.4, Global, 200, 42U)
  assert_true(result.value < 0.5)
}

test "pso_config construct" {
  let config = PSOConfig::new(30, 3, 0.7, 1.5, 1.5, [-1.0, -1.0, -1.0], [1.0, 1.0, 1.0], 0.5)
  assert_eq(config.n_particles, 30)
  assert_eq(config.n_dims, 3)
}

test "pso_result construct" {
  let r = PSOResult::new([1.0, 2.0], 5.0, 100)
  assert_eq(r.iterations, 100)
  assert_true((r.value - 5.0).abs() < 0.000001)
}

test "pso respects bounds" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let config = PSOConfig::new(15, 1, 0.7, 1.5, 1.5, [1.0], [3.0], 0.5)
  let result = pso(f, config, Global, 100, 42U)
  assert_true(result.x[0] >= 1.0 - 0.001)
  assert_true(result.x[0] <= 3.0 + 0.001)
}

test "pso_1d sinusoidal" {
  let f = fn(x : Double) -> Double { @math.sin(x) + 0.1 * x * x }
  let result = pso_1d(f, -5.0, 5.0, 25, 150, 7U)
  let optimal = f(result)
  let f_at_zero = f(0.0)
  assert_true(optimal <= f_at_zero + 0.5)
}

test "pso higher dimension" {
  let f = fn(x : Array[Double]) -> Double {
    let mut s = 0.0
    for i in 0..<x.length() {
      s += (x[i] - 1.0) * (x[i] - 1.0)
    }
    s
  }
  let config = PSOConfig::new(30, 3, 0.7, 1.5, 1.5, [-3.0, -3.0, -3.0], [3.0, 3.0, 3.0], 1.0)
  let result = pso(f, config, Global, 200, 42U)
  assert_true(result.value < 1.0)
}