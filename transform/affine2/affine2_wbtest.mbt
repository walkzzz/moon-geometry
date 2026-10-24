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
///|
test "affine2 shear" {
  let m = Affine2::shear(1.0, 0.0)
  let p = @core.Point2D::new(2.0, 3.0)
  let r = m.apply(p)
  assert_true((r.x() - 5.0).abs() < 0.0001)
  assert_true((r.y() - 3.0).abs() < 0.0001)
}

///|
test "affine2 shear both" {
  let m = Affine2::shear(1.0, 1.0)
  let p = @core.Point2D::new(1.0, 1.0)
  let r = m.apply(p)
  assert_true((r.x() - 2.0).abs() < 0.0001)
  assert_true((r.y() - 2.0).abs() < 0.0001)
}

///|
test "affine2 compose" {
  let t = Affine2::translation(5.0, 3.0)
  let s = Affine2::scale(2.0, 2.0)
  let ts = t.compose(s)
  let p = @core.Point2D::new(1.0, 1.0)
  let r = ts.apply(p)
  assert_true((r.x() - 7.0).abs() < 0.0001)
  assert_true((r.y() - 5.0).abs() < 0.0001)
}

///|
test "affine2 compose identity" {
  let m = Affine2::translation(3.0, 4.0)
  let id = Affine2::identity()
  let mi = m.compose(id)
  let p = @core.Point2D::new(1.0, 1.0)
  let r1 = mi.apply(p)
  let r2 = m.apply(p)
  assert_true((r1.x() - r2.x()).abs() < 0.0001)
  assert_true((r1.y() - r2.y()).abs() < 0.0001)
}

///|
test "affine2 inverse singular none" {
  let m = Affine2::shear(1.0, 1.0)
  let _ = m
  let s = Affine2::scale(0.0, 1.0)
  match s.inverse() {
    None => assert_true(true)
    Some(_) => assert_true(false)
  }
}

///|
test "affine2 inverse scale" {
  let m = Affine2::scale(2.0, 4.0)
  match m.inverse() {
    Some(inv) => {
      let p = @core.Point2D::new(2.0, 8.0)
      let r = inv.apply(p)
      assert_true((r.x() - 1.0).abs() < 0.0001)
      assert_true((r.y() - 2.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "affine2 apply batch" {
  let m = Affine2::scale(2.0, 3.0)
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let rs = m.apply_batch(pts)
  assert_eq(rs.length(), 3)
  assert_true((rs[0].x() - 2.0).abs() < 0.0001)
  assert_true((rs[0].y() - 3.0).abs() < 0.0001)
  assert_true((rs[2].x() - 6.0).abs() < 0.0001)
  assert_true((rs[2].y() - 12.0).abs() < 0.0001)
}

///|
test "affine2 determinant negative" {
  let m = Affine2::shear(2.0, 2.0)
  let det = m.determinant()
  assert_true((det - -3.0).abs() < 0.0001)
}

///|
test "affine2 determinant identity" {
  let m = Affine2::identity()
  let det = m.determinant()
  assert_true((det - 1.0).abs() < 0.0001)
}

///|
test "affine2 inverse compose identity" {
  let m = Affine2::translation(5.0, 3.0)
  match m.inverse() {
    Some(inv) => {
      let comp = m.compose(inv)
      let p = @core.Point2D::new(7.0, 9.0)
      let r = comp.apply(p)
      assert_true((r.x() - 7.0).abs() < 0.0001)
      assert_true((r.y() - 9.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "affine2 translation zero" {
  let m = Affine2::translation(0.0, 0.0)
  let p = @core.Point2D::new(3.0, 4.0)
  let r = m.apply(p)
  assert_true((r.x() - 3.0).abs() < 0.0001)
  assert_true((r.y() - 4.0).abs() < 0.0001)
}

///|
test "affine2 scale zero" {
  let m = Affine2::scale(0.0, 0.0)
  let p = @core.Point2D::new(3.0, 4.0)
  let r = m.apply(p)
  assert_true(r.x().abs() < 0.0001)
  assert_true(r.y().abs() < 0.0001)
}
