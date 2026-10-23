///|
test "stereographic from sphere" {
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  match stereographic_from_sphere(p, 1.0) {
    Some(pt) => {
      assert_true((pt.x() - 0.0).abs() < 0.0001)
      assert_true((pt.y() - 0.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "stereographic north pole" {
  let p = @core.Point3D::new(0.0, 0.0, 1.0)
  match stereographic_from_sphere(p, 1.0) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "stereographic to sphere" {
  let p = @core.Point2D::new(0.0, 0.0)
  let s = stereographic_to_sphere(p, 1.0)
  assert_true((s.z - 1.0).abs() < 0.0001)
}

///|
test "on sphere" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  assert_true(on_sphere(p, 1.0))
  let p2 = @core.Point3D::new(2.0, 0.0, 0.0)
  assert_false(on_sphere(p2, 1.0))
}

///|
test "stereographic scale" {
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  let s = stereographic_scale(p, 1.0)
  assert_true((s - 2.0).abs() < 0.0001)
}
