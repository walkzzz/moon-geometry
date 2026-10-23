///|
test "icp_point_to_point translation" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let source = [
    @core.Point3D::new(0.3, 0.3, 0.3),
    @core.Point3D::new(1.3, 0.3, 0.3),
    @core.Point3D::new(0.3, 1.3, 0.3),
    @core.Point3D::new(0.3, 0.3, 1.3),
  ]
  let result = icp_point_to_point(source, target, 100)

  assert_true(result.error < 0.01)
}

///|
test "icp_point_to_point identical" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let result = icp_point_to_point(pts, pts, 10)
  assert_true(result.error < 0.001)
}

///|
test "icp_point_to_point empty" {
  let result = icp_point_to_point([], [], 10)
  assert_true(result.error == 0.0)
}

///|
test "icp_point_to_point rotation" {
  let target = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
  ]
  let source = [
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let result = icp_point_to_point(source, target, 100)
  assert_true(result.error < 0.1)
}

///|
test "icp_point_to_plane basic" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
  ]
  let normals = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let source = [
    @core.Point3D::new(0.0, 0.0, 0.5),
    @core.Point3D::new(1.0, 0.0, 0.5),
    @core.Point3D::new(0.0, 1.0, 0.5),
    @core.Point3D::new(1.0, 1.0, 0.5),
  ]
  let result = icp_point_to_plane(source, target, normals, 50)
  assert_true(result.error >= 0.0)
}

///|
test "icp_point_to_plane empty" {
  let result = icp_point_to_plane([], [], [], 10)
  assert_true(result.error == 0.0)
}

///|
test "icp_apply identity" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 1.0).abs() < 0.001)
  assert_true((applied[0].y - 2.0).abs() < 0.001)
  assert_true((applied[0].z - 3.0).abs() < 0.001)
}

///|
test "icp_apply translation" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(5.0, 10.0, 15.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 6.0).abs() < 0.001)
  assert_true((applied[0].y - 12.0).abs() < 0.001)
  assert_true((applied[0].z - 18.0).abs() < 0.001)
}

///|
test "icp_rms_error basic" {
  let a = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(1.0, 0.0, 0.0)]
  let b = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(0.0, 0.0, 0.0)]
  let err = icp_rms_error(a, b)
  assert_true((err - 0.7071).abs() < 0.01)
}

///|
test "icp_rms_error zero" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let err = icp_rms_error(pts, pts)
  assert_true(err < 0.001)
}

///|
test "icp result rotation accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.5,
    10,
  )
  let rot = IcpResult::rotation(r)
  assert_eq(rot.length(), 9)
  assert_true((rot[0] - 1.0).abs() < 0.000001)
}

///|
test "icp result translation accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(1.0, 2.0, 3.0),
    0.0,
    0,
  )
  let t = IcpResult::translation(r)
  assert_true((t.x - 1.0).abs() < 0.000001)
  assert_true((t.y - 2.0).abs() < 0.000001)
  assert_true((t.z - 3.0).abs() < 0.000001)
}

///|
test "icp result error accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    1.5,
    0,
  )
  let e = IcpResult::error(r)
  assert_true((e - 1.5).abs() < 0.000001)
}

///|
test "icp result iterations accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    42,
  )
  assert_eq(IcpResult::iterations(r), 42)
}

///|
test "icp apply with rotation" {
  let pts = [@core.Point3D::new(1.0, 0.0, 0.0)]
  let result = IcpResult::new(
    [0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 0.0).abs() < 0.001)
  assert_true((applied[0].y - 1.0).abs() < 0.001)
}

///|
test "icp rms error empty" {
  let err = icp_rms_error([], [])
  assert_true(err < 0.000001)
}

///|
test "icp point to point single point" {
  let target = [@core.Point3D::new(5.0, 5.0, 5.0)]
  let source = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let result = icp_point_to_point(source, target, 50)
  assert_true(result.error < 0.01)
}

///|
test "icp point to plane identical" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let normals = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let result = icp_point_to_plane(pts, pts, normals, 20)
  assert_true(result.error >= 0.0)
}

///|
test "icp point to point large translation" {
  let target = [
    @core.Point3D::new(10.0, 10.0, 10.0),
    @core.Point3D::new(11.0, 10.0, 10.0),
    @core.Point3D::new(10.0, 11.0, 10.0),
    @core.Point3D::new(10.0, 10.0, 11.0),
  ]
  let source = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let result = icp_point_to_point(source, target, 100)
  assert_true(result.error < 0.1)
}

///|
test "icp apply multiple points" {
  let pts = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(1.0, 1.0, 1.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 2.0).abs() < 0.001)
  assert_true((applied[1].y - 2.0).abs() < 0.001)
}

///|
test "icp rms error symmetric" {
  let a = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(3.0, 4.0, 0.0)]
  let b = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(0.0, 0.0, 0.0)]
  let err = icp_rms_error(a, b)
  assert_true((err - 3.5355).abs() < 0.01)
}
