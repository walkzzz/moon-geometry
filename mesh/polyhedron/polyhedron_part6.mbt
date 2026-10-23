///|
/// Compute centroid (volume-weighted). / 计算质心（体积加权）。
pub fn Polyhedron::centroid(p : Polyhedron) -> @core.Point3D {
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  let mut total_vol = 0.0
  for face in p.faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = p.vertices[face[0]]
    for i in 1..<(n - 1) {
      let v1 = p.vertices[face[i]]
      let v2 = p.vertices[face[i + 1]]
      let det = v0.dot(v1.cross(v2))
      let vol = det / 6.0
      cx += vol * (v0.x + v1.x + v2.x) / 4.0
      cy += vol * (v0.y + v1.y + v2.y) / 4.0
      cz += vol * (v0.z + v1.z + v2.z) / 4.0
      total_vol += vol
    }
  }
  if total_vol.abs() < 0.0000000001 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  @core.Point3D::new(cx / total_vol, cy / total_vol, cz / total_vol)
}


///|
/// Create a unit cube. / 创建单位立方体。
pub fn Polyhedron::cube(
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> Polyhedron {
  let p = Polyhedron::new()
  let v0 = p.add_vertex(@core.Point3D::new(min_x, min_y, min_z))
  let v1 = p.add_vertex(@core.Point3D::new(max_x, min_y, min_z))
  let v2 = p.add_vertex(@core.Point3D::new(max_x, max_y, min_z))
  let v3 = p.add_vertex(@core.Point3D::new(min_x, max_y, min_z))
  let v4 = p.add_vertex(@core.Point3D::new(min_x, min_y, max_z))
  let v5 = p.add_vertex(@core.Point3D::new(max_x, min_y, max_z))
  let v6 = p.add_vertex(@core.Point3D::new(max_x, max_y, max_z))
  let v7 = p.add_vertex(@core.Point3D::new(min_x, max_y, max_z))
  p.add_face([v0, v3, v2, v1])
  p.add_face([v4, v5, v6, v7])
  p.add_face([v0, v1, v5, v4])
  p.add_face([v1, v2, v6, v5])
  p.add_face([v2, v3, v7, v6])
  p.add_face([v3, v0, v4, v7])
  p
}


///|
/// Create a tetrahedron. / 创建四面体。
pub fn Polyhedron::tetrahedron(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
  p3 : @core.Point3D,
) -> Polyhedron {
  let p = Polyhedron::new()
  let v0 = p.add_vertex(p0)
  let v1 = p.add_vertex(p1)
  let v2 = p.add_vertex(p2)
  let v3 = p.add_vertex(p3)
  p.add_face([v0, v2, v1])
  p.add_face([v0, v1, v3])
  p.add_face([v0, v3, v2])
  p.add_face([v1, v2, v3])
  p
}