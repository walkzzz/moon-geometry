///|
test "build terrain basic" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 1.0),
    @core.Point3D::new(10.0, 10.0, 2.0),
    @core.Point3D::new(0.0, 10.0, 3.0),
  ]
  let t = build_terrain(pts)
  assert_eq(Terrain::point_count(t), 4)
  assert_true(Terrain::triangle_count(t) >= 1)
}

///|
test "build terrain too few" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
  ]
  let t = build_terrain(pts)
  assert_eq(Terrain::triangle_count(t), 0)
}

///|
test "build constrained terrain" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 1.0),
    @core.Point3D::new(10.0, 10.0, 2.0),
    @core.Point3D::new(0.0, 10.0, 3.0),
  ]
  let t = build_constrained_terrain(pts, [(0, 2)])
  assert_eq(Terrain::constraint_count(t), 1)
  assert_true(Terrain::triangle_count(t) >= 1)
}

///|
test "terrain average slope flat" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 5.0),
    @core.Point3D::new(10.0, 0.0, 5.0),
    @core.Point3D::new(5.0, 10.0, 5.0),
  ]
  let t = build_terrain(pts)
  let s = Terrain::average_slope(t)
  assert_true(@core.approx_eq(s, 0.0, 0.001))
}

///|
test "terrain average slope inclined" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
    @core.Point3D::new(10.0, 10.0, 10.0),
  ]
  let t = build_terrain(pts)
  let s = Terrain::average_slope(t)
  assert_true(s > 0.0)
}

///|
test "terrain slope at point" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
  ]
  let t = build_terrain(pts)
  let s = Terrain::slope_at(t, @core.Point2D::new(3.0, 3.0))
  assert_true(s is Some(_))
  assert_true(s.unwrap() > 0.0)
}

///|
test "terrain aspect at point" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
  ]
  let t = build_terrain(pts)
  let a = Terrain::aspect_at(t, @core.Point2D::new(3.0, 3.0))
  assert_true(a is Some(_))
}

///|
test "terrain surface area flat" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
  ]
  let t = build_terrain(pts)
  let area = Terrain::surface_area(t)
  assert_true(@core.approx_eq(area, 50.0, 0.001))
}

///|
test "terrain surface area inclined" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 10.0),
    @core.Point3D::new(0.0, 10.0, 0.0),
  ]
  let t = build_terrain(pts)
  let area = Terrain::surface_area(t)
  assert_true(area > 50.0)
}

///|
test "terrain slope outside" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let t = build_terrain(pts)
  let s = Terrain::slope_at(t, @core.Point2D::new(5.0, 5.0))
  assert_true(s is None)
}
