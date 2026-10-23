///|
test "delaunay_3d empty" {
  let d = delaunay_3d([])
  assert_eq(d.vertex_count(), 0)
  assert_eq(d.tetrahedron_count(), 0)
}

///|
test "delaunay_3d too few points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let d = delaunay_3d(pts)
  assert_eq(d.vertex_count(), 3)
  assert_eq(d.tetrahedron_count(), 0)
}

///|
test "delaunay_3d tetrahedron" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let d = delaunay_3d(pts)
  assert_eq(d.vertex_count(), 4)
  assert_true(d.tetrahedron_count() >= 1)
}

///|
test "delaunay_3d five points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.5, 0.5, 0.5),
  ]
  let d = delaunay_3d(pts)
  assert_eq(d.vertex_count(), 5)
  assert_true(d.tetrahedron_count() >= 1)
}

///|
test "tetrahedron_volume" {
  let a = @core.Point3D::new(0.0, 0.0, 0.0)
  let b = @core.Point3D::new(1.0, 0.0, 0.0)
  let c = @core.Point3D::new(0.0, 1.0, 0.0)
  let d = @core.Point3D::new(0.0, 0.0, 1.0)
  let vol = tetrahedron_volume(a, b, c, d)
  assert_true((vol - 0.16666666666666666).abs() < 0.0000001)
}

///|
test "circumsphere_center" {
  let a = @core.Point3D::new(0.0, 0.0, 0.0)
  let b = @core.Point3D::new(2.0, 0.0, 0.0)
  let c = @core.Point3D::new(0.0, 2.0, 0.0)
  let d = @core.Point3D::new(0.0, 0.0, 2.0)
  let center = circumsphere_center(a, b, c, d)
  assert_true((center.x - 1.0).abs() < 0.0000001)
  assert_true((center.y - 1.0).abs() < 0.0000001)
  assert_true((center.z - 1.0).abs() < 0.0000001)
}

///|
test "circumsphere_radius_sq" {
  let a = @core.Point3D::new(0.0, 0.0, 0.0)
  let b = @core.Point3D::new(2.0, 0.0, 0.0)
  let c = @core.Point3D::new(0.0, 2.0, 0.0)
  let d = @core.Point3D::new(0.0, 0.0, 2.0)
  let rsq = circumsphere_radius_sq(a, b, c, d)
  assert_true((rsq - 3.0).abs() < 0.0000001)
}

///|
test "in_circumsphere" {
  let a = @core.Point3D::new(0.0, 0.0, 0.0)
  let b = @core.Point3D::new(2.0, 0.0, 0.0)
  let c = @core.Point3D::new(0.0, 2.0, 0.0)
  let d = @core.Point3D::new(0.0, 0.0, 2.0)
  let inside = @core.Point3D::new(1.0, 1.0, 1.0)
  let outside = @core.Point3D::new(5.0, 5.0, 5.0)
  assert_true(in_circumsphere(inside, a, b, c, d))
  assert_false(in_circumsphere(outside, a, b, c, d))
}

///|
test "is_delaunay tetrahedron" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let d = delaunay_3d(pts)
  assert_true(is_delaunay(d))
}

///|
test "Delaunay3D::new" {
  let d = Delaunay3D::new()
  assert_eq(d.vertex_count(), 0)
  assert_eq(d.tetrahedron_count(), 0)
}
