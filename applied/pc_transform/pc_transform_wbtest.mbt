///|
test "translate_cloud" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let r = translate_cloud(pts, 1.0, 2.0, 3.0)
  assert_true((r[0].x - 1.0).abs() < 0.001)
  assert_true((r[0].y - 2.0).abs() < 0.001)
}

///|
test "scale_cloud" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let r = scale_cloud(pts, 2.0)
  assert_true((r[0].x - 2.0).abs() < 0.001)
}

///|
test "center_cloud" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let r = center_cloud(pts)
  assert_true((r[0].x + 1.0).abs() < 0.001)
  assert_true((r[1].x - 1.0).abs() < 0.001)
}

///|
test "rotate_z_cloud zero angle" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let r = rotate_z_cloud(pts, 0.0)
  assert_true((r[0].x - 1.0).abs() < 0.001)
  assert_true((r[0].y - 2.0).abs() < 0.001)
  assert_true((r[0].z - 3.0).abs() < 0.001)
}

///|
test "rotate_z_cloud 90 degrees" {
  // rotate (1,0,0) by pi/2 around Z -> (0,1,0)
  let pts = [@core.Point3D::new(1.0, 0.0, 0.0)]
  let r = rotate_z_cloud(pts, 1.5707963267948966)
  assert_true(r[0].x.abs() < 0.001)
  assert_true((r[0].y - 1.0).abs() < 0.001)
}

///|
test "rotate_z_cloud 180 degrees" {
  // rotate (1,2,3) by pi around Z -> (-1,-2,3)
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let r = rotate_z_cloud(pts, 3.141592653589793)
  assert_true((r[0].x + 1.0).abs() < 0.001)
  assert_true((r[0].y + 2.0).abs() < 0.001)
  assert_true((r[0].z - 3.0).abs() < 0.001)
}

///|
test "translate_cloud empty" {
  let r = translate_cloud([], 1.0, 2.0, 3.0)
  assert_eq(r.length(), 0)
}

///|
test "scale_cloud negative factor" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let r = scale_cloud(pts, -1.0)
  assert_true((r[0].x + 1.0).abs() < 0.001)
  assert_true((r[0].y + 2.0).abs() < 0.001)
}

///|
test "scale_cloud zero factor" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let r = scale_cloud(pts, 0.0)
  assert_eq(r[0].x, 0.0)
  assert_eq(r[0].y, 0.0)
  assert_eq(r[0].z, 0.0)
}

///|
test "center_cloud empty" {
  let r = center_cloud([])
  assert_eq(r.length(), 0)
}

///|
test "center_cloud single point" {
  let pts = [@core.Point3D::new(5.0, 6.0, 7.0)]
  let r = center_cloud(pts)
  assert_true(r[0].x.abs() < 0.001)
  assert_true(r[0].y.abs() < 0.001)
  assert_true(r[0].z.abs() < 0.001)
}

///|
test "rotate_z_cloud preserves z" {
  let pts = [@core.Point3D::new(1.0, 1.0, 5.0)]
  let r = rotate_z_cloud(pts, 0.5)
  assert_true((r[0].z - 5.0).abs() < 0.001)
}
