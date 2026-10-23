///|
test "lp_simple" {
  let constraints = [
    (1.0, 0.0, 4.0),
    (0.0, 1.0, 4.0),
    (-1.0, 0.0, 0.0),
    (0.0, -1.0, 0.0),
  ]
  match linear_program_2d(constraints, 1.0, 1.0) {
    Some(r) => assert_true(@core.approx_eq(r.value, 8.0, 0.001))
    None => assert_true(false)
  }
}

///|
test "lp_infeasible" {
  let constraints = [(1.0, 0.0, -1.0), (-1.0, 0.0, -1.0)]
  match linear_program_2d(constraints, 1.0, 0.0) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "lp_feasible" {
  let constraints = [
    (1.0, 0.0, 4.0),
    (0.0, 1.0, 4.0),
    (-1.0, 0.0, 0.0),
    (0.0, -1.0, 0.0),
  ]
  assert_true(is_feasible(constraints))
}

///|
test "lp_find_feasible" {
  let constraints = [
    (1.0, 0.0, 4.0),
    (0.0, 1.0, 4.0),
    (-1.0, 0.0, 0.0),
    (0.0, -1.0, 0.0),
  ]
  match find_feasible_point(constraints) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}
