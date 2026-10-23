///|
/// STL triangle: normal + 3 vertices. / STL 三角形：法线 + 3 顶点。
pub struct StlTriangle {
  normal : @core.Point3D
  v0 : @core.Point3D
  v1 : @core.Point3D
  v2 : @core.Point3D
}


///|
/// Construct an STL triangle. / 构造 STL 三角形。
pub fn StlTriangle::new(
  normal : @core.Point3D,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
) -> StlTriangle {
  { normal, v0, v1, v2 }
}


///|
/// STL mesh: name + triangles. / STL 网格：名称 + 三角形数组。
pub struct StlMesh {
  name : String
  triangles : Array[StlTriangle]
}


///|
/// Create an empty STL mesh. / 创建空 STL 网格。
pub fn StlMesh::new(name : String) -> StlMesh {
  { name, triangles: [] }
}


///|
/// Number of triangles. / 三角形数量。
pub fn StlMesh::triangle_count(m : StlMesh) -> Int {
  m.triangles.length()
}


///|
/// Write STL mesh as ASCII text. / 将 STL 网格写为 ASCII 文本。
pub fn stl_write_ascii(mesh : StlMesh) -> String {
  let mut out = "solid " + mesh.name + "\n"
  for t in mesh.triangles {
    out += "facet normal " +
    t.normal.x.to_string() +
    " " +
    t.normal.y.to_string() +
    " " +
    t.normal.z.to_string() +
    "\nouter loop\n"
    out += vert_line(t.v0)
    out += vert_line(t.v1)
    out += vert_line(t.v2)
    out += "endloop\nendfacet\n"
  }
  out + "endsolid " + mesh.name + "\n"
}

fn vert_line(p : @core.Point3D) -> String {
  "vertex " + p.x.to_string() + " " + p.y.to_string() + " " + p.z.to_string() + "\n"
}
