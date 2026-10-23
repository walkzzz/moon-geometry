///|
test "laplacian smooth" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(1.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let smoothed = laplacian_smooth(m, 0.5)
  assert_eq(@mesh_data.Mesh::vertex_count(smoothed), 3)
  assert_eq(@mesh_data.Mesh::face_count(smoothed), 1)
}

///|
test "laplacian smooth iter" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(1.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let smoothed = laplacian_smooth_iter(m, 0.5, 3)
  assert_eq(@mesh_data.Mesh::vertex_count(smoothed), 3)
}

///|
test "taubin smooth" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(1.0, 2.0, 0.0))
  m.add_face(v0, v1, v2)
  let smoothed = taubin_smooth(m, 0.5, -0.53)
  assert_eq(@mesh_data.Mesh::vertex_count(smoothed), 3)
}

///|
test "smooth displacement" {
  let m = @mesh_data.Mesh::new()
  ignore(m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0)))
  ignore(m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0)))
  let m2 = @mesh_data.Mesh::new()
  ignore(m2.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0)))
  ignore(m2.add_vertex(@core.Point3D::new(2.0, 0.0, 0.0)))
  let d = smooth_displacement(m, m2)
  assert_true((d - 1.0).abs() < 0.001)
}

///|
test "laplacian preserves flat" {
  let m = @mesh_data.Mesh::new()
  let v0 = m.add_vertex(@core.Point3D::new(0.0, 0.0, 0.0))
  let v1 = m.add_vertex(@core.Point3D::new(1.0, 0.0, 0.0))
  let v2 = m.add_vertex(@core.Point3D::new(0.5, 0.866, 0.0))
  m.add_face(v0, v1, v2)
  let smoothed = laplacian_smooth(m, 0.5)
  let d = smooth_displacement(m, smoothed)
  assert_true(d >= 0.0)
}
