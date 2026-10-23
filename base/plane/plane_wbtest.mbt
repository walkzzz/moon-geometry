///|
test "plane_from_normal_point" {
  let normal = @core.Point3D::new(0.0, 0.0, 1.0)
  let point = @core.Point3D::new(1.0, 2.0, 3.0)
  let plane = Plane::from_normal_point(normal, point)
  assert_true(@core.approx_eq(plane.d, -3.0, 0.000000000001))
}

///|
test "plane_from_three_points" {
  let a = @core.Point3D::new(1.0, 0.0, 0.0)
  let b = @core.Point3D::new(0.0, 1.0, 0.0)
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let plane = Plane::from_three_points(a, b, c)
  let p = @core.Point3D::new(0.5, 0.5, 0.0)
  assert_true(Plane::contains(plane, p, 0.000000000001))
}

///|
test "plane_distance" {
  let normal = @core.Point3D::new(0.0, 0.0, 1.0)
  let point = @core.Point3D::new(0.0, 0.0, 0.0)
  let plane = Plane::from_normal_point(normal, point)
  let p = @core.Point3D::new(1.0, 2.0, 5.0)
  let d = Plane::distance(plane, p)
  assert_true(@core.approx_eq(d, 5.0, 0.000000000001))
}

///|
test "plane_contains" {
  let normal = @core.Point3D::new(1.0, 1.0, 1.0)
  let point = @core.Point3D::new(1.0, 0.0, 0.0)
  let plane = Plane::from_normal_point(normal, point)
  let p = @core.Point3D::new(0.0, 1.0, 0.0)
  assert_true(Plane::contains(plane, p, 0.000000000001))
}

///|
test "plane_line_intersect" {
  let normal = @core.Point3D::new(0.0, 0.0, 1.0)
  let point = @core.Point3D::new(0.0, 0.0, 5.0)
  let plane = Plane::from_normal_point(normal, point)
  let origin = @core.Point3D::new(0.0, 0.0, 0.0)
  let dir = @core.Point3D::new(0.0, 0.0, 1.0)
  match Plane::line_intersect(plane, origin, dir) {
    Some(p) => assert_true(@core.approx_eq(p.z, 5.0, 0.000000000001))
    None => assert_true(false)
  }
}

///|
test "plane_line_parallel" {
  let normal = @core.Point3D::new(0.0, 0.0, 1.0)
  let point = @core.Point3D::new(0.0, 0.0, 5.0)
  let plane = Plane::from_normal_point(normal, point)
  let origin = @core.Point3D::new(0.0, 0.0, 0.0)
  let dir = @core.Point3D::new(1.0, 0.0, 0.0)
  match Plane::line_intersect(plane, origin, dir) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "plane_normalize" {
  let normal = @core.Point3D::new(0.0, 0.0, 3.0)
  let point = @core.Point3D::new(0.0, 0.0, 1.0)
  let plane = Plane::from_normal_point(normal, point)
  let np = Plane::normalize(plane)
  let nlen = (np.normal.x * np.normal.x +
  np.normal.y * np.normal.y +
  np.normal.z * np.normal.z).sqrt()
  assert_true(@core.approx_eq(nlen, 1.0, 0.000000000001))
}

///|
test "plane_project" {
  let normal = @core.Point3D::new(0.0, 0.0, 1.0)
  let point = @core.Point3D::new(0.0, 0.0, 0.0)
  let plane = Plane::from_normal_point(normal, point)
  let p = @core.Point3D::new(3.0, 4.0, 5.0)
  let proj = Plane::project(plane, p)
  assert_true(@core.approx_eq(proj.x, 3.0, 0.000000000001))
  assert_true(@core.approx_eq(proj.y, 4.0, 0.000000000001))
  assert_true(@core.approx_eq(proj.z, 0.0, 0.000000000001))
}
