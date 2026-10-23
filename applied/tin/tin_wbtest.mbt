///|
test "build tin basic" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 1.0),
    @core.Point3D::new(10.0, 10.0, 2.0),
    @core.Point3D::new(0.0, 10.0, 3.0),
  ]
  let tin = build_tin(pts)
  assert_eq(TIN::point_count(tin), 4)
  assert_true(TIN::triangle_count(tin) >= 1)
}

///|
test "build tin too few points" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
  ]
  let tin = build_tin(pts)
  assert_eq(TIN::triangle_count(tin), 0)
}

///|
test "tin interpolate vertex" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(10.0, 0.0, 5.0),
    @core.Point3D::new(5.0, 10.0, 5.0),
  ]
  let tin = build_tin(pts)
  let z = TIN::interpolate(tin, @core.Point2D::new(0.0, 0.0))
  assert_true(z is Some(_))
  assert_true(@core.approx_eq(z.unwrap(), 5.0, 0.001))
}

///|
test "tin interpolate centroid" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(6.0, 0.0, 0.0),
    @core.Point3D::new(3.0, 6.0, 3.0),
  ]
  let tin = build_tin(pts)
  let z = TIN::interpolate(tin, @core.Point2D::new(3.0, 2.0))
  assert_true(z is Some(_))
  assert_true(@core.approx_eq(z.unwrap(), 1.0, 0.001))
}

///|
test "tin interpolate outside" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let tin = build_tin(pts)
  let z = TIN::interpolate(tin, @core.Point2D::new(5.0, 5.0))
  assert_true(z is None)
}

///|
test "tin volume flat" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(10.0, 0.0, 5.0),
    @core.Point3D::new(10.0, 10.0, 5.0),
    @core.Point3D::new(0.0, 10.0, 5.0),
  ]
  let tin = build_tin(pts)
  let v = TIN::volume(tin)
  assert_true(@core.approx_eq(v, 500.0, 0.001))
}

///|
test "tin slope flat" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(10.0, 0.0, 5.0),
    @core.Point3D::new(5.0, 10.0, 5.0),
  ]
  let tin = build_tin(pts)
  let s = TIN::slope_at(tin, @core.Point2D::new(5.0, 2.0))
  assert_true(s is Some(_))
  assert_true(@core.approx_eq(s.unwrap(), 0.0, 0.001))
}

///|
test "tin slope inclined" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
    @core.Point3D::new(10.0, 10.0, 10.0),
  ]
  let tin = build_tin(pts)
  let s = TIN::slope_at(tin, @core.Point2D::new(5.0, 5.0))
  assert_true(s is Some(_))
  assert_true(s.unwrap() > 0.0)
}

///|
test "tin elevation range" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(10.0, 0.0, 9.0),
    @core.Point3D::new(5.0, 10.0, 3.0),
  ]
  let tin = build_tin(pts)
  let (zmin, zmax) = TIN::elevation_range(tin)
  assert_true(@core.approx_eq(zmin, 1.0, 0.001))
  assert_true(@core.approx_eq(zmax, 9.0, 0.001))
}

///|
test "tin aspect flat" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(10.0, 0.0, 5.0),
    @core.Point3D::new(5.0, 10.0, 5.0),
  ]
  let tin = build_tin(pts)
  let a = TIN::aspect_at(tin, @core.Point2D::new(5.0, 2.0))
  assert_true(a is Some(_))
}
