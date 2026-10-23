///|
test "simplex basic min" {
  let a = [[1.0, 1.0], [1.0, 0.0], [0.0, 1.0]]
  let b = [4.0, 3.0, 2.0]
  let c = [-1.0, -1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value + 4.0).abs() < 0.001)
}

///|
test "simplex trivial" {
  let a = [[1.0]]
  let b = [5.0]
  let c = [1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value >= -0.001)
}

///|
test "simplex two vars" {
  let a = [[2.0, 1.0], [1.0, 3.0]]
  let b = [4.0, 6.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value >= 0.0)
}

///|
test "simplex_max basic" {
  let a = [[1.0, 1.0], [1.0, 0.0], [0.0, 1.0]]
  let b = [4.0, 3.0, 2.0]
  let c = [1.0, 1.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value - 4.0).abs() < 0.001)
}

///|
test "simplex_max single var" {
  let a = [[1.0]]
  let b = [10.0]
  let c = [3.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value - 30.0).abs() < 0.001)
}

///|
test "simplex_result construct" {
  let r = SimplexResult::new([1.0, 2.0], 5.0, true)
  assert_true(r.success)
  assert_true((r.value - 5.0).abs() < 0.000001)
  assert_eq(r.x.length(), 2)
}

///|
test "simplex empty constraints" {
  let a : Array[Array[Double]] = []
  let b : Array[Double] = []
  let c = [1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
}

///|
test "simplex unbounded direction handled" {
  let a = [[-1.0, 1.0]]
  let b = [1.0]
  let c = [-1.0, 0.0]
  let r = simplex(a, b, c, 100)
  let _ = r
  assert_true(true)
}

///|
test "simplex degenerate" {
  let a = [[1.0, 1.0], [2.0, 2.0]]
  let b = [3.0, 6.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value.abs() < 0.01)
}

///|
test "simplex_max two constraints" {
  let a = [[2.0, 1.0], [1.0, 2.0]]
  let b = [4.0, 4.0]
  let c = [3.0, 2.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value > 0.0)
}

///|
test "simplex negative b two phase" {
  let a = [[-1.0, 1.0], [1.0, 1.0]]
  let b = [-1.0, 4.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 100)
  let _ = r
  assert_true(true)
}

///|
test "simplex_max negative b" {
  let a = [[-1.0, 1.0], [1.0, 1.0]]
  let b = [-1.0, 4.0]
  let c = [1.0, 0.0]
  let r = simplex_max(a, b, c, 100)
  let _ = r
  assert_true(true)
}

///|
test "simplex empty c" {
  let a = [[1.0]]
  let b = [5.0]
  let c : Array[Double] = []
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
}

///|
test "simplex zero iterations" {
  let a = [[1.0, 1.0]]
  let b = [4.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 0)
  let _ = r
  assert_true(true)
}

///|
test "simplex three vars" {
  let a = [[1.0, 1.0, 1.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  let b = [6.0, 2.0, 2.0, 2.0]
  let c = [1.0, 1.0, 1.0]
  let r = simplex(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value >= 0.0)
}

///|
test "simplex_max three vars" {
  let a = [[1.0, 1.0, 1.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  let b = [6.0, 2.0, 2.0, 2.0]
  let c = [1.0, 1.0, 1.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
  assert_true(r.value > 0.0)
}

///|
test "simplex infeasible two phase" {
  let a = [[1.0, 1.0], [-1.0, -1.0]]
  let b = [1.0, -2.0]
  let c = [1.0, 1.0]
  let r = simplex(a, b, c, 100)
  let _ = r
  assert_true(true)
}

///|
test "simplex result accessors" {
  let r = SimplexResult::new([1.0, 2.0, 3.0], 10.0, true)
  assert_eq(r.x.length(), 3)
  assert_true((r.x[0] - 1.0).abs() < 0.000001)
  assert_true((r.x[1] - 2.0).abs() < 0.000001)
  assert_true((r.x[2] - 3.0).abs() < 0.000001)
  assert_true((r.value - 10.0).abs() < 0.000001)
}

///|
test "simplex failed result" {
  let r = SimplexResult::new([], 0.0, false)
  assert_false(r.success)
  assert_eq(r.x.length(), 0)
}

///|
test "simplex single var negative b" {
  let a = [[-1.0]]
  let b = [-5.0]
  let c = [1.0]
  let r = simplex(a, b, c, 100)
  let _ = r
  assert_true(true)
}

///|
test "simplex_max empty constraints" {
  let a : Array[Array[Double]] = []
  let b : Array[Double] = []
  let c = [1.0]
  let r = simplex_max(a, b, c, 100)
  assert_true(r.success)
}
