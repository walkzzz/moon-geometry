test "betti_0 empty" {
  assert_eq(betti_0([]), 0)
}

test "betti_0 single vertex" {
  assert_eq(betti_0([[0]]), 1)
}

test "betti_0 two disconnected" {
  assert_eq(betti_0([[0], [1]]), 2)
}

test "betti_0 connected edge" {
  assert_eq(betti_0([[0, 1]]), 1)
}

test "betti_1 triangle" {
  let simplices = [[0, 1], [1, 2], [0, 2], [0, 1, 2]]
  assert_eq(betti_1(simplices), 0)
}

test "betti_1 loop" {
  let simplices = [[0, 1], [1, 2], [0, 2]]
  assert_eq(betti_1(simplices), 1)
}

test "betti_numbers point" {
  let r = betti_numbers([[0]])
  assert_eq(r.b0, 1)
  assert_eq(r.b1, 0)
  assert_eq(r.b2, 0)
}

test "betti_numbers circle" {
  let simplices = [[0, 1], [1, 2], [0, 2]]
  let r = betti_numbers(simplices)
  assert_eq(r.b0, 1)
  assert_eq(r.b1, 1)
  assert_eq(r.b2, 0)
}

test "compute_euler" {
  let simplices = [[0, 1], [1, 2], [0, 2], [0, 1, 2]]
  assert_eq(compute_euler(simplices), 1)
}

test "BettiResult::new" {
  let r = BettiResult::new(1, 2, 3)
  assert_eq(r.b0, 1)
  assert_eq(r.b1, 2)
  assert_eq(r.b2, 3)
}