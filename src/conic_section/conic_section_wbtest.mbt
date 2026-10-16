test "conic ellipse classification" {
  let c = Conic::new(9.0, 0.0, 4.0, 0.0, 0.0, -36.0)
  let ct = Conic::classify(c)
  assert_true(match ct {
    Ellipse => true
    _ => false
  })
}

test "conic hyperbola classification" {
  let c = Conic::new(9.0, 0.0, -4.0, 0.0, 0.0, -36.0)
  let ct = Conic::classify(c)
  assert_true(match ct {
    Hyperbola => true
    _ => false
  })
}

test "conic parabola classification" {
  let c = Conic::new(0.0, 0.0, 1.0, -4.0, 0.0, 0.0)
  let ct = Conic::classify(c)
  assert_true(match ct {
    Parabola => true
    _ => false
  })
}

test "conic circle classification" {
  let c = Conic::new(1.0, 0.0, 1.0, 0.0, 0.0, -1.0)
  let ct = Conic::classify(c)
  assert_true(match ct {
    Ellipse => true
    _ => false
  })
}

test "conic eval on curve" {
  let c = Conic::new(1.0, 0.0, 1.0, 0.0, 0.0, -1.0)
  let p = @core.Point2D::new(1.0, 0.0)
  assert_true(Conic::on_curve(c, p, 0.000000001))
}

test "conic eval off curve" {
  let c = Conic::new(1.0, 0.0, 1.0, 0.0, 0.0, -1.0)
  let p = @core.Point2D::new(2.0, 0.0)
  assert_false(Conic::on_curve(c, p, 0.000000001))
}

test "conic discriminant" {
  let ellipse = Conic::new(9.0, 0.0, 4.0, 0.0, 0.0, -36.0)
  assert_true(Conic::discriminant(ellipse) < 0.0)
  let hyper = Conic::new(9.0, 0.0, -4.0, 0.0, 0.0, -36.0)
  assert_true(Conic::discriminant(hyper) > 0.0)
  let para = Conic::new(0.0, 0.0, 1.0, -4.0, 0.0, 0.0)
  assert_true(Conic::discriminant(para).abs() < 0.000000001)
}

test "conic center ellipse" {
  let c = Conic::new(1.0, 0.0, 1.0, -4.0, -6.0, 4.0)
  match Conic::center(c) {
    Some(center) => {
      assert_true((center.x() - 2.0).abs() < 0.000000001)
      assert_true((center.y() - 3.0).abs() < 0.000000001)
    }
    None => assert_true(false)
  }
}

test "conic center parabola none" {
  let c = Conic::new(0.0, 0.0, 1.0, -4.0, 0.0, 0.0)
  match Conic::center(c) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "conic tangent at point" {
  let c = Conic::new(1.0, 0.0, 1.0, 0.0, 0.0, -1.0)
  let p = @core.Point2D::new(1.0, 0.0)
  let (a, b, _cc) = Conic::tangent_at(c, p)
  assert_true((a - 2.0).abs() < 0.000000001)
  assert_true(b.abs() < 0.000000001)
}

test "conic asymptotes hyperbola" {
  let c = Conic::new(1.0, 0.0, -1.0, 0.0, 0.0, -1.0)
  match Conic::asymptotes(c) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}

test "conic asymptotes ellipse none" {
  let c = Conic::new(1.0, 0.0, 1.0, 0.0, 0.0, -1.0)
  match Conic::asymptotes(c) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "conic eccentricity parabola" {
  let c = Conic::new(0.0, 0.0, 1.0, -4.0, 0.0, 0.0)
  match Conic::eccentricity(c) {
    Some(e) => assert_true((e - 1.0).abs() < 0.000000001)
    None => assert_true(false)
  }
}

test "conic axis aligned" {
  let c = Conic::new(5.0, 6.0, 5.0, 0.0, 0.0, -8.0)
  let (aligned, _theta) = Conic::axis_aligned(c)
  assert_true(aligned.b.abs() < 0.000000001)
}