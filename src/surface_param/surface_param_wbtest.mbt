test "eval_surface basic" {
  let s = fn(u : Double, v : Double) {
    (u, v, u * v)
  }
  let (x, y, z) = eval_surface(s, 2.0, 3.0)
  assert_true((x - 2.0).abs() < 0.0001)
  assert_true((y - 3.0).abs() < 0.0001)
  assert_true((z - 6.0).abs() < 0.0001)
}

test "surface_du basic" {
  let s = fn(u : Double, v : Double) {
    (u * u, v, 0.0)
  }
  let (dx, _, _) = surface_du(s, 1.0, 0.0, 0.001)
  assert_true((dx - 2.0).abs() < 0.01)
}

test "surface_dv basic" {
  let s = fn(u : Double, v : Double) {
    (u, v * v, 0.0)
  }
  let (_, dy, _) = surface_dv(s, 0.0, 1.0, 0.001)
  assert_true((dy - 2.0).abs() < 0.01)
}

test "surface_normal basic" {
  let s = fn(u : Double, v : Double) {
    (u, v, 0.0)
  }
  let (_, _, nz) = surface_normal(s, 0.5, 0.5, 0.001)
  assert_true((nz - 1.0).abs() < 0.01 || (nz + 1.0).abs() < 0.01)
}

test "first_fundamental_form plane" {
  let s = fn(u : Double, v : Double) {
    (u, v, 0.0)
  }
  let (e, f, g) = first_fundamental_form(s, 0.5, 0.5, 0.001)
  assert_true((e - 1.0).abs() < 0.01)
  assert_true(f.abs() < 0.01)
  assert_true((g - 1.0).abs() < 0.01)
}

test "gaussian_curvature plane" {
  let s = fn(u : Double, v : Double) {
    (u, v, 0.0)
  }
  let k = gaussian_curvature(s, 0.5, 0.5, 0.001)
  assert_true(k.abs() < 0.1)
}