///|
test "max_flow basic" {
  let n = 4
  let cap : Array[Array[Double]] = [
    [0.0, 3.0, 2.0, 0.0],
    [0.0, 0.0, 1.0, 2.0],
    [0.0, 0.0, 0.0, 3.0],
    [0.0, 0.0, 0.0, 0.0],
  ]
  let flow = max_flow(n, cap, 0, 3)
  assert_true(flow > 0.0)
}

///|
test "min_cut equals max_flow" {
  let n = 4
  let cap : Array[Array[Double]] = [
    [0.0, 3.0, 2.0, 0.0],
    [0.0, 0.0, 1.0, 2.0],
    [0.0, 0.0, 0.0, 3.0],
    [0.0, 0.0, 0.0, 0.0],
  ]
  let mc = min_cut(n, cap, 0, 3)
  let mf = max_flow(n, cap, 0, 3)
  assert_true((mc - mf).abs() < 0.001)
}

///|
test "min_cut_partition basic" {
  let n = 4
  let cap : Array[Array[Double]] = [
    [0.0, 3.0, 2.0, 0.0],
    [0.0, 0.0, 1.0, 2.0],
    [0.0, 0.0, 0.0, 3.0],
    [0.0, 0.0, 0.0, 0.0],
  ]
  let partition = min_cut_partition(n, cap, 0, 3)
  assert_true(partition.length() >= 1)
}

///|
test "max_flow no path" {
  let n = 3
  let cap : Array[Array[Double]] = [
    [0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0],
  ]
  let flow = max_flow(n, cap, 0, 2)
  assert_true(flow.abs() < 0.001)
}

///|
test "max_flow single edge" {
  let n = 2
  let cap : Array[Array[Double]] = [[0.0, 5.0], [0.0, 0.0]]
  let flow = max_flow(n, cap, 0, 1)
  assert_true((flow - 5.0).abs() < 0.001)
}
