///|
test "ga_1d quadratic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = ga_1d(f, -5.0, 5.0, 30, 100, 42U)
  assert_true(result.abs() < 0.5)
}

///|
test "ga_1d shifted" {
  let f = fn(x : Double) -> Double { (x - 3.0) * (x - 3.0) }
  let result = ga_1d(f, -5.0, 10.0, 30, 100, 42U)
  assert_true((result - 3.0).abs() < 0.5)
}

///|
test "ga maximize" {
  let fitness = fn(x : Array[Double]) -> Double { -(x[0] * x[0] + x[1] * x[1]) }
  let config = GAConfig::new(30, 2, 0.8, 0.1, 2, [-5.0, -5.0], [5.0, 5.0])
  let result = genetic_algorithm(fitness, config, 100, 42U)
  assert_true(result.fitness > -1.0)
}

///|
test "ga_minimize 2d" {
  let f = fn(x : Array[Double]) -> Double {
    (x[0] - 2.0) * (x[0] - 2.0) + (x[1] + 1.0) * (x[1] + 1.0)
  }
  let config = GAConfig::new(50, 2, 0.85, 0.1, 3, [-5.0, -5.0], [5.0, 5.0])
  let result = ga_minimize(f, config, 150, 42U)
  assert_true(result.fitness < 1.0)
}

///|
test "ga_config construct" {
  let config = GAConfig::new(20, 3, 0.8, 0.05, 2, [0.0, 0.0, 0.0], [
    1.0, 1.0, 1.0,
  ])
  assert_eq(config.pop_size, 20)
  assert_eq(config.n_genes, 3)
  assert_eq(config.elite_count, 2)
}

///|
test "ga_result construct" {
  let r = GAResult::new([1.0, 2.0], 5.0, 100)
  assert_eq(r.generations, 100)
  assert_true((r.fitness - 5.0).abs() < 0.000001)
}

///|
test "ga respects bounds" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let config = GAConfig::new(20, 1, 0.8, 0.1, 2, [1.0], [3.0])
  let result = ga_minimize(f, config, 50, 42U)
  assert_true(result.x[0] >= 1.0 - 0.001)
  assert_true(result.x[0] <= 3.0 + 0.001)
}

///|
test "ga_1d sinusoidal" {
  let f = fn(x : Double) -> Double { @math.sin(x) + 0.1 * x * x }
  let result = ga_1d(f, -5.0, 5.0, 40, 150, 7U)
  let optimal = f(result)
  let f_at_zero = f(0.0)
  assert_true(optimal <= f_at_zero + 0.5)
}

///|
test "ga elitism preserves best" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let config = GAConfig::new(30, 2, 0.8, 0.1, 5, [-5.0, -5.0], [5.0, 5.0])
  let result = ga_minimize(f, config, 100, 42U)
  assert_true(result.fitness < 2.0)
}

///|
test "ga_multivariate higher dim" {
  let f = fn(x : Array[Double]) -> Double {
    let mut s = 0.0
    for i in 0..<x.length() {
      s += (x[i] - 1.0) * (x[i] - 1.0)
    }
    s
  }
  let config = GAConfig::new(50, 3, 0.85, 0.15, 3, [-3.0, -3.0, -3.0], [
    3.0, 3.0, 3.0,
  ])
  let result = ga_minimize(f, config, 200, 42U)
  assert_true(result.fitness < 2.0)
}

///|
test "ga_population_std zero for identical" {
  let std = ga_population_std([1.0, 1.0, 1.0, 1.0])
  assert_true(std < 0.0000001)
}

///|
test "ga_population_std positive for diverse" {
  let std = ga_population_std([0.0, 2.0, 4.0, 6.0])
  assert_true(std > 1.0)
}

///|
test "ga_mutation_schedule decays" {
  let r0 = ga_mutation_schedule(0.1, 0.01, 0)
  let r100 = ga_mutation_schedule(0.1, 0.01, 100)
  assert_true((r0 - 0.1).abs() < 0.0001)
  assert_true(r100 < r0)
}
