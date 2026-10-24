///|
test "quadric ellipsoid classification" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Ellipsoid => true
      _ => false
    },
  )
}

///|
test "quadric eval on surface" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  assert_true(Quadric::on_surface(q, p, 0.000000001))
}

///|
test "quadric eval off surface" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(2.0, 0.0, 0.0)
  assert_false(Quadric::on_surface(q, p, 0.000000001))
}

///|
test "quadric gradient" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let g = Quadric::gradient(q, p)
  assert_true((g.x - 2.0).abs() < 0.000000001)
  assert_true(g.y.abs() < 0.000000001)
  assert_true(g.z.abs() < 0.000000001)
}

///|
test "quadric normal unit" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let n = Quadric::normal(q, p)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
}

///|
test "quadric center" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, -2.0, -4.0, -6.0, 3.0)
  match Quadric::center(q) {
    Some(c) => {
      assert_true((c.x - 1.0).abs() < 0.000000001)
      assert_true((c.y - 2.0).abs() < 0.000000001)
      assert_true((c.z - 3.0).abs() < 0.000000001)
    }
    None => assert_true(false)
  }
}

///|
test "quadric trace" {
  let q = Quadric::new(1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  assert_true((Quadric::trace(q) - 6.0).abs() < 0.000000001)
}

///|
test "quadric hyperboloid one sheet" {
  let q = Quadric::new(1.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      HyperboloidOneSheet => true
      _ => false
    },
  )
}

///|
test "quadric elliptic paraboloid" {
  let q = Quadric::new(1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      EllipticParaboloid => true
      _ => false
    },
  )
}

///|
test "quadric centered" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, -2.0, 0.0, 0.0, 0.0)
  let cq = Quadric::centered(q)
  assert_true(cq.g.abs() < 0.000000001)
  assert_true(cq.h.abs() < 0.000000001)
  assert_true(cq.i.abs() < 0.000000001)
}

///|
test "quadric eval direct" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let v = Quadric::eval(q, p)
  assert_true(v.abs() < 0.000000001)
}

///|
test "quadric eval nonzero" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(2.0, 0.0, 0.0)
  let v = Quadric::eval(q, p)
  assert_true((v - 3.0).abs() < 0.000000001)
}

///|
test "quadric quadratic det" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let d = Quadric::quadratic_det(q)
  assert_true((d - 8.0).abs() < 0.000000001)
}

///|
test "quadric hyperboloid two sheets" {
  let q = Quadric::new(1.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      HyperboloidTwoSheets => true
      _ => false
    },
  )
}

///|
test "quadric hyperbolic paraboloid" {
  let q = Quadric::new(2.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      HyperbolicParaboloid => true
      _ => false
    },
  )
}

///|
test "quadric elliptic cone" {
  let q = Quadric::new(1.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      EllipticCone => true
      _ => false
    },
  )
}

///|
test "quadric elliptic cylinder" {
  let q = Quadric::new(1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      EllipticCylinder => true
      _ => false
    },
  )
}

///|
test "quadric normal zero gradient" {
  let q = Quadric::new(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let n = Quadric::normal(q, p)
  assert_true(n.x.abs() < 0.000000001)
  assert_true(n.y.abs() < 0.000000001)
  assert_true(n.z.abs() < 0.000000001)
}

///|
test "quadric center no center" {
  let q = Quadric::new(1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0)
  match Quadric::center(q) {
    None => assert_true(true)
    Some(_) => assert_true(false)
  }
}

///|
test "quadric centered no center" {
  let q = Quadric::new(1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0)
  let cq = Quadric::centered(q)
  assert_true((cq.a - 1.0).abs() < 0.000000001)
}

///|
test "quadric gradient cross terms" {
  let q = Quadric::new(0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0)
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let g = Quadric::gradient(q, p)
  assert_true((g.x - 2.0).abs() < 0.000000001)
  assert_true((g.y - 2.0).abs() < 0.000000001)
  assert_true((g.z - 2.0).abs() < 0.000000001)
}

///|
test "quadric trace with cross" {
  let q = Quadric::new(2.0, 3.0, 4.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0)
  assert_true((Quadric::trace(q) - 9.0).abs() < 0.000000001)
}

///|
test "quadric eval with linear terms" {
  let q = Quadric::new(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 3.0, 4.0, 5.0)
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let v = Quadric::eval(q, p)
  assert_true((v - 14.0).abs() < 0.000000001)
}

///|
test "quadric on surface boundary" {
  let q = Quadric::new(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 5.0, 5.0)
  assert_true(Quadric::on_surface(q, p, 0.001))
}

///|
test "quadric normal general point" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(0.0, 1.0, 0.0)
  let n = Quadric::normal(q, p)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
}

///|
test "quadric classify degenerate no linear trace zero" {
  let q = Quadric::new(1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Degenerate => true
      _ => false
    },
  )
}

///|
test "quadric eigen disc positive three distinct roots" {
  let q = Quadric::new(1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Ellipsoid => true
      _ => false
    },
  )
}

///|
test "quadric eigen disc zero repeated root" {
  let q = Quadric::new(1.0, 1.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Ellipsoid => true
      _ => false
    },
  )
}

///|
test "quadric centered verifies j value" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, -2.0, -4.0, -6.0, 3.0)
  let cq = Quadric::centered(q)
  let center = @core.Point3D::new(1.0, 2.0, 3.0)
  let nf = Quadric::eval(q, center)
  assert_true((cq.j - nf).abs() < 0.000000001)
  assert_true(cq.g.abs() < 0.000000001)
  assert_true(cq.h.abs() < 0.000000001)
  assert_true(cq.i.abs() < 0.000000001)
}

///|
test "quadric eval with cross terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 2.0, 2.0, 2.0, 0.0, 0.0, 0.0, 0.0)
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let v = Quadric::eval(q, p)
  assert_true((v - 9.0).abs() < 0.000000001)
}

///|
test "quadric gradient with linear terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 2.0, 4.0, 6.0, 0.0)
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  let g = Quadric::gradient(q, p)
  assert_true((g.x - 2.0).abs() < 0.000000001)
  assert_true((g.y - 4.0).abs() < 0.000000001)
  assert_true((g.z - 6.0).abs() < 0.000000001)
}

///|
test "quadric quadratic det zero" {
  let q = Quadric::new(1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let d = Quadric::quadratic_det(q)
  assert_true(d.abs() < 0.000000001)
}

///|
test "quadric normal with cross terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let n = Quadric::normal(q, p)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
}

///|
test "quadric on_surface with cross terms" {
  let q = Quadric::new(0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 1.0, 0.0)
  assert_true(Quadric::on_surface(q, p, 0.000000001))
}

///|
test "quadric trace negative" {
  let q = Quadric::new(-1.0, -2.0, -3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  assert_true((Quadric::trace(q) - -6.0).abs() < 0.000000001)
}

///|
test "quadric classify degenerate positive definite" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Degenerate => true
      _ => false
    },
  )
}

///|
test "quadric eval at origin" {
  let q = Quadric::new(1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0)
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  let v = Quadric::eval(q, p)
  assert_true((v - 5.0).abs() < 0.000000001)
}

///|
test "quadric gradient at origin no linear" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  let g = Quadric::gradient(q, p)
  assert_true(g.x.abs() < 0.000000001)
  assert_true(g.y.abs() < 0.000000001)
  assert_true(g.z.abs() < 0.000000001)
}

///|
test "quadric normal at origin zero" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  let n = Quadric::normal(q, p)
  assert_true(n.x.abs() < 0.000000001)
  assert_true(n.y.abs() < 0.000000001)
  assert_true(n.z.abs() < 0.000000001)
}

///|
test "quadric center at origin" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  match Quadric::center(q) {
    Some(c) => {
      assert_true(c.x.abs() < 0.000000001)
      assert_true(c.y.abs() < 0.000000001)
      assert_true(c.z.abs() < 0.000000001)
    }
    None => assert_true(false)
  }
}

///|
test "quadric trace zero" {
  let q = Quadric::new(1.0, 1.0, -2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  assert_true(Quadric::trace(q).abs() < 0.000000001)
}

///|
test "quadric quadratic det negative" {
  let q = Quadric::new(1.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let d = Quadric::quadratic_det(q)
  assert_true(d < 0.0)
}

///|
test "quadric on surface z axis" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(0.0, 0.0, 1.0)
  assert_true(Quadric::on_surface(q, p, 0.000000001))
}

///|
test "quadric centered preserves quadratic" {
  let q = Quadric::new(2.0, 2.0, 2.0, 0.0, 0.0, 0.0, -4.0, -6.0, -8.0, 5.0)
  let cq = Quadric::centered(q)
  assert_true((cq.a - 2.0).abs() < 0.000000001)
  assert_true((cq.b - 2.0).abs() < 0.000000001)
  assert_true((cq.c - 2.0).abs() < 0.000000001)
}

///|
test "quadric eval negative point" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(-1.0, 0.0, 0.0)
  let v = Quadric::eval(q, p)
  assert_true(v.abs() < 0.000000001)
}

///|
test "quadric gradient negative point" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(-1.0, 0.0, 0.0)
  let g = Quadric::gradient(q, p)
  assert_true((g.x + 2.0).abs() < 0.000000001)
}
///|
test "quadric classify f0 positive pos1 neg2 ellipsoid" {
  let q = Quadric::new(-1.0, -1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Ellipsoid => true
      _ => false
    },
  )
}

///|
test "quadric classify f0 negative pos1 neg2 hyperboloid two sheets" {
  let q = Quadric::new(-1.0, -1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      HyperboloidTwoSheets => true
      _ => false
    },
  )
}

///|
test "quadric classify f0 positive else degenerate" {
  let q = Quadric::new(-1.0, -1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Degenerate => true
      _ => false
    },
  )
}

///|
test "quadric classify f0 negative else degenerate" {
  let q = Quadric::new(-1.0, -1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Degenerate => true
      _ => false
    },
  )
}

///|
test "quadric classify det sub zero hyperbolic paraboloid" {
  let q = Quadric::new(0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      HyperbolicParaboloid => true
      _ => false
    },
  )
}

///|
test "quadric eigen all equal roots" {
  let q = Quadric::new(2.0, 2.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(
    match qt {
      Ellipsoid => true
      _ => false
    },
  )
}

///|
test "quadric centered with cross terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 1.0, 0.0, 0.0, -2.0, 0.0, 0.0, 0.0)
  let cq = Quadric::centered(q)
  assert_true(cq.g.abs() < 0.000000001)
  assert_true(cq.h.abs() < 0.000000001)
  assert_true(cq.i.abs() < 0.000000001)
}

///|
test "quadric normal with linear terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 2.0, 4.0, 6.0, 0.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let n = Quadric::normal(q, p)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
}

///|
test "quadric eval all terms" {
  let q = Quadric::new(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0)
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let v = Quadric::eval(q, p)
  let expected = 1.0 + 2.0 + 3.0 + 4.0 + 5.0 + 6.0 + 7.0 + 8.0 + 9.0 + 10.0
  assert_true((v - expected).abs() < 0.000000001)
}

///|
test "quadric on surface false cross terms" {
  let q = Quadric::new(0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(2.0, 1.0, 0.0)
  assert_false(Quadric::on_surface(q, p, 0.000000001))
}

///|
test "quadric gradient with cross and linear" {
  let q = Quadric::new(1.0, 2.0, 3.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0)
  let p = @core.Point3D::new(1.0, 1.0, 1.0)
  let g = Quadric::gradient(q, p)
  let gx = 2.0 * 1.0 + 1.0 * 1.0 + 1.0 * 1.0 + 1.0
  let gy = 1.0 * 1.0 + 2.0 * 2.0 * 1.0 + 1.0 * 1.0 + 1.0
  let gz = 1.0 * 1.0 + 1.0 * 1.0 + 2.0 * 3.0 * 1.0 + 1.0
  assert_true((g.x - gx).abs() < 0.000000001)
  assert_true((g.y - gy).abs() < 0.000000001)
  assert_true((g.z - gz).abs() < 0.000000001)
}

///|
test "quadric quadratic det with cross terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 2.0, 2.0, 2.0, 0.0, 0.0, 0.0, 0.0)
  let d = Quadric::quadratic_det(q)
  assert_true(d.abs() < 0.000000001)
}

///|
test "quadric center with cross terms" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  match Quadric::center(q) {
    Some(c) => {
      assert_true(c.x.abs() < 0.000000001)
      assert_true(c.y.abs() < 0.000000001)
      assert_true(c.z.abs() < 0.000000001)
    }
    None => assert_true(false)
  }
}
