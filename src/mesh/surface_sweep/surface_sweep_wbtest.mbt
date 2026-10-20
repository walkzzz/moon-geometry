test "sweep_surface basic" {
  let profile = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
  let path = [(0.0, 0.0, 0.0), (0.0, 0.0, 5.0)]
  let (verts, faces) = sweep_surface(profile, path)
  assert_eq(verts.length(), 8)
  assert_true(faces.length() > 0)
}

test "sweep_point basic" {
  let pf = fn(t : Double) {
    (t, 0.0)
  }
  let pathf = fn(s : Double) {
    (0.0, 0.0, s)
  }
  let (x, y, z) = sweep_point(pf, pathf, 2.0, 0.5)
  assert_true((x - 0.5).abs() < 0.0001)
  assert_true(y.abs() < 0.0001)
  assert_true((z - 2.0).abs() < 0.0001)
}

test "sweep_area basic" {
  let profile = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
  let path = [(0.0, 0.0, 0.0), (0.0, 0.0, 5.0)]
  let area = sweep_area(profile, path)
  assert_true(area > 0.0)
}