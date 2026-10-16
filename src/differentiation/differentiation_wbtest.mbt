test "forward_diff basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = forward_diff(f, 2.0, 0.001)
  assert_true((result - 4.0).abs() < 0.01)
}

test "central_diff basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = central_diff(f, 2.0, 0.001)
  assert_true((result - 4.0).abs() < 0.001)
}

test "second_diff basic" {
  let f = fn(x : Double) -> Double { x * x }
  let result = second_diff(f, 2.0, 0.001)
  assert_true((result - 2.0).abs() < 0.01)
}

test "gradient basic" {
  let f = fn(x : Double, y : Double) -> Double { x * x + y * y }
  let (dfx, dfy) = gradient(f, 2.0, 3.0, 0.001)
  assert_true((dfx - 4.0).abs() < 0.01)
  assert_true((dfy - 6.0).abs() < 0.01)
}

test "laplacian basic" {
  let f = fn(x : Double, y : Double) -> Double { x * x + y * y }
  let result = laplacian(f, 2.0, 3.0, 0.001)
  assert_true((result - 4.0).abs() < 0.1)
}