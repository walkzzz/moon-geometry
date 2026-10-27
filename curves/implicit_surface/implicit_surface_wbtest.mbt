///|
fn sphere_f(x : Double, y : Double, z : Double) -> Double {
  x * x + y * y + z * z - 1.0
}

///|
fn sphere_fx(x : Double, _y : Double, _z : Double) -> Double {
  2.0 * x
}

///|
fn sphere_fy(_x : Double, y : Double, _z : Double) -> Double {
  2.0 * y
}

///|
fn sphere_fz(_x : Double, _y : Double, z : Double) -> Double {
  2.0 * z
}

///|
fn sphere_fxx(_x : Double, _y : Double, _z : Double) -> Double {
  2.0
}

///|
fn zero(_x : Double, _y : Double, _z : Double) -> Double {
  0.0
}

///|
test "surface normal sphere" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let n = surface_normal(sphere_fx, sphere_fy, sphere_fz, p)
  assert_true((n.x - 1.0).abs() < 0.000000001)
  assert_true(n.y.abs() < 0.000000001)
  assert_true(n.z.abs() < 0.000000001)
}

///|
test "surface gradient" {
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let g = surface_gradient(sphere_fx, sphere_fy, sphere_fz, p)
  assert_true((g.x - 2.0).abs() < 0.000000001)
  assert_true((g.y - 2.0).abs() < 0.000000001)
  assert_true((g.z - 2.0).abs() < 0.000000001)
}

///|
test "surface gaussian curvature sphere" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let k = gaussian_curvature(
    sphere_fx, sphere_fy, sphere_fz, sphere_fxx, zero, zero, sphere_fxx, zero, sphere_fxx,
    p,
  )
  assert_true((k - 1.0).abs() < 0.000000001)
}

///|
test "surface mean curvature sphere" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let h = mean_curvature(
    sphere_fx, sphere_fy, sphere_fz, sphere_fxx, sphere_fxx, sphere_fxx, p,
  )
  assert_true((h - 1.0).abs() < 0.000000001)
}

///|
test "surface principal curvatures sphere" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let k_g = gaussian_curvature(
    sphere_fx, sphere_fy, sphere_fz, sphere_fxx, zero, zero, sphere_fxx, zero, sphere_fxx,
    p,
  )
  let k_m = mean_curvature(
    sphere_fx, sphere_fy, sphere_fz, sphere_fxx, sphere_fxx, sphere_fxx, p,
  )
  let (k1, k2) = principal_curvatures(k_g, k_m)
  assert_true((k1 - 1.0).abs() < 0.000000001)
  assert_true((k2 - 1.0).abs() < 0.000000001)
}

///|
test "surface project to surface" {
  let p = @core.Point3D::new(1.5, 0.0, 0.0)
  let proj = project_to_surface(
    sphere_f, sphere_fx, sphere_fy, sphere_fz, p, 20,
  )
  assert_true(sphere_f(proj.x, proj.y, proj.z).abs() < 0.0000001)
}

///|
test "surface tangent plane" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let (a, b, c, d) = tangent_plane(sphere_fx, sphere_fy, sphere_fz, p)
  assert_true((a - 2.0).abs() < 0.000000001)
  assert_true(b.abs() < 0.000000001)
  assert_true(c.abs() < 0.000000001)
  assert_true((d - -2.0).abs() < 0.000000001)
}

///|
test "surface sample points" {
  let pts = sample_surface(
    sphere_f, sphere_fx, sphere_fy, sphere_fz, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, 10,
  )
  assert_true(pts.length() > 0)
}

///|
test "surface normal unit length" {
  let p = @core.Point3D::new(0.0, 1.0, 0.0)
  let n = surface_normal(sphere_fx, sphere_fy, sphere_fz, p)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
}

///|
test "surface project already on surface" {
  let p = @core.Point3D::new(0.0, 0.0, 1.0)
  let proj = project_to_surface(
    sphere_f, sphere_fx, sphere_fy, sphere_fz, p, 20,
  )
  assert_true((proj.x - 0.0).abs() < 0.000000001)
  assert_true((proj.y - 0.0).abs() < 0.000000001)
  assert_true((proj.z - 1.0).abs() < 0.000000001)
}

///|
fn zero_f(_x : Double, _y : Double, _z : Double) -> Double {
  0.0
}

///|
test "surface normal zero gradient" {
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let n = surface_normal(zero_f, zero_f, zero_f, p)
  assert_true(n.x.abs() < 0.000000001)
  assert_true(n.y.abs() < 0.000000001)
  assert_true(n.z.abs() < 0.000000001)
}

///|
test "surface gaussian curvature zero gradient" {
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let k = gaussian_curvature(
    zero_f, zero_f, zero_f, zero_f, zero_f, zero_f, zero_f, zero_f, zero_f, p,
  )
  assert_true(k.abs() < 0.000000001)
}

///|
test "surface mean curvature zero gradient" {
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let h = mean_curvature(zero_f, zero_f, zero_f, zero_f, zero_f, zero_f, p)
  assert_true(h.abs() < 0.000000001)
}

///|
test "surface principal curvatures disc negative" {
  // k_mean^2 < k_gauss -> disc < 0
  let (k1, k2) = principal_curvatures(2.0, 1.0)
  assert_true((k1 - 1.0).abs() < 0.000000001)
  assert_true((k2 - 1.0).abs() < 0.000000001)
}

///|
test "surface project zero gradient" {
  // f = constant nonzero, gradient = 0 -> g2 < eps
  fn const_f(_x : Double, _y : Double, _z : Double) -> Double {
    5.0
  }
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let proj = project_to_surface(const_f, zero_f, zero_f, zero_f, p, 10)
  assert_true((proj.x - 1.0).abs() < 0.000000001)
  assert_true((proj.y - 1.0).abs() < 0.000000001)
  assert_true((proj.z - 1.0).abs() < 0.000000001)
}

///|
test "surface project max iterations" {
  // f = x^2 + y^2 + z^2 + 1 (no root), gradient never zero
  // Project from far point, may not converge in few iterations
  fn no_root_f(x : Double, y : Double, z : Double) -> Double {
    x * x + y * y + z * z + 1.0
  }
  let p = @core.Point3D::new(2.0, 2.0, 2.0)
  let proj = project_to_surface(
    no_root_f, sphere_fx, sphere_fy, sphere_fz, p, 2,
  )
  // Should return after max_iter without converging (point moved)
  assert_true((proj.x - 2.0).abs() > 0.001)
}
