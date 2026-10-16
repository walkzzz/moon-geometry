test "trapezoid basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = trapezoid(f, 0.0, 1.0, 100)
  assert_true((result - 0.333333).abs() < 0.01)
}

test "simpson basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = simpson(f, 0.0, 1.0, 100)
  assert_true((result - 0.333333).abs() < 0.001)
}

test "monte_carlo basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = monte_carlo(f, 0.0, 1.0, 10000, 42)
  assert_true((result - 0.333333).abs() < 0.1)
}

test "adaptive_simpson basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = adaptive_simpson(f, 0.0, 1.0, 0.0001)
  assert_true((result - 0.333333).abs() < 0.001)
}

test "trapezoid constant" {
  let f = fn(_ : Double) -> Double { 5.0 }
  let result = trapezoid(f, 0.0, 10.0, 10)
  assert_true((result - 50.0).abs() < 0.001)
}