///|
test "convex_hull3d_tetrahedron" {
  let points = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let faces = convex_hull_3d(points)
  assert_eq(faces.length(), 4)
}

///|
test "convex_hull3d_face_count" {
  let points = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let faces = convex_hull_3d(points)
  assert_eq(hull_face_count(faces), 4)
}

///|
test "convex_hull3d_volume" {
  let points = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let faces = convex_hull_3d(points)
  let vol = hull_volume(points, faces)
  assert_true(vol > 0.0)
}

///|
test "convex_hull3d_octahedron" {
  let points = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, -1.0),
  ]
  let faces = convex_hull_3d(points)
  assert_eq(faces.length(), 8)
}
