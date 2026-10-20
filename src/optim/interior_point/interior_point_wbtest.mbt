test "interior_point basic min" {
  let a = [[1.0, 1.0], [1.0, 0.0], [0.0, 1.0]]
  let b = [4.0, 3.0, 2.0]
  let c = [1.0, 1.0]
  let r = interior_point(a, b, c, 50)
  assert_true(r.success)
  assert_true(r.value >= -0.1)
}

test "interior_point single var" {
  let a = [[1.0]]
  let b = [5.0]
  let c = [1.0]
  let r = interior_point(a, b, c, 50)
  assert_true(r.success)
  assert_true(r.value >= -0.1)
  assert_true(r.value <= 0.1)
}

test "interior_point_max basic" {
  let a = [[1.0, 1.0], [1.0, 0.0], [0.0, 1.0]]
  let b = [4.0, 3.0, 2.0]
  let c = [1.0, 1.0]
  let r = interior_point_max(a, b, c, 100)
  assert_true(r.success)
  assert_true((r.value - 4.0).abs() < 1.0)
}

test "interior_point_max single" {
  let a = [[1.0]]
  let b = [10.0]
  let c = [3.0]
  let r = interior_point_max(a, b, c, 50)
  assert_true(r.success)
  assert_true((r.value - 30.0).abs() < 1.0)
}

test "ip_result construct" {
  let r = IPResult::new([1.0, 2.0], 5.0, true)
  assert_true(r.success)
  assert_true((r.value - 5.0).abs() < 0.000001)
  assert_eq(r.x.length(), 2)
}

test "interior_point two vars" {
  let a = [[2.0, 1.0], [1.0, 3.0]]
  let b = [4.0, 6.0]
  let c = [1.0, 1.0]
  let r = interior_point(a, b, c, 50)
  assert_true(r.success)
  assert_true(r.value >= -0.1)
}

test "interior_point empty" {
  let a : Array[Array[Double]] = []
  let b : Array[Double] = []
  let c = [1.0]
  let r = interior_point(a, b, c, 50)
  assert_true(r.success)
}

test "duality_gap basic" {
  let x = [1.0, 2.0, 3.0]
  let s = [0.5, 0.25, 0.0]
  let g = duality_gap(x, s, 3)
  assert_true((g - 1.0).abs() < 0.000001)
}

test "duality_gap zero" {
  let x = [1.0, 2.0]
  let s = [0.0, 0.0]
  let g = duality_gap(x, s, 2)
  assert_true(g.abs() < 0.000001)
}

test "interior_point feasibility" {
  let a = [[1.0, 0.0], [0.0, 1.0]]
  let b = [3.0, 4.0]
  let c = [1.0, 1.0]
  let r = interior_point(a, b, c, 50)
  assert_true(r.success)
  assert_true(r.x[0] <= 3.0 + 0.1)
  assert_true(r.x[1] <= 4.0 + 0.1)
}