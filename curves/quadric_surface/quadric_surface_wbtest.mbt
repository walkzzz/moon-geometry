test "quadric ellipsoid classification" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(match qt {
    Ellipsoid => true
    _ => false
  })
}

test "quadric eval on surface" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  assert_true(Quadric::on_surface(q, p, 0.000000001))
}

test "quadric eval off surface" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(2.0, 0.0, 0.0)
  assert_false(Quadric::on_surface(q, p, 0.000000001))
}

test "quadric gradient" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let g = Quadric::gradient(q, p)
  assert_true((g.x - 2.0).abs() < 0.000000001)
  assert_true(g.y.abs() < 0.000000001)
  assert_true(g.z.abs() < 0.000000001)
}

test "quadric normal unit" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let n = Quadric::normal(q, p)
  let mag = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
}

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

test "quadric trace" {
  let q = Quadric::new(1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  assert_true((Quadric::trace(q) - 6.0).abs() < 0.000000001)
}

test "quadric hyperboloid one sheet" {
  let q = Quadric::new(1.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0)
  let qt = Quadric::classify(q)
  assert_true(match qt {
    HyperboloidOneSheet => true
    _ => false
  })
}

test "quadric elliptic paraboloid" {
  let q = Quadric::new(1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0)
  let qt = Quadric::classify(q)
  assert_true(match qt {
    EllipticParaboloid => true
    _ => false
  })
}

test "quadric centered" {
  let q = Quadric::new(1.0, 1.0, 1.0, 0.0, 0.0, 0.0, -2.0, 0.0, 0.0, 0.0)
  let cq = Quadric::centered(q)
  assert_true(cq.g.abs() < 0.000000001)
  assert_true(cq.h.abs() < 0.000000001)
  assert_true(cq.i.abs() < 0.000000001)
}