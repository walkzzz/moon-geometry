///|
test "dynamic hull empty" {
  let h = DynamicHull3D::new()
  assert_eq(DynamicHull3D::size(h), 0)
  assert_eq(DynamicHull3D::face_count(h), 0)
}

///|
test "dynamic hull tetrahedron" {
  let h = DynamicHull3D::new()
  h.insert(@core.Point3D::new(0.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(1.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 1.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 0.0, 1.0))
  assert_eq(DynamicHull3D::size(h), 4)
  assert_eq(DynamicHull3D::face_count(h), 4)
}

///|
test "dynamic hull cube" {
  let h = DynamicHull3D::new()
  h.insert(@core.Point3D::new(0.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(1.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 1.0, 0.0))
  h.insert(@core.Point3D::new(1.0, 1.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 0.0, 1.0))
  h.insert(@core.Point3D::new(1.0, 0.0, 1.0))
  h.insert(@core.Point3D::new(0.0, 1.0, 1.0))
  h.insert(@core.Point3D::new(1.0, 1.0, 1.0))
  assert_eq(DynamicHull3D::size(h), 8)
  assert_eq(DynamicHull3D::face_count(h), 12)
}

///|
test "dynamic hull with interior point" {
  let h = DynamicHull3D::new()
  h.insert(@core.Point3D::new(0.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(2.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 2.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 0.0, 2.0))
  h.insert(@core.Point3D::new(0.5, 0.5, 0.5))
  assert_eq(DynamicHull3D::size(h), 5)
  assert_eq(DynamicHull3D::face_count(h), 4)
}

///|
test "dynamic hull volume" {
  let h = DynamicHull3D::new()
  h.insert(@core.Point3D::new(0.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(1.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 1.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 0.0, 1.0))
  let v = DynamicHull3D::volume(h)
  assert_true(v.abs() > 0.0)
}

///|
test "dynamic hull surface area" {
  let h = DynamicHull3D::new()
  h.insert(@core.Point3D::new(0.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(1.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 1.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 0.0, 1.0))
  let a = DynamicHull3D::surface_area(h)
  assert_true(a > 0.0)
}

///|
test "compute hull 3d directly" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let faces = compute_hull_3d(pts)
  assert_eq(faces.length(), 4)
}

///|
test "dynamic hull octahedron" {
  let h = DynamicHull3D::new()
  h.insert(@core.Point3D::new(1.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(-1.0, 0.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 1.0, 0.0))
  h.insert(@core.Point3D::new(0.0, -1.0, 0.0))
  h.insert(@core.Point3D::new(0.0, 0.0, 1.0))
  h.insert(@core.Point3D::new(0.0, 0.0, -1.0))
  assert_eq(DynamicHull3D::size(h), 6)
  assert_true(DynamicHull3D::face_count(h) >= 8)
}
