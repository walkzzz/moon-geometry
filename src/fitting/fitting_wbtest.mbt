///|
test "fitting: line fit perfect" {
  let pts = [
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  match fit_line(pts) {
    Some(fit) => {
      assert_true(@core.approx_eq(fit.slope, 2.0, 0.001))
      assert_true(@core.approx_eq(fit.intercept, 1.0, 0.001))
      assert_true(@core.approx_eq(fit.r_squared, 1.0, 0.001))
    }
    None => assert_true(false)
  }
}

///|
test "fitting: line fit noisy" {
  let pts = [
    @core.Point2D::new(0.0, 0.1),
    @core.Point2D::new(1.0, 1.9),
    @core.Point2D::new(2.0, 4.1),
    @core.Point2D::new(3.0, 5.9),
  ]
  match fit_line(pts) {
    Some(fit) => {
      assert_true(@core.approx_eq(fit.slope, 2.0, 0.05))
      assert_true(fit.r_squared > 0.99)
    }
    None => assert_true(false)
  }
}

///|
test "fitting: line fit horizontal" {
  let pts = [
    @core.Point2D::new(0.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  match fit_line(pts) {
    Some(fit) => {
      assert_true(@core.approx_eq(fit.slope, 0.0, 0.001))
      assert_true(@core.approx_eq(fit.intercept, 3.0, 0.001))
    }
    None => assert_true(false)
  }
}

///|
test "fitting: line fit degenerate single point" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  match fit_line(pts) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "fitting: line fit vertical returns none" {
  let pts = [
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  match fit_line(pts) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "fitting: orthogonal line fit" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  match fit_line_orthogonal(pts) {
    Some((a, b, _c)) => {
      let slope = -a / b
      assert_true(@core.approx_eq(slope, 1.0, 0.01))
    }
    None => assert_true(false)
  }
}

///|
test "fitting: orthogonal line fit horizontal" {
  let pts = [
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(3.0, 5.0),
  ]
  match fit_line_orthogonal(pts) {
    Some((a, _, _)) => assert_true(@core.approx_eq(a, 0.0, 0.01))
    None => assert_true(false)
  }
}

///|
test "fitting: circle fit perfect" {
  let pts = [
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(-5.0, 0.0),
    @core.Point2D::new(0.0, -5.0),
    @core.Point2D::new(3.5355339, 3.5355339),
  ]
  match fit_circle(pts) {
    Some(fit) => {
      assert_true(@core.approx_eq(fit.cx, 0.0, 0.01))
      assert_true(@core.approx_eq(fit.cy, 0.0, 0.01))
      assert_true(@core.approx_eq(fit.radius, 5.0, 0.01))
    }
    None => assert_true(false)
  }
}

///|
test "fitting: circle fit offset" {
  let pts = [
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(4.5, 5.5),
    @core.Point2D::new(4.5, 0.5),
  ]
  match fit_circle(pts) {
    Some(fit) => {
      assert_true(@core.approx_eq(fit.cx, 4.5, 0.01))
      assert_true(@core.approx_eq(fit.cy, 3.0, 0.01))
      assert_true(@core.approx_eq(fit.radius, 2.5, 0.01))
    }
    None => assert_true(false)
  }
}

///|
test "fitting: circle fit degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  match fit_circle(pts) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "fitting: centroid" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(0.0, 6.0),
  ]
  match centroid(pts) {
    Some(c) => {
      assert_true(@core.approx_eq(c.x(), 2.0, 0.001))
      assert_true(@core.approx_eq(c.y(), 2.0, 0.001))
    }
    None => assert_true(false)
  }
}

///|
test "fitting: centroid empty" {
  let pts : Array[@core.Point2D] = []
  match centroid(pts) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "fitting: centroid single" {
  let pts = [@core.Point2D::new(3.0, 7.0)]
  match centroid(pts) {
    Some(c) => {
      assert_true(@core.approx_eq(c.x(), 3.0, 0.001))
      assert_true(@core.approx_eq(c.y(), 7.0, 0.001))
    }
    None => assert_true(false)
  }
}
