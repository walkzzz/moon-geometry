test "is_ear_convex" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let indices = [0, 1, 2, 3]
  assert_true(is_ear(sq, indices, 0))
  assert_true(is_ear(sq, indices, 1))
  assert_true(is_ear(sq, indices, 2))
  assert_true(is_ear(sq, indices, 3))
}

test "find_ear" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let indices = [0, 1, 2, 3]
  let ear = find_ear(sq, indices)
  assert_true(ear.is_some())
}

test "ear_clip_triangulate_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = ear_clip_triangulate(sq)
  assert_true(tris.length() == 2)
}

test "ear_clip_count" {
  let pent = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 2.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(-1.0, 2.0),
  ]
  assert_true(ear_clip_count(pent) == 3)
}

test "ear_clip_area" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = ear_clip_area(sq)
  assert_true((area - 16.0).abs() < 0.001)
}