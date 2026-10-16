test "bezier clip eval endpoints" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let p0 = BezierClip::eval(b, 0.0)
  assert_true(p0.x().abs() < 0.000000001)
  assert_true(p0.y().abs() < 0.000000001)
  let p1 = BezierClip::eval(b, 1.0)
  assert_true((p1.x() - 3.0).abs() < 0.000000001)
  assert_true(p1.y().abs() < 0.000000001)
}

test "bezier clip eval midpoint" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
  )
  let pm = BezierClip::eval(b, 0.5)
  assert_true((pm.x() - 1.0).abs() < 0.000000001)
  assert_true((pm.y() - 1.5).abs() < 0.000000001)
}

test "bezier clip derivative" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  )
  let d = BezierClip::derivative(b, 0.0)
  assert_true((d.x() - 3.0).abs() < 0.000000001)
}

test "bezier clip bbox" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, -1.0),
    @core.Point2D::new(3.0, 2.0),
  )
  let (min_x, min_y, max_x, max_y) = BezierClip::bbox(b)
  assert_true(min_x.abs() < 0.000000001)
  assert_true((max_x - 3.0).abs() < 0.000000001)
  assert_true((min_y - (-1.0)).abs() < 0.000000001)
  assert_true((max_y - 3.0).abs() < 0.000000001)
}

test "bezier clip subdivide" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let (left, right) = BezierClip::subdivide(b, 0.5)
  let mid_l = BezierClip::eval(left, 1.0)
  let mid_r = BezierClip::eval(right, 0.0)
  assert_true((mid_l.x() - mid_r.x()).abs() < 0.000000001)
  assert_true((mid_l.y() - mid_r.y()).abs() < 0.000000001)
}

test "bezier clip intersect simple" {
  let b1 = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let b2 = BezierClip::new(
    @core.Point2D::new(1.5, -1.0),
    @core.Point2D::new(1.5, 0.0),
    @core.Point2D::new(1.5, 0.0),
    @core.Point2D::new(1.5, 1.0),
  )
  let pts = bezier_clip_intersect(b1, b2, 0.001, 10)
  assert_true(pts.length() >= 1)
}

test "bezier clip length positive" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let len = BezierClip::length(b)
  assert_true((len - 3.0).abs() < 0.001)
}

test "bezier clip length curved" {
  let b = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 0.0),
  )
  let len = BezierClip::length(b)
  assert_true(len > 1.0)
  assert_true(len < 3.0)
}

test "bezier clip no intersection" {
  let b1 = BezierClip::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let b2 = BezierClip::new(
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(3.0, 5.0),
  )
  let pts = bezier_clip_intersect(b1, b2, 0.001, 10)
  assert_eq(pts.length(), 0)
}