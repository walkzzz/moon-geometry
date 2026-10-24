///|
test "adaptive orient2d" {
  let r = adaptive_orient2d(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

///|
test "adaptive orient2d collinear" {
  let r = adaptive_orient2d(0.0, 0.0, 1.0, 1.0, 2.0, 2.0)
  assert_eq(r, 0)
}

///|
test "precision level" {
  assert_eq(precision_level(200.0, 1.0), 0)
  assert_eq(precision_level(50.0, 1.0), 1)
}

///|
test "adaptive orient2d negative" {
  let r = adaptive_orient2d(0.0, 0.0, 0.0, 1.0, 1.0, 0.0)
  assert_eq(r, -1)
}

///|
test "adaptive orient2d identical points" {
  let r = adaptive_orient2d(1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
  assert_eq(r, 0)
}

///|
test "adaptive orient2d two identical" {
  let r = adaptive_orient2d(0.0, 0.0, 0.0, 0.0, 1.0, 1.0)
  assert_eq(r, 0)
}

///|
test "adaptive orient2d large coords" {
  let r = adaptive_orient2d(0.0, 0.0, 1000.0, 0.0, 0.0, 1000.0)
  assert_eq(r, 1)
}

///|
test "adaptive orient2d negative coords" {
  let r = adaptive_orient2d(-1.0, -1.0, 1.0, -1.0, 0.0, 1.0)
  assert_true(r == 1 || r == -1)
}

///|
test "adaptive incircle inside" {
  let r = adaptive_incircle(0.0, 0.0, 2.0, 0.0, 0.0, 2.0, 1.0, 1.0)
  assert_eq(r, 1)
}

///|
test "adaptive incircle outside" {
  let r = adaptive_incircle(0.0, 0.0, 2.0, 0.0, 0.0, 2.0, 5.0, 5.0)
  assert_eq(r, -1)
}

///|
test "adaptive incircle on circle" {
  let r = adaptive_incircle(0.0, 0.0, 2.0, 0.0, 0.0, 2.0, 2.0, 0.0)
  assert_eq(r, 0)
}

///|
test "adaptive incircle collinear" {
  let r = adaptive_incircle(0.0, 0.0, 1.0, 0.0, 2.0, 0.0, 1.0, 1.0)
  ignore(r)
}

///|
test "adaptive incircle negative coords" {
  let r = adaptive_incircle(-1.0, -1.0, 1.0, -1.0, 0.0, 1.0, 0.0, 0.0)
  ignore(r)
}

///|
test "precision level low" {
  assert_eq(precision_level(0.5, 1.0), 2)
  assert_eq(precision_level(0.0, 1.0), 2)
}

///|
test "precision level boundary" {
  assert_eq(precision_level(100.0, 1.0), 1)
  assert_eq(precision_level(100.01, 1.0), 0)
}

///|
test "precision level negative det" {
  assert_eq(precision_level(-200.0, 1.0), 0)
  assert_eq(precision_level(-50.0, 1.0), 1)
  assert_eq(precision_level(-0.5, 1.0), 2)
}

///|
test "precision level zero bound" {
  assert_eq(precision_level(0.0, 0.0), 2)
}
