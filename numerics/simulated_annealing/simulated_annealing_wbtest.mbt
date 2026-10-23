///|
test "sa quadratic 1d" {
  let f = fn(x : Double) -> Double { x * x }
  let result = sa_1d(f, 5.0, 1.0, 10.0, 0.95, 500, 42U)
  assert_true(result.abs() < 0.5)
}

///|
test "sa shifted quadratic" {
  let f = fn(x : Double) -> Double { (x - 3.0) * (x - 3.0) }
  let result = sa_1d(f, 0.0, 1.0, 10.0, 0.95, 500, 42U)
  assert_true((result - 3.0).abs() < 0.5)
}

///|
test "sa_multivariate" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] + x[1] * x[1] }
  let neighbor = fn(x : Array[Double], rng : SA_rng) -> Array[Double] {
    uniform_neighbor(x, 1.0, rng)
  }
  let result = simulated_annealing(
    f,
    [5.0, 5.0],
    neighbor,
    10.0,
    Geometric(0.95),
    0.001,
    1000,
    42U,
  )
  assert_true(result.value < 1.0)
}

///|
test "sa geometric cooling" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let neighbor = fn(x : Array[Double], rng : SA_rng) -> Array[Double] {
    uniform_neighbor(x, 1.0, rng)
  }
  let result = simulated_annealing(
    f,
    [5.0],
    neighbor,
    10.0,
    Geometric(0.9),
    0.001,
    500,
    1U,
  )
  assert_true(result.value < 2.0)
}

///|
test "sa linear cooling" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let neighbor = fn(x : Array[Double], rng : SA_rng) -> Array[Double] {
    uniform_neighbor(x, 1.0, rng)
  }
  let result = simulated_annealing(
    f,
    [5.0],
    neighbor,
    10.0,
    Linear(0.05),
    0.001,
    200,
    1U,
  )
  assert_true(result.value < 5.0)
}

///|
test "sa logarithmic cooling" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let neighbor = fn(x : Array[Double], rng : SA_rng) -> Array[Double] {
    uniform_neighbor(x, 1.0, rng)
  }
  let result = simulated_annealing(
    f,
    [3.0],
    neighbor,
    10.0,
    Logarithmic(5.0),
    0.001,
    500,
    1U,
  )
  assert_true(result.value < 5.0)
}

///|
test "sa_result construct" {
  let r = SAResult::new([1.0, 2.0], 5.0, 100)
  assert_eq(r.iterations, 100)
  assert_true((r.value - 5.0).abs() < 0.000001)
}

///|
test "sa_reheat improves" {
  let f = fn(x : Array[Double]) -> Double { x[0] * x[0] }
  let neighbor = fn(x : Array[Double], rng : SA_rng) -> Array[Double] {
    uniform_neighbor(x, 1.0, rng)
  }
  let result = sa_reheat(f, [5.0], neighbor, 10.0, 0.9, 300, 2, 42U)
  assert_true(result.value < 2.0)
}

///|
test "sa_rng reproducible" {
  let r1 = SA_rng::new(42U)
  let r2 = SA_rng::new(42U)
  let v1 = r1.next()
  let v2 = r2.next()
  assert_true((v1 - v2).abs() < 0.000001)
}

///|
test "sa finds global min" {
  let f = fn(x : Double) -> Double {
    if x < -2.0 {
      (x + 3.0) * (x + 3.0)
    } else if x > 2.0 {
      (x - 3.0) * (x - 3.0)
    } else {
      4.0 + x * x
    }
  }
  let result = sa_1d(f, 0.0, 2.0, 20.0, 0.97, 2000, 7U)
  let optimal = f(result)
  assert_true(optimal < 5.0)
}
