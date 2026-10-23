///|
test "reflect" {
  let r = reflect((1.0, -1.0, 0.0), (0.0, 1.0, 0.0))
  assert_true(r.0 > 0.99 && r.0 < 1.01)
  assert_true(r.1 > 0.99 && r.1 < 1.01)
}

///|
test "fresnel_schlick" {
  let f = fresnel_schlick(1.0, 0.04)
  assert_true(f > 0.03 && f < 0.05)
}

///|
test "refract_normal_incidence" {
  let r = refract((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), 1.0)
  assert_true(r.0.abs() < 0.001)
  assert_true(r.1.abs() < 0.001)
}

///|
test "refract_total_internal_reflection" {
  let r = refract((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), 2.0)
  assert_true(r.0.abs() < 0.001 && r.1.abs() < 0.001 && r.2.abs() < 0.001)
}

///|
test "ray_plane_t_hit" {
  let t = ray_plane_t(
    (0.0, 0.0, 0.0),
    (0.0, 0.0, 1.0),
    (0.0, 0.0, 1.0),
    (0.0, 0.0, 1.0),
  )
  assert_true((t - 1.0).abs() < 0.001)
}

///|
test "ray_plane_t_parallel" {
  let t = ray_plane_t(
    (0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0),
    (0.0, 0.0, 1.0),
    (0.0, 0.0, 1.0),
  )
  assert_eq(t, -1.0)
}

///|
test "ray_plane_t_behind" {
  let t = ray_plane_t(
    (0.0, 0.0, 0.0),
    (0.0, 0.0, 1.0),
    (0.0, 0.0, -1.0),
    (0.0, 0.0, 1.0),
  )
  assert_eq(t, -1.0)
}
