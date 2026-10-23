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
