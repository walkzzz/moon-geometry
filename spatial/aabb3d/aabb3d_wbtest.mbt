///|
test "aabb3d from points" {
  let pts = [
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(-1.0, 5.0, 0.0),
    @core.Point3D::new(3.0, -2.0, 4.0),
  ]
  let b = AABB3D::from_points(pts)
  assert_eq(b.min_x, -1.0)
  assert_eq(b.min_y, -2.0)
  assert_eq(b.min_z, 0.0)
  assert_eq(b.max_x, 3.0)
  assert_eq(b.max_y, 5.0)
  assert_eq(b.max_z, 4.0)
}

///|
test "aabb3d volume" {
  let b = AABB3D::new(0.0, 0.0, 0.0, 2.0, 3.0, 4.0)
  assert_eq(AABB3D::volume(b), 24.0)
}

///|
test "aabb3d surface area" {
  let b = AABB3D::new(0.0, 0.0, 0.0, 2.0, 3.0, 4.0)
  assert_eq(AABB3D::surface_area(b), 52.0)
}

///|
test "aabb3d center" {
  let b = AABB3D::new(0.0, 0.0, 0.0, 2.0, 4.0, 6.0)
  let c = AABB3D::center(b)
  assert_eq(c.x, 1.0)
  assert_eq(c.y, 2.0)
  assert_eq(c.z, 3.0)
}

///|
test "aabb3d intersects" {
  let a = AABB3D::new(0.0, 0.0, 0.0, 2.0, 2.0, 2.0)
  let b = AABB3D::new(1.0, 1.0, 1.0, 3.0, 3.0, 3.0)
  let c = AABB3D::new(3.0, 3.0, 3.0, 5.0, 5.0, 5.0)
  assert_true(AABB3D::intersects(a, b))
  assert_false(AABB3D::intersects(a, c))
}

///|
test "aabb3d contains point" {
  let b = AABB3D::new(0.0, 0.0, 0.0, 2.0, 2.0, 2.0)
  assert_true(AABB3D::contains_point(b, @core.Point3D::new(1.0, 1.0, 1.0)))
  assert_false(AABB3D::contains_point(b, @core.Point3D::new(3.0, 1.0, 1.0)))
}

///|
test "aabb3d merge" {
  let a = AABB3D::new(0.0, 0.0, 0.0, 2.0, 2.0, 2.0)
  let b = AABB3D::new(1.0, 1.0, 1.0, 3.0, 3.0, 3.0)
  let m = AABB3D::merge(a, b)
  assert_eq(m.min_x, 0.0)
  assert_eq(m.max_x, 3.0)
  assert_eq(m.min_y, 0.0)
  assert_eq(m.max_y, 3.0)
}

///|
test "aabb3d ray intersect hit" {
  let b = AABB3D::new(-1.0, -1.0, -1.0, 1.0, 1.0, 1.0)
  let origin = @core.Point3D::new(-5.0, 0.0, 0.0)
  let dir = @core.Point3D::new(1.0, 0.0, 0.0)
  match AABB3D::ray_intersect(b, origin, dir) {
    Some((t_min, t_max)) => {
      assert_true(t_min > 0.0)
      assert_true(t_max > t_min)
    }
    None => assert_true(false)
  }
}

///|
test "aabb3d ray intersect miss" {
  let b = AABB3D::new(-1.0, -1.0, -1.0, 1.0, 1.0, 1.0)
  let origin = @core.Point3D::new(-5.0, 5.0, 0.0)
  let dir = @core.Point3D::new(1.0, 0.0, 0.0)
  match AABB3D::ray_intersect(b, origin, dir) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}
