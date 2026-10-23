///|
test "matrix: identity" {
  let m = Mat2::identity()
  assert_true(@core.approx_eq(Mat2::det(m), 1.0, 0.001))
}

///|
test "matrix: det" {
  let m = Mat2::new(3.0, 1.0, 5.0, 2.0)
  assert_true(@core.approx_eq(Mat2::det(m), 1.0, 0.001))
}

///|
test "matrix: mul" {
  let a = Mat2::new(1.0, 2.0, 3.0, 4.0)
  let b = Mat2::new(5.0, 6.0, 7.0, 8.0)
  let c = Mat2::mul(a, b)
  assert_true(@core.approx_eq(c.a11, 19.0, 0.001))
  assert_true(@core.approx_eq(c.a12, 22.0, 0.001))
  assert_true(@core.approx_eq(c.a21, 43.0, 0.001))
  assert_true(@core.approx_eq(c.a22, 50.0, 0.001))
}

///|
test "matrix: transform" {
  let m = Mat2::new(2.0, 0.0, 0.0, 3.0)
  let p = @core.Point2D::new(1.0, 1.0)
  let r = Mat2::transform(m, p)
  assert_true(@core.approx_eq(r.x(), 2.0, 0.001))
  assert_true(@core.approx_eq(r.y(), 3.0, 0.001))
}

///|
test "matrix: inverse" {
  let m = Mat2::new(4.0, 7.0, 2.0, 6.0)
  match Mat2::inverse(m) {
    Some(inv) => {
      let prod = Mat2::mul(m, inv)
      assert_true(@core.approx_eq(prod.a11, 1.0, 0.001))
      assert_true(@core.approx_eq(prod.a22, 1.0, 0.001))
    }
    None => assert_true(false)
  }
}

///|
test "matrix: inverse singular" {
  let m = Mat2::new(1.0, 2.0, 2.0, 4.0)
  match Mat2::inverse(m) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "matrix: rotation" {
  let m = Mat2::rotation(1.5707963267948966)
  let p = @core.Point2D::new(1.0, 0.0)
  let r = Mat2::transform(m, p)
  assert_true(@core.approx_eq(r.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(r.y(), 1.0, 0.001))
}

///|
test "matrix: scaling" {
  let m = Mat2::scaling(3.0, 5.0)
  let p = @core.Point2D::new(2.0, 4.0)
  let r = Mat2::transform(m, p)
  assert_true(@core.approx_eq(r.x(), 6.0, 0.001))
  assert_true(@core.approx_eq(r.y(), 20.0, 0.001))
}

///|
test "matrix: trace" {
  let m = Mat2::new(3.0, 1.0, 5.0, 7.0)
  assert_true(@core.approx_eq(Mat2::trace(m), 10.0, 0.001))
}
