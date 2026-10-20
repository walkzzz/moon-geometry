test "revolve_z basic" {
  let profile = [(1.0, 0.0), (1.0, 1.0)]
  let (verts, faces) = revolve_z(profile, 8)
  assert_eq(verts.length(), 16)
  assert_true(faces.length() > 0)
}

test "revolve_x basic" {
  let profile = [(1.0, 0.0), (1.0, 1.0)]
  let (verts, _) = revolve_x(profile, 4)
  assert_eq(verts.length(), 8)
}

test "revolve_y basic" {
  let profile = [(1.0, 0.0), (2.0, 1.0)]
  let (verts, _) = revolve_y(profile, 4)
  assert_eq(verts.length(), 8)
}

test "revolve_point_z basic" {
  let (x, y, z) = revolve_point_z(1.0, 0.5, 0.0)
  assert_true((x - 1.0).abs() < 0.0001)
  assert_true(y.abs() < 0.0001)
  assert_true((z - 0.5).abs() < 0.0001)
}

test "revolve_area_z cylinder" {
  let profile = [(1.0, 0.0), (1.0, 1.0)]
  let area = revolve_area_z(profile)
  assert_true((area - 6.283185307).abs() < 0.001)
}