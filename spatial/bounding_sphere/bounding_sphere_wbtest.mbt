test "bounding sphere single point" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let s = min_bounding_sphere(pts)
  assert_eq(s.center.x, 1.0)
  assert_eq(s.center.y, 2.0)
  assert_eq(s.center.z, 3.0)
  assert_eq(s.radius, 0.0)
}

test "bounding sphere two points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let s = min_bounding_sphere(pts)
  assert_true((s.center.x - 1.0).abs() < 0.0000001)
  assert_true((s.radius - 1.0).abs() < 0.0000001)
}

test "bounding sphere tetrahedron" {
  let pts = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
  ]
  let s = min_bounding_sphere(pts)
  assert_true(s.radius > 0.0)
  for p in pts {
    let d = s.center.dist(p)
    assert_true(d <= s.radius + 0.001)
  }
}

test "bounding sphere cube corners" {
  let pts = [
    @core.Point3D::new(1.0, 1.0, 1.0),
    @core.Point3D::new(-1.0, -1.0, -1.0),
    @core.Point3D::new(1.0, -1.0, 1.0),
    @core.Point3D::new(-1.0, 1.0, -1.0),
    @core.Point3D::new(1.0, 1.0, -1.0),
    @core.Point3D::new(-1.0, -1.0, 1.0),
  ]
  let s = min_bounding_sphere(pts)
  for p in pts {
    let d = s.center.dist(p)
    assert_true(d <= s.radius + 0.001)
  }
}

test "bounding sphere volume" {
  let s = BoundingSphere::new(@core.Point3D::new(0.0, 0.0, 0.0), 2.0)
  let v = BoundingSphere::volume(s)
  assert_true((v - 33.5103216).abs() < 0.01)
}

test "bounding sphere surface area" {
  let s = BoundingSphere::new(@core.Point3D::new(0.0, 0.0, 0.0), 2.0)
  let a = BoundingSphere::surface_area(s)
  assert_true((a - 50.2654824).abs() < 0.01)
}

test "bounding sphere empty" {
  let s = min_bounding_sphere([])
  assert_eq(s.radius, 0.0)
}

test "bounding sphere contains all" {
  let pts = [
    @core.Point3D::new(3.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 3.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 3.0),
    @core.Point3D::new(-3.0, 0.0, 0.0),
    @core.Point3D::new(0.0, -3.0, 0.0),
    @core.Point3D::new(0.0, 0.0, -3.0),
  ]
  let s = min_bounding_sphere(pts)
  for p in pts {
    let d = s.center.dist(p)
    assert_true(d <= s.radius + 0.001)
  }
}