test "affine2 identity" {
  let m = Affine2::identity()
  let p = @core.Point2D::new(3.0, 4.0)
  let r = m.apply(p)
  assert_true((r.x() - 3.0).abs() < 0.0001)
  assert_true((r.y() - 4.0).abs() < 0.0001)
}

test "affine2 translation" {
  let m = Affine2::translation(5.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = m.apply(p)
  assert_true((r.x() - 6.0).abs() < 0.0001)
  assert_true((r.y() - 5.0).abs() < 0.0001)
}

test "affine2 scale" {
  let m = Affine2::scale(2.0, 3.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = m.apply(p)
  assert_true((r.x() - 2.0).abs() < 0.0001)
  assert_true((r.y() - 6.0).abs() < 0.0001)
}

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

test "affine2 determinant" {
  let m = Affine2::scale(2.0, 3.0)
  let det = m.determinant()
  assert_true((det - 6.0).abs() < 0.0001)
}
test "affine2 shear" {
  let m = Affine2::shear(0.5, 0.0)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = m.apply(p)
  assert_true((r.x() - 2.0).abs() < 0.0001)
  assert_true((r.y() - 2.0).abs() < 0.0001)
}

test "affine2 shear both" {
  let m = Affine2::shear(0.5, 0.25)
  let p = @core.Point2D::new(2.0, 4.0)
  let r = m.apply(p)
  assert_true((r.x() - 4.0).abs() < 0.0001)
  assert_true((r.y() - 4.5).abs() < 0.0001)
}

test "affine2 apply_batch" {
  let m = Affine2::translation(5.0, 3.0)
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let result = m.apply_batch(pts)
  assert_true(result.length() == 3)
  assert_true((result[0].x() - 5.0).abs() < 0.0001)
  assert_true((result[1].x() - 6.0).abs() < 0.0001)
  assert_true((result[2].y() - 4.0).abs() < 0.0001)
}

test "affine2 apply_batch empty" {
  let m = Affine2::identity()
  let result = m.apply_batch([])
  assert_true(result.length() == 0)
}

test "affine2 compose translations" {
  let m1 = Affine2::translation(3.0, 0.0)
  let m2 = Affine2::translation(0.0, 4.0)
  let m3 = Affine2::compose(m1, m2)
  let p = @core.Point2D::new(0.0, 0.0)
  let r = m3.apply(p)
  assert_true((r.x() - 3.0).abs() < 0.001)
  assert_true((r.y() - 4.0).abs() < 0.001)
}

test "affine2 compose scales" {
  let m1 = Affine2::scale(2.0, 3.0)
  let m2 = Affine2::scale(4.0, 5.0)
  let m3 = Affine2::compose(m1, m2)
  let p = @core.Point2D::new(1.0, 1.0)
  let r = m3.apply(p)
  assert_true((r.x() - 8.0).abs() < 0.0001)
  assert_true((r.y() - 15.0).abs() < 0.0001)
}

test "affine2 compose with identity" {
  let m = Affine2::translation(5.0, 3.0)
  let id = Affine2::identity()
  let m3 = Affine2::compose(m, id)
  let p = @core.Point2D::new(1.0, 2.0)
  let r = m3.apply(p)
  assert_true((r.x() - 6.0).abs() < 0.0001)
  assert_true((r.y() - 5.0).abs() < 0.0001)
}

test "affine2 inverse singular returns none" {
  let m = Affine2::shear(1.0, 1.0)
  let det = m.determinant()
  assert_true(det.abs() < 0.0001)
  match m.inverse() {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "affine2 inverse scale" {
  let m = Affine2::scale(2.0, 4.0)
  match m.inverse() {
    Some(inv) => {
      let p = @core.Point2D::new(4.0, 8.0)
      let r = inv.apply(p)
      assert_true((r.x() - 2.0).abs() < 0.0001)
      assert_true((r.y() - 2.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

test "affine2 inverse shear" {
  let m = Affine2::shear(0.5, 0.0)
  match m.inverse() {
    Some(inv) => {
      let p = @core.Point2D::new(2.0, 2.0)
      let r = inv.apply(p)
      assert_true((r.x() - 1.0).abs() < 0.0001)
      assert_true((r.y() - 2.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

test "affine2 inverse roundtrip" {
  let m = Affine2::compose(Affine2::translation(5.0, 3.0), Affine2::scale(2.0, 2.0))
  match m.inverse() {
    Some(inv) => {
      let composed = Affine2::compose(m, inv)
      let p = @core.Point2D::new(3.0, 4.0)
      let r = composed.apply(p)
      assert_true((r.x() - 3.0).abs() < 0.001)
      assert_true((r.y() - 4.0).abs() < 0.001)
    }
    None => assert_true(false)
  }
}

test "affine2 determinant translation" {
  let m = Affine2::translation(5.0, 3.0)
  let det = m.determinant()
  assert_true((det - 1.0).abs() < 0.0001)
}

test "affine2 determinant shear" {
  let m = Affine2::shear(0.5, 0.25)
  let det = m.determinant()
  assert_true((det - 0.875).abs() < 0.0001)
}