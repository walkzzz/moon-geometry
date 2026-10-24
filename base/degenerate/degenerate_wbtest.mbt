///|
test "detect coincident points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0000001, 0.0000001),
    @core.Point2D::new(1.0, 0.0),
  ]
  let results = detect_degenerate_points(pts, 0.000001)
  assert_true(results.length() > 0)
}

///|
test "remove coincident points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0000001, 0.0000001),
    @core.Point2D::new(1.0, 0.0),
  ]
  let cleaned = remove_coincident_points(pts, 0.000001)
  assert_eq(cleaned.length(), 2)
}

///|
test "remove coincident points boundary: dist exactly equals tol" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let cleaned = remove_coincident_points(pts, 1.0)
  assert_eq(cleaned.length(), 2)
}

///|
test "detect small angles" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 0.000001),
  ]
  let results = detect_small_angles(pts, 0.001)
  assert_true(results.length() > 0)
}

///|
test "DegenerateType variants" {
  ignore(CollinearPoints)
  ignore(OverlappingEdges)
  ignore(NearTangent)
  ignore(ZeroAreaTriangle)
  ignore(SmallAngle)
  ignore(SelfIntersecting)
  ignore(CoincidentPoints)
}
///|
test "DegenerateType Eq" {
  assert_true(CollinearPoints == CollinearPoints)
  assert_true(CollinearPoints != ZeroAreaTriangle)
  assert_true(SelfIntersecting == SelfIntersecting)
}

///|
test "DegenerateType Debug to_repr" {
  ignore(CollinearPoints.to_repr())
  ignore(ZeroAreaTriangle.to_repr())
  ignore(SelfIntersecting.to_repr())
}

///|
test "detect_degenerate_points empty" {
  let results = detect_degenerate_points([], 0.001)
  assert_eq(results.length(), 0)
}

///|
test "detect_degenerate_points no coincident" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let results = detect_degenerate_points(pts, 0.0001)
  assert_eq(results.length(), 3)
}

///|
test "detect_degenerate_triangles" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 1, 3)]
  let results = detect_degenerate_triangles(verts, faces, 0.000001)
  assert_true(results.length() > 0)
}

///|
test "detect_degenerate_triangles none" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let results = detect_degenerate_triangles(verts, faces, 0.000001)
  assert_eq(results.length(), 0)
}

///|
test "detect_self_intersection" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let results = detect_self_intersection(pts, 0.000001)
  assert_true(results.length() > 0)
}

///|
test "detect_self_intersection none" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let results = detect_self_intersection(pts, 0.000001)
  assert_eq(results.length(), 0)
}

///|
test "detect_self_intersection too few" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let results = detect_self_intersection(pts, 0.000001)
  assert_eq(results.length(), 0)
}

///|
test "detect_small_angles none" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let results = detect_small_angles(pts, 0.001)
  assert_eq(results.length(), 0)
}

///|
test "detect_small_angles too few" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let results = detect_small_angles(pts, 0.001)
  assert_eq(results.length(), 0)
}

///|
test "remove_coincident_points all distinct" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let cleaned = remove_coincident_points(pts, 0.0001)
  assert_eq(cleaned.length(), 3)
}
