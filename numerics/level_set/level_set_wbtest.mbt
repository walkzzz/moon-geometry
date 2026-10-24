///|
test "level_set_sign" {
  assert_eq(level_set_sign(1.0), 1)
  assert_eq(level_set_sign(-1.0), -1)
  assert_eq(level_set_sign(0.0), 0)
}

///|
test "level_set_normal" {
  let (nx, ny) = level_set_normal((3.0, 4.0))
  assert_true((nx - 0.6).abs() < 0.001)
  assert_true((ny - 0.8).abs() < 0.001)
}

///|
test "level_set_area" {
  let a = level_set_area([-1.0, -1.0, 1.0, 1.0], 1.0)
  assert_true((a - 2.0).abs() < 0.001)
}

///|
test "level_set_normal zero gradient" {
  let (nx, ny) = level_set_normal((0.0, 0.0))
  assert_eq(nx, 0.0)
  assert_eq(ny, 0.0)
}

///|
test "level_set_normal unit x" {
  let (nx, ny) = level_set_normal((1.0, 0.0))
  assert_true((nx - 1.0).abs() < 0.001)
  assert_true(ny.abs() < 0.001)
}

///|
test "level_set_curvature zero gradient" {
  let k = level_set_curvature((0.0, 0.0), (1.0, 0.0, 1.0))
  assert_eq(k, 0.0)
}

///|
test "level_set_curvature circle" {
  // For a circle phi = x^2 + y^2 - r^2, grad=(2x,2y), hessian=(2,0,2)
  // curvature at (1,0): grad=(2,0), curvature = (4*2)/(2^3) = 0.5
  let k = level_set_curvature((2.0, 0.0), (2.0, 0.0, 2.0))
  assert_true((k - 1.0).abs() < 0.001)
}

///|
test "reinitialize_step positive" {
  // phi=0.5, dt=0.1, s0=1 -> 0.5 + 0.1 * 1 * (1 - 0.5) = 0.55
  let r = reinitialize_step(0.5, 0.1, 1)
  assert_true((r - 0.55).abs() < 0.001)
}

///|
test "reinitialize_step negative" {
  // phi=-0.5, dt=0.1, s0=-1 -> -0.5 + 0.1 * -1 * (1 - 0.5) = -0.55
  let r = reinitialize_step(-0.5, 0.1, -1)
  assert_true((r - -0.55).abs() < 0.001)
}

///|
test "reinitialize_step zero dt" {
  let r = reinitialize_step(0.7, 0.0, 1)
  assert_true((r - 0.7).abs() < 0.001)
}

///|
test "level_set_area empty" {
  let a = level_set_area([], 1.0)
  assert_eq(a, 0.0)
}

///|
test "level_set_area dx scaling" {
  let a = level_set_area([-1.0, -1.0], 2.0)
  assert_true((a - 8.0).abs() < 0.001)
}
