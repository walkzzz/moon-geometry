///|
test "obb from axis aligned points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 4.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 6.0),
    @core.Point3D::new(2.0, 4.0, 6.0),
  ]
  let b = obb_from_points(pts)
  let vol = OBB::volume(b)
  assert_true(vol > 0.0)
}

///|
test "obb volume" {
  let b = OBB::new(
    @core.Point3D::new(0.0, 0.0, 0.0),
    [
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 1.0),
    ],
    [1.0, 2.0, 3.0],
  )
  assert_eq(OBB::volume(b), 48.0)
}

///|
test "obb surface area" {
  let b = OBB::new(
    @core.Point3D::new(0.0, 0.0, 0.0),
    [
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 1.0),
    ],
    [1.0, 2.0, 3.0],
  )
  assert_eq(OBB::surface_area(b), 88.0)
}

///|
test "obb empty" {
  let b = obb_from_points([])
  assert_eq(OBB::volume(b), 0.0)
}

///|
test "obb single point" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let b = obb_from_points(pts)
  assert_eq(OBB::volume(b), 0.0)
}

///|
test "obb cube" {
  let pts = [
    @core.Point3D::new(1.0, 1.0, 1.0),
    @core.Point3D::new(-1.0, -1.0, -1.0),
    @core.Point3D::new(1.0, -1.0, 1.0),
    @core.Point3D::new(-1.0, 1.0, -1.0),
    @core.Point3D::new(1.0, 1.0, -1.0),
    @core.Point3D::new(-1.0, -1.0, 1.0),
    @core.Point3D::new(-1.0, 1.0, 1.0),
    @core.Point3D::new(1.0, -1.0, -1.0),
  ]
  let b = obb_from_points(pts)
  let vol = OBB::volume(b)
  assert_true((vol - 8.0).abs() < 0.01)
}

///|
test "obb center" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(4.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 4.0, 0.0),
    @core.Point3D::new(4.0, 4.0, 0.0),
  ]
  let b = obb_from_points(pts)
  assert_true((b.center.x - 2.0).abs() < 0.01)
  assert_true((b.center.y - 2.0).abs() < 0.01)
}

///|
test "obb rotated box" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 2.0, 0.0),
    @core.Point3D::new(0.0, 4.0, 0.0),
    @core.Point3D::new(-2.0, 2.0, 0.0),
  ]
  let b = obb_from_points(pts)
  let vol = OBB::volume(b)
  assert_true(vol >= 0.0)
  assert_true(b.half_extents[0] > 0.0)
  assert_true(b.half_extents[1] > 0.0)
}
