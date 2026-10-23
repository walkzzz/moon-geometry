///|
test "sweep_update" {
  let u = sweep_update(999999.0, 0.0, 0.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "sweeping_converged" {
  assert_true(sweeping_converged([1.0, 2.0], [1.0001, 2.0001], 0.01))
}

///|
test "sweeping_converged not converged" {
  assert_false(sweeping_converged([1.0, 2.0], [1.5, 2.5], 0.01))
}

///|
test "sweep_update both larger" {
  let u = sweep_update(1.0, 5.0, 5.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "sweep_update neighbor2 smaller" {
  let u = sweep_update(10.0, 5.0, 2.0, 1.0, 1.0)
  assert_true((u - 6.0).abs() < 0.001)
}

///|
test "fast_sweeping_iterate identity" {
  let u = [0.0, 1.0, 1.0, 0.0]
  let f = [1.0, 1.0, 1.0, 1.0]
  let result = fast_sweeping_iterate(u, f, 1.0, 2, 2)
  assert_eq(result.length(), 4)
}

///|
test "fast_sweeping_iterate larger grid" {
  let n = 3
  let ny = 3
  let u = [0.0, 1.0, 2.0, 1.0, 2.0, 3.0, 2.0, 3.0, 4.0]
  let f = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
  let result = fast_sweeping_iterate(u, f, 1.0, n, ny)
  assert_eq(result.length(), 9)
}
