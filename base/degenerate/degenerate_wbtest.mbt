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
