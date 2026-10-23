///|
/// Get a vertex by index. / 按索引获取顶点。
pub fn Mesh::get_vertex(m : Mesh, i : Int32) -> @core.Point3D {
  m.vertices[i]
}

///|
/// Get a face by index. / 按索引获取面。
pub fn Mesh::get_face(m : Mesh, i : Int32) -> MeshFace {
  m.faces[i]
}

///|
/// Compute the bounding box of the mesh. / 计算网格的包围盒。
pub fn Mesh::bounding_box(m : Mesh) -> (@core.Point3D, @core.Point3D) {
  if m.vertices.length() == 0 {
    return (
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
    )
  }
  let mut min_x = m.vertices[0].x
  let mut min_y = m.vertices[0].y
  let mut min_z = m.vertices[0].z
  let mut max_x = m.vertices[0].x
  let mut max_y = m.vertices[0].y
  let mut max_z = m.vertices[0].z
  for v in m.vertices {
    min_x = min_x.min(v.x)
    min_y = min_y.min(v.y)
    min_z = min_z.min(v.z)
    max_x = max_x.max(v.x)
    max_y = max_y.max(v.y)
    max_z = max_z.max(v.z)
  }
  (
    @core.Point3D::new(min_x, min_y, min_z),
    @core.Point3D::new(max_x, max_y, max_z),
  )
}

///|
/// Build a mesh from a tetrahedron. / 由四面体构建网格。
pub fn Mesh::tetrahedron(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Mesh {
  let m = Mesh::new()
  let i0 = m.add_vertex(a)
  let i1 = m.add_vertex(b)
  let i2 = m.add_vertex(c)
  let i3 = m.add_vertex(d)
  m.add_face(i0, i1, i2)
  m.add_face(i0, i1, i3)
  m.add_face(i0, i2, i3)
  m.add_face(i1, i2, i3)
  m
}
