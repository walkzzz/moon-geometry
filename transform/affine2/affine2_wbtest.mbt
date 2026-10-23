///|
test "affine2 identity" {
  let m = Affine2::identity()
  let p = @core.Point2D::new(3.0, 4.0)
  let r = m.apply(p)
  assert_true((r.x() - 3.0).abs() < 0.0001)
  assert_true((r.y() - 4.0).abs() < 0.0001)
}

///|
test "affine2 translation" {
  let m = Affine2::translation(5.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = m.apply(p)
  assert_true((r.x() - 6.0).abs() < 0.0001)
  assert_true((r.y() - 5.0).abs() < 0.0001)
}

///|
test "affine2 scale" {
  let m = Affine2::scale(2.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = m.apply(p)
  assert_true((r.x() - 2.0).abs() < 0.0001)
  assert_true((r.y() - 6.0).abs() < 0.0001)
}

///|
test "affine2 inverse" {
  let m = Affine2::translation(5.0, 3.0)
  match m.inverse() {
    Some(inv) => {
      let p = @core.Point2D::new(6.0, 5.0)
      let r = inv.apply(p)
      assert_true((r.x() - 1.0).abs() < 0.0001)
      assert_true((r.y() - 2.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "affine2 determinant" {
  let m = Affine2::scale(2.0, 3.0)
  let det = m.determinant()
  assert_true((det - 6.0).abs() < 0.0001)
}
