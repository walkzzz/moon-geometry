///|
/// Parse ASCII STL text into mesh. / 将 ASCII STL 文本解析为网格。
pub fn stl_parse_ascii(text : String) -> StlMesh {
  let mut name = "default"
  let triangles : Array[StlTriangle] = []
  let mut cur_normal = @core.Point3D::new(0.0, 0.0, 0.0)
  let cur_verts : Array[@core.Point3D] = []
  for line in text.split("\n") {
    let parts = tokens(line)
    if parts.length() == 0 {
      continue
    }
    let cmd = parts[0].to_owned()
    if cmd == "solid" && parts.length() >= 2 {
      name = parts[1].to_owned()
    } else if cmd == "facet" && parts.length() >= 5 {
      cur_normal = @core.Point3D::new(pd(parts[2]), pd(parts[3]), pd(parts[4]))
    } else if cmd == "vertex" && parts.length() >= 4 {
      cur_verts.push(
        @core.Point3D::new(pd(parts[1]), pd(parts[2]), pd(parts[3])),
      )
    } else if cmd == "endfacet" {
      if cur_verts.length() >= 3 {
        triangles.push(
          StlTriangle::new(cur_normal, cur_verts[0], cur_verts[1], cur_verts[2]),
        )
      }
      cur_verts.clear()
    }
  }
  { name, triangles, }
}
