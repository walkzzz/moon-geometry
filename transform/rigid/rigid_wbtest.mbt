test "rigid identity" {
  let r = Rigid::identity()
  let p = @core.Point2D::new(3.0, 4.0)
  let result = r.apply(p)
  assert_true((result.x() - 3.0).abs() < 0.0001)
  assert_true((result.y() - 4.0).abs() < 0.0001)
}

test "rigid translation" {
  let r = Rigid::translation(5.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let result = r.apply(p)
  assert_true((result.x() - 6.0).abs() < 0.0001)
  assert_true((result.y() - 5.0).abs() < 0.0001)
}

test "rigid rotation" {
  let r = Rigid::rotation(1.5707963267948966)
  let p = @core.Point2D::new(1.0, 0.0)
  let result = r.apply(p)
  assert_true(result.x().abs() < 0.001)
  assert_true((result.y() - 1.0).abs() < 0.001)
}

test "rigid inverse" {
  let r = Rigid::translation(5.0, 3.0)
  let inv = r.inverse()
  let p = @core.Point2D::new(6.0, 5.0)
  let result = inv.apply(p)
  assert_true((result.x() - 1.0).abs() < 0.001)
  assert_true((result.y() - 2.0).abs() < 0.001)
}

test "rigid compose" {
  let r1 = Rigid::translation(3.0, 0.0)
  let r2 = Rigid::translation(0.0, 4.0)
  let r3 = Rigid::compose(r1, r2)
  let p = @core.Point2D::new(0.0, 0.0)
  let result = r3.apply(p)
  assert_true((result.x() - 3.0).abs() < 0.001)
  assert_true((result.y() - 4.0).abs() < 0.001)
}
test "rigid apply_batch" {
  let r = Rigid::translation(5.0, 3.0)
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let result = r.apply_batch(pts)
  assert_true(result.length() == 3)
  assert_true((result[0].x() - 5.0).abs() < 0.0001)
  assert_true((result[0].y() - 3.0).abs() < 0.0001)
  assert_true((result[1].x() - 6.0).abs() < 0.0001)
  assert_true((result[2].y() - 4.0).abs() < 0.0001)
}

test "rigid apply_batch empty" {
  let r = Rigid::identity()
  let result = r.apply_batch([])
  assert_true(result.length() == 0)
}

test "rigid from_correspondence translation" {
  let src1 = @core.Point2D::new(0.0, 0.0)
  let dst1 = @core.Point2D::new(5.0, 3.0)
  let src2 = @core.Point2D::new(1.0, 0.0)
  let dst2 = @core.Point2D::new(6.0, 3.0)
  let r = Rigid::from_correspondence(src1, dst1, src2, dst2)
  let result = r.apply(src1)
  assert_true((result.x() - 5.0).abs() < 0.001)
  assert_true((result.y() - 3.0).abs() < 0.001)
  let result2 = r.apply(src2)
  assert_true((result2.x() - 6.0).abs() < 0.001)
  assert_true((result2.y() - 3.0).abs() < 0.001)
}

test "rigid from_correspondence rotation" {
  let src1 = @core.Point2D::new(1.0, 0.0)
  let dst1 = @core.Point2D::new(0.0, 1.0)
  let src2 = @core.Point2D::new(0.0, 1.0)
  let dst2 = @core.Point2D::new(-1.0, 0.0)
  let r = Rigid::from_correspondence(src1, dst1, src2, dst2)
  let result = r.apply(src1)
  assert_true(result.x().abs() < 0.001)
  assert_true((result.y() - 1.0).abs() < 0.001)
}

test "rigid inverse rotation" {
  let r = Rigid::rotation(1.5707963267948966)
  let inv = r.inverse()
  let p = @core.Point2D::new(0.0, 1.0)
  let result = inv.apply(p)
  assert_true((result.x() - 1.0).abs() < 0.001)
  assert_true(result.y().abs() < 0.001)
}

test "rigid inverse identity" {
  let r = Rigid::identity()
  let inv = r.inverse()
  let p = @core.Point2D::new(3.0, 4.0)
  let result = inv.apply(p)
  assert_true((result.x() - 3.0).abs() < 0.0001)
  assert_true((result.y() - 4.0).abs() < 0.0001)
}

test "rigid compose with rotation" {
  let r1 = Rigid::rotation(0.5)
  let r2 = Rigid::rotation(0.3)
  let r3 = Rigid::compose(r1, r2)
  let p = @core.Point2D::new(1.0, 0.0)
  let result = r3.apply(p)
  let expected_angle = 0.8
  let ex = @math.cos(expected_angle)
  let ey = @math.sin(expected_angle)
  assert_true((result.x() - ex).abs() < 0.001)
  assert_true((result.y() - ey).abs() < 0.001)
}

test "rigid compose inverse roundtrip" {
  let r = Rigid::translation(5.0, 3.0)
  let inv = r.inverse()
  let composed = Rigid::compose(r, inv)
  let p = @core.Point2D::new(2.0, 7.0)
  let result = composed.apply(p)
  assert_true((result.x() - 2.0).abs() < 0.001)
  assert_true((result.y() - 7.0).abs() < 0.001)
}