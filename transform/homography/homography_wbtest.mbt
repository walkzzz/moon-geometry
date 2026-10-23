///|
test "homography identity" {
  let m = Homography::identity()
  let p = @core.Point2D::new(3.0, 4.0)
  match m.apply(p) {
    Some(pt) => {
      assert_true((pt.x() - 3.0).abs() < 0.0001)
      assert_true((pt.y() - 4.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "homography from array" {
  let h = [1.0, 0.0, 5.0, 0.0, 1.0, 3.0, 0.0, 0.0, 1.0]
  let m = Homography::from_array(h)
  let p = @core.Point2D::new(0.0, 0.0)
  match m.apply(p) {
    Some(pt) => {
      assert_true((pt.x() - 5.0).abs() < 0.0001)
      assert_true((pt.y() - 3.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "homography compose" {
  let m1 = Homography::identity()
  let m2 = Homography::identity()
  let m3 = Homography::compose(m1, m2)
  let p = @core.Point2D::new(2.0, 3.0)
  match m3.apply(p) {
    Some(pt) => {
      assert_true((pt.x() - 2.0).abs() < 0.0001)
      assert_true((pt.y() - 3.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "homography determinant" {
  let m = Homography::identity()
  let det = Homography::determinant(m)
  assert_true((det - 1.0).abs() < 0.0001)
}

///|
test "homography batch" {
  let m = Homography::identity()
  let pts = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let result = m.apply_batch(pts)
  assert_eq(result.length(), 2)
}
