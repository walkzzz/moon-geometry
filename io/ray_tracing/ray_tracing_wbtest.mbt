///|
test "ray eval" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  )
  let p = ray_eval(r, 5.0)
  assert_true(@core.approx_eq(p.x, 5.0, 0.000001))
  assert_true(@core.approx_eq(p.y, 0.0, 0.000001))
}

///|
test "ray triangle hit" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, -1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let v0 = @core.Point3D::new(-1.0, -1.0, 0.0)
  let v1 = @core.Point3D::new(1.0, -1.0, 0.0)
  let v2 = @core.Point3D::new(0.0, 1.0, 0.0)
  match ray_triangle_intersect(r, v0, v1, v2) {
    Some(t) => assert_true(@core.approx_eq(t, 1.0, 0.0001))
    None => assert_true(false)
  }
}

///|
test "ray triangle miss" {
  let r = Ray3::new(
    @core.Point3D::new(5.0, 5.0, -1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let v0 = @core.Point3D::new(-1.0, -1.0, 0.0)
  let v1 = @core.Point3D::new(1.0, -1.0, 0.0)
  let v2 = @core.Point3D::new(0.0, 1.0, 0.0)
  match ray_triangle_intersect(r, v0, v1, v2) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray sphere hit" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match ray_sphere_intersect(r, @core.Point3D::new(0.0, 0.0, 0.0), 1.0) {
    Some(t) => assert_true(@core.approx_eq(t, 4.0, 0.0001))
    None => assert_true(false)
  }
}

///|
test "ray sphere miss" {
  let r = Ray3::new(
    @core.Point3D::new(5.0, 0.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match ray_sphere_intersect(r, @core.Point3D::new(0.0, 0.0, 0.0), 1.0) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray plane hit" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, -1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match
    ray_plane_intersect(
      r,
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 1.0),
    ) {
    Some(t) => assert_true(@core.approx_eq(t, 1.0, 0.0001))
    None => assert_true(false)
  }
}

///|
test "ray plane parallel" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  )
  match
    ray_plane_intersect(
      r,
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 1.0),
    ) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "point in shadow" {
  let tri = (
    @core.Point3D::new(-1.0, -1.0, 0.0),
    @core.Point3D::new(1.0, -1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  )
  let point = @core.Point3D::new(0.0, 0.0, -1.0)
  let light = @core.Point3D::new(0.0, 0.0, 1.0)
  assert_true(point_in_shadow(point, light, [tri]))
}

///|
test "point not in shadow" {
  let tri = (
    @core.Point3D::new(-1.0, -1.0, 5.0),
    @core.Point3D::new(1.0, -1.0, 5.0),
    @core.Point3D::new(0.0, 1.0, 5.0),
  )
  let point = @core.Point3D::new(0.0, 0.0, 0.0)
  let light = @core.Point3D::new(0.0, 0.0, 1.0)
  assert_false(point_in_shadow(point, light, [tri]))
}

///|
test "ray nearest triangle" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let tri1 = (
    @core.Point3D::new(-1.0, -1.0, 0.0),
    @core.Point3D::new(1.0, -1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  )
  let tri2 = (
    @core.Point3D::new(-1.0, -1.0, -2.0),
    @core.Point3D::new(1.0, -1.0, -2.0),
    @core.Point3D::new(0.0, 1.0, -2.0),
  )
  match ray_nearest_triangle(r, [tri1, tri2]) {
    Some((_, idx)) => assert_eq(idx, 1)
    None => assert_true(false)
  }
}
///|
test "ray eval negative t" {
  let r = Ray3::new(
    @core.Point3D::new(5.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  )
  let p = ray_eval(r, -3.0)
  assert_true(@core.approx_eq(p.x, 2.0, 0.000001))
}

///|
test "ray eval zero t" {
  let r = Ray3::new(
    @core.Point3D::new(3.0, 4.0, 5.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  )
  let p = ray_eval(r, 0.0)
  assert_true(@core.approx_eq(p.x, 3.0, 0.000001))
  assert_true(@core.approx_eq(p.y, 4.0, 0.000001))
  assert_true(@core.approx_eq(p.z, 5.0, 0.000001))
}

///|
test "ray eval 3d" {
  let r = Ray3::new(
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(2.0, 3.0, 4.0),
  )
  let p = ray_eval(r, 2.0)
  assert_true(@core.approx_eq(p.x, 5.0, 0.000001))
  assert_true(@core.approx_eq(p.y, 8.0, 0.000001))
  assert_true(@core.approx_eq(p.z, 11.0, 0.000001))
}

///|
test "ray triangle parallel" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  )
  let v0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let v1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let v2 = @core.Point3D::new(2.0, 0.0, 0.0)
  match ray_triangle_intersect(r, v0, v1, v2) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray triangle behind" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let v0 = @core.Point3D::new(-1.0, -1.0, 0.0)
  let v1 = @core.Point3D::new(1.0, -1.0, 0.0)
  let v2 = @core.Point3D::new(0.0, 1.0, 0.0)
  match ray_triangle_intersect(r, v0, v1, v2) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray sphere tangent" {
  let r = Ray3::new(
    @core.Point3D::new(1.0, 0.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match ray_sphere_intersect(r, @core.Point3D::new(0.0, 0.0, 0.0), 1.0) {
    Some(t) => assert_true(t > 0.0)
    None => assert_true(true)
  }
}

///|
test "ray sphere inside" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match ray_sphere_intersect(r, @core.Point3D::new(0.0, 0.0, 0.0), 5.0) {
    Some(t) => assert_true(t > 0.0)
    None => assert_true(false)
  }
}

///|
test "ray sphere behind" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match ray_sphere_intersect(r, @core.Point3D::new(0.0, 0.0, 0.0), 1.0) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray plane behind" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match
    ray_plane_intersect(
      r,
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 1.0),
    ) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray plane hit 3d" {
  let r = Ray3::new(
    @core.Point3D::new(1.0, 2.0, -3.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match
    ray_plane_intersect(
      r,
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 1.0),
    ) {
    Some(t) => assert_true(@core.approx_eq(t, 3.0, 0.0001))
    None => assert_true(false)
  }
}

///|
test "point in shadow empty triangles" {
  let point = @core.Point3D::new(0.0, 0.0, 0.0)
  let light = @core.Point3D::new(0.0, 0.0, 5.0)
  assert_false(point_in_shadow(point, light, []))
}

///|
test "point in shadow same point" {
  let point = @core.Point3D::new(1.0, 2.0, 3.0)
  let light = @core.Point3D::new(1.0, 2.0, 3.0)
  assert_false(point_in_shadow(point, light, []))
}

///|
test "point in shadow multiple triangles" {
  let tri1 = (
    @core.Point3D::new(-1.0, -1.0, 0.0),
    @core.Point3D::new(1.0, -1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  )
  let tri2 = (
    @core.Point3D::new(-2.0, -2.0, 0.0),
    @core.Point3D::new(2.0, -2.0, 0.0),
    @core.Point3D::new(0.0, 2.0, 0.0),
  )
  let point = @core.Point3D::new(0.0, 0.0, -1.0)
  let light = @core.Point3D::new(0.0, 0.0, 1.0)
  assert_true(point_in_shadow(point, light, [tri1, tri2]))
}

///|
test "ray nearest triangle empty" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  match ray_nearest_triangle(r, []) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray nearest triangle all miss" {
  let r = Ray3::new(
    @core.Point3D::new(100.0, 100.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let tri = (
    @core.Point3D::new(-1.0, -1.0, 0.0),
    @core.Point3D::new(1.0, -1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  )
  match ray_nearest_triangle(r, [tri]) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray nearest triangle single hit" {
  let r = Ray3::new(
    @core.Point3D::new(0.0, 0.0, -5.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  )
  let tri = (
    @core.Point3D::new(-1.0, -1.0, 0.0),
    @core.Point3D::new(1.0, -1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  )
  match ray_nearest_triangle(r, [tri]) {
    Some((t, idx)) => {
      assert_true(t > 0.0)
      assert_eq(idx, 0)
    }
    None => assert_true(false)
  }
}

///|
test "Ray3 new basic" {
  let r = Ray3::new(
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(4.0, 5.0, 6.0),
  )
  assert_true(@core.approx_eq(r.origin.x, 1.0, 0.000001))
  assert_true(@core.approx_eq(r.dir.x, 4.0, 0.000001))
}
