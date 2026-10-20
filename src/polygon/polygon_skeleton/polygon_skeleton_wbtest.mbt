test "straight_skeleton basic square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let skel = straight_skeleton(poly)
  assert_true(skel.length() >= 3)
}

test "straight_skeleton triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 5.0),
  ]
  let poly = @core.Polygon::new(pts)
  let skel = straight_skeleton(poly)
  assert_true(skel.length() >= 2)
}

test "skeleton_faces square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly = @core.Polygon::new(pts)
  let faces = skeleton_faces(poly)
  assert_eq(faces.length(), 4)
}

test "straight_skeleton degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let poly = @core.Polygon::new(pts)
  let skel = straight_skeleton(poly)
  assert_eq(skel.length(), 0)
}

test "skeleton_faces pentagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(-1.0, 3.0),
  ]
  let poly = @core.Polygon::new(pts)
  let faces = skeleton_faces(poly)
  assert_eq(faces.length(), 5)
}