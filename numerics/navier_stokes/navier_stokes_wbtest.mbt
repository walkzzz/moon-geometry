///|
test "ns_advection" {
  let u = ns_advection([0.0, 1.0, 0.0], [0.0, 0.0, 0.0], 1.0, 1.0)
  assert_eq(u.length(), 3)
}

///|
test "ns_reynolds_number" {
  let re = ns_reynolds_number(1.0, 1.0, 1.0, 1.0)
  assert_true(re > 0.99 && re < 1.01)
}

///|
test "ns_reynolds_number zero mu" {
  let re = ns_reynolds_number(1.0, 1.0, 1.0, 0.0)
  assert_true(re.abs() < 0.000001)
}

///|
test "ns_reynolds_number scaling" {
  let re = ns_reynolds_number(2.0, 3.0, 4.0, 0.5)
  assert_true((re - 48.0).abs() < 0.001)
}

///|
test "ns_diffusion constant" {
  let u = [1.0, 1.0, 1.0, 1.0]
  let result = ns_diffusion(u, 0.1, 1.0)
  assert_eq(result.length(), 4)
  assert_true(result[1].abs() < 0.000001)
}

///|
test "ns_diffusion nonuniform" {
  let u = [0.0, 0.0, 1.0, 0.0, 0.0]
  let result = ns_diffusion(u, 1.0, 1.0)
  assert_eq(result.length(), 5)
  assert_true((result[2] + 2.0).abs() < 0.000001)
}

///|
test "ns_pressure_gradient linear" {
  let p = [0.0, 1.0, 2.0, 3.0, 4.0]
  let result = ns_pressure_gradient(p, 1.0)
  assert_eq(result.length(), 5)
  assert_true((result[2] - 1.0).abs() < 0.000001)
}

///|
test "ns_pressure_gradient constant" {
  let p = [5.0, 5.0, 5.0]
  let result = ns_pressure_gradient(p, 1.0)
  assert_true(result[1].abs() < 0.000001)
}

///|
test "ns_advection zero velocity" {
  let u = [0.0, 0.0, 0.0]
  let v = [1.0, 2.0, 3.0]
  let result = ns_advection(u, v, 1.0, 1.0)
  assert_true((result[1] + 2.0).abs() < 0.000001)
}
