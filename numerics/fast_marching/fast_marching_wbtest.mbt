///|
test "solve_eikonal_2d" {
  let u = solve_eikonal_2d(0.0, 0.0, 1.0, 1.0)
  assert_true((u - 0.707107).abs() < 0.01)
}

///|
test "is_far" {
  assert_true(is_far(999999999.0))
  assert_false(is_far(1.0))
}

///|
test "is_frozen" {
  assert_true(is_frozen(1.0))
  assert_false(is_frozen(-1.0))
}

///|
test "fast_marching_step empty" {
  let result = fast_marching_step([], 1.0, 1.0)
  assert_eq(result.length(), 0)
}

///|
test "fast_marching_step single" {
  let result = fast_marching_step([(0, 0.0)], 1.0, 1.0)
  assert_eq(result.length(), 1)
  let (idx, u) = result[0]
  assert_eq(idx, 0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "fast_marching_step multiple" {
  let result = fast_marching_step([(0, 0.0), (1, 1.0), (2, 2.0)], 2.0, 0.5)
  assert_eq(result.length(), 3)
  let (_, u2) = result[2]
  assert_true((u2 - 2.25).abs() < 0.001)
}

///|
test "solve_eikonal_2d asymmetric" {
  let u = solve_eikonal_2d(1.0, 0.0, 1.0, 1.0)
  assert_true(u > 0.0)
}

///|
test "solve_eikonal_2d large f" {
  let u = solve_eikonal_2d(0.0, 0.0, 2.0, 1.0)
  assert_true(u > 0.0)
}

///|
test "is_far boundary" {
  assert_false(is_far(99999999.0))
  assert_true(is_far(100000000.0))
}

///|
test "is_frozen boundary" {
  assert_false(is_frozen(99999999.0))
  assert_true(is_frozen(0.0))
}

///|
test "solve_eikonal_2d disc neg u_left less" {
  // disc = 2*hh - (u_left-u_down)^2 = 2 - 100 < 0, u_left < u_down
  let u = solve_eikonal_2d(0.0, 10.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "solve_eikonal_2d disc neg u_left ge" {
  // disc < 0, u_left >= u_down -> u_down + h/f
  let u = solve_eikonal_2d(10.0, 0.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "solve_eikonal_2d disc pos result le u_left" {
  // (u_left-u_down)^2 = 1.21, disc = 0.79 > 0, result < u_left -> u_down + h/f
  let u = solve_eikonal_2d(1.1, 0.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "solve_eikonal_2d disc pos result le u_down" {
  // result < u_down, u_left < u_down -> u_left + h/f
  let u = solve_eikonal_2d(0.0, 1.1, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

///|
test "fast_marching_step f and h scaling" {
  let result = fast_marching_step([(0, 0.0), (1, 5.0)], 4.0, 2.0)
  let (_, u0) = result[0]
  let (_, u1) = result[1]
  assert_true((u0 - 0.5).abs() < 0.001)
  assert_true((u1 - 5.5).abs() < 0.001)
}

///|
test "is_frozen negative and large" {
  assert_false(is_frozen(-0.0001))
  assert_false(is_frozen(200000000.0))
}
