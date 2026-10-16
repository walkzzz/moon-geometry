test "perspective project" {
  let p = Perspective::new(1.0, 0.0, 0.0, 0.1, 100.0)
  let pt = @core.Point3D::new(2.0, 4.0, 2.0)
  match p.project(pt) {
    Some(p2) => {
      assert_true((p2.x() - 1.0).abs() < 0.0001)
      assert_true((p2.y() - 2.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

test "perspective out of range" {
  let p = Perspective::new(1.0, 0.0, 0.0, 0.1, 100.0)
  let pt = @core.Point3D::new(1.0, 1.0, 200.0)
  match p.project(pt) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "perspective unproject" {
  let p = Perspective::new(1.0, 0.0, 0.0, 0.1, 100.0)
  let pt = @core.Point2D::new(1.0, 2.0)
  let dir = p.unproject(pt)
  assert_true((dir.x - 1.0).abs() < 0.0001)
  assert_true((dir.y - 2.0).abs() < 0.0001)
}

test "perspective depth" {
  let p = Perspective::new(1.0, 0.0, 0.0, 1.0, 10.0)
  let pt = @core.Point3D::new(0.0, 0.0, 5.0)
  let d = p.depth(pt)
  assert_true(d > -1.0 && d < 1.0)
}

test "perspective fov" {
  let p = Perspective::new(100.0, 0.0, 0.0, 0.1, 100.0)
  let fov = p.fov(200.0)
  assert_true(fov > 0.0 && fov < 3.14159265)
}