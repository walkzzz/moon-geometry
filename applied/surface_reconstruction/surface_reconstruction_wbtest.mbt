///|
test "ball pivoting simple" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let (verts, tris) = ball_pivoting(pts, 1.0)
  assert_eq(verts.length(), 3)
  assert_true(tris.length() >= 1)
}

///|
test "ball pivoting empty" {
  let pts : Array[@core.Point3D] = []
  let (verts, tris) = ball_pivoting(pts, 1.0)
  assert_eq(verts.length(), 0)
  assert_eq(tris.length(), 0)
}

///|
test "ball pivoting far points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
  ]
  let (verts, tris) = ball_pivoting(pts, 1.0)
  assert_eq(verts.length(), 3)
  assert_eq(tris.length(), 0)
}

///|
test "alpha shape 3d simple" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let (verts, tris) = alpha_shape_3d(pts, 1.0)
  assert_eq(verts.length(), 3)
  assert_true(tris.length() >= 1)
}

///|
test "alpha shape 3d empty" {
  let pts : Array[@core.Point3D] = []
  let (verts, tris) = alpha_shape_3d(pts, 1.0)
  assert_eq(verts.length(), 0)
  assert_eq(tris.length(), 0)
}

///|
test "alpha shape 3d large alpha" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let (verts, tris) = alpha_shape_3d(pts, 10.0)
  assert_eq(verts.length(), 3)
  assert_eq(tris.length(), 0)
}
