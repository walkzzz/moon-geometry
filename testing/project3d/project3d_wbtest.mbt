test "orthographic" {
  let p = @core.Point3D::new(1.0, 2.0, 3.0)
  let p2 = orthographic(p)
  assert_true((p2.x() - 1.0).abs() < 0.0001)
  assert_true((p2.y() - 2.0).abs() < 0.0001)
}

test "perspective project" {
  let p = @core.Point3D::new(2.0, 4.0, 2.0)
  match perspective_project(p, 1.0) {
    Some(pt) => {
      assert_true((pt.x() - 1.0).abs() < 0.0001)
      assert_true((pt.y() - 2.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

test "perspective zero z" {
  let p = @core.Point3D::new(1.0, 2.0, 0.0)
  match perspective_project(p, 1.0) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "orthographic batch" {
  let pts = [
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(4.0, 5.0, 6.0),
  ]
  let result = orthographic_batch(pts)
  assert_eq(result.length(), 2)
}

test "isometric" {
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = isometric(p)
  assert_true(p2.x() > 0.0)
}