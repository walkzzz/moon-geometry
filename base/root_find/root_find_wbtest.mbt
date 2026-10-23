///|
test "bisection basic" {
  let f = fn(x : Double) -> Double { x * x - 2.0 }
  let root = bisection(f, 0.0, 2.0, 50)
  assert_true((root - 1.41421356).abs() < 0.001)
}

///|
test "newton basic" {
  let f = fn(x : Double) -> Double { x * x - 2.0 }
  let fp = fn(x : Double) -> Double { 2.0 * x }
  let root = newton(f, fp, 1.0, 50)
  assert_true((root - 1.41421356).abs() < 0.001)
}

///|
test "secant basic" {
  let f = fn(x : Double) -> Double { x * x - 2.0 }
  let root = secant(f, 1.0, 2.0, 50)
  assert_true((root - 1.41421356).abs() < 0.001)
}

///|
test "find_all_roots basic" {
  let f = fn(x : Double) -> Double { x * x - 1.0 }
  let roots = find_all_roots(f, -2.0, 2.0, 100)
  assert_eq(roots.length(), 2)
}

///|
test "bisection no sign change" {
  let f = fn(x : Double) -> Double { x * x + 1.0 }
  let root = bisection(f, 0.0, 2.0, 50)
  assert_true(root >= 0.0)
}
