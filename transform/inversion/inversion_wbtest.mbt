///|
test "inversion basic" {
  let inv = Inversion::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let p = @core.Point2D::new(2.0, 0.0)
  match inv.apply(p) {
    Some(pt) => {
      assert_true((pt.x() - 0.5).abs() < 0.0001)
      assert_true((pt.y() - 0.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "inversion on circle" {
  let inv = Inversion::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let p = @core.Point2D::new(1.0, 0.0)
  match inv.apply(p) {
    Some(pt) => {
      assert_true((pt.x() - 1.0).abs() < 0.0001)
      assert_true((pt.y() - 0.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "inversion center" {
  let inv = Inversion::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let p = @core.Point2D::new(0.0, 0.0)
  match inv.apply(p) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "inversion power" {
  let inv = Inversion::new(@core.Point2D::new(0.0, 0.0), 2.0)
  let p = @core.Point2D::new(3.0, 0.0)
  let pow = inv.power(p)
  assert_true((pow - 5.0).abs() < 0.0001)
}

///|
test "inversion is inside" {
  let inv = Inversion::new(@core.Point2D::new(0.0, 0.0), 2.0)
  let p = @core.Point2D::new(1.0, 0.0)
  assert_true(inv.is_inside(p))
  let p2 = @core.Point2D::new(3.0, 0.0)
  assert_false(inv.is_inside(p2))
}
