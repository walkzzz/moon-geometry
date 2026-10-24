///|
test "similarity identity" {
  let s = Similarity::identity()
  let p = @core.Point2D::new(3.0, 4.0)
  let r = s.apply(p)
  assert_true((r.x() - 3.0).abs() < 0.0001)
  assert_true((r.y() - 4.0).abs() < 0.0001)
}

///|
test "similarity scale" {
  let s = Similarity::scaling(2.0)
  let p = @core.Point2D::new(3.0, 4.0)
  let r = s.apply(p)
  assert_true((r.x() - 6.0).abs() < 0.0001)
  assert_true((r.y() - 8.0).abs() < 0.0001)
}

///|
test "similarity rotation" {
  let s = Similarity::rotation(1.5707963267948966)
  let p = @core.Point2D::new(1.0, 0.0)
  let r = s.apply(p)
  assert_true(r.x().abs() < 0.001)
  assert_true((r.y() - 1.0).abs() < 0.001)
}

///|
test "similarity inverse" {
  let s = Similarity::scaling(2.0)
  match s.inverse() {
    Some(inv) => {
      let p = @core.Point2D::new(6.0, 8.0)
      let r = inv.apply(p)
      assert_true((r.x() - 3.0).abs() < 0.001)
      assert_true((r.y() - 4.0).abs() < 0.001)
    }
    None => assert_true(false)
  }
}

///|
test "similarity compose" {
  let s1 = Similarity::scaling(2.0)
  let s2 = Similarity::scaling(3.0)
  let s3 = Similarity::compose(s1, s2)
  let p = @core.Point2D::new(1.0, 1.0)
  let r = s3.apply(p)
  assert_true((r.x() - 6.0).abs() < 0.001)
  assert_true((r.y() - 6.0).abs() < 0.001)
}

///|
test "similarity translation" {
  let s = Similarity::translation(5.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = s.apply(p)
  assert_true((r.x() - 6.0).abs() < 0.0001)
  assert_true((r.y() - 5.0).abs() < 0.0001)
}

///|
test "similarity apply batch" {
  let s = Similarity::scaling(2.0)
  let pts = [@core.Point2D::new(1.0, 0.0), @core.Point2D::new(0.0, 1.0)]
  let rs = s.apply_batch(pts)
  assert_true((rs[0].x() - 2.0).abs() < 0.0001)
  assert_true((rs[1].y() - 2.0).abs() < 0.0001)
}

///|
test "similarity inverse zero scale" {
  let s = Similarity::scaling(0.0)
  match s.inverse() {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "similarity from correspondence" {
  let src1 = @core.Point2D::new(0.0, 0.0)
  let src2 = @core.Point2D::new(1.0, 0.0)
  let dst1 = @core.Point2D::new(1.0, 1.0)
  let dst2 = @core.Point2D::new(3.0, 1.0)
  let s = Similarity::from_correspondence(src1, dst1, src2, dst2)
  let r1 = s.apply(src1)
  assert_true((r1.x() - 1.0).abs() < 0.001)
  assert_true((r1.y() - 1.0).abs() < 0.001)
  let r2 = s.apply(src2)
  assert_true((r2.x() - 3.0).abs() < 0.001)
  assert_true((r2.y() - 1.0).abs() < 0.001)
}
