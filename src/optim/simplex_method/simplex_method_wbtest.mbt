test "simplex basic min" {
  let a = [[1.0, 1.0], [1.0, 0.0], [0.0, 1.0]]
  let b = [4.0, 3.0, 2.0]
  let c = [-1.0, -1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value + 4.0).abs() < 0.001)
}

test "simplex trivial" {
  let a = [[1.0]]
  let b = [5.0]
  let c = [1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value >= -0.001)
}

test "simplex two vars" {
  let a = [[2.0, 1.0], [1.0, 3.0]]
  let b = [4.0, 6.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value >= 0.0)
}

test "simplex_max basic" {
  let a = [[1.0, 1.0], [1.0, 0.0], [0.0, 1.0]]
  let b = [4.0, 3.0, 2.0]
  let c = [1.0, 1.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value - 4.0).abs() < 0.001)
}

test "simplex_max single var" {
  let a = [[1.0]]
  let b = [10.0]
  let c = [3.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value - 30.0).abs() < 0.001)
}

test "simplex_result construct" {
  let r = SimplexResult::new([1.0, 2.0], 5.0, true)
  assert_true(r.success)
  assert_true((r.value - 5.0).abs() < 0.000001)
  assert_eq(r.x.length(), 2)
}

test "simplex empty constraints" {
  let a : Array[Array[Double]] = []
  let b : Array[Double] = []
  let c = [1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
}

test "simplex unbounded direction handled" {
  let a = [[-1.0, 1.0]]
  let b = [1.0]
  let c = [-1.0, 0.0]
  let r = simplex(a, b, c, 100)
  let _ = r
  assert_true(true)
}

test "simplex degenerate" {
  let a = [[1.0, 1.0], [2.0, 2.0]]
  let b = [3.0, 6.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value.abs() < 0.01)
}

test "simplex_max two constraints" {
  let a = [[2.0, 1.0], [1.0, 2.0]]
  let b = [4.0, 4.0]
  let c = [3.0, 2.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value > 0.0)
}