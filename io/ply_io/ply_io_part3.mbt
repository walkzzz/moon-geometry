///|
/// Parse ASCII PLY text into mesh. / 将 ASCII PLY 文本解析为网格。
pub fn ply_parse_ascii(text : String) -> PlyMesh {
  let mesh = PlyMesh::new()
  let mut in_header = true
  let mut expect_verts = 0
  let mut expect_faces = 0
  let mut section = 0 // 0=none, 1=verts, 2=faces
  for line in text.split("\n") {
    let parts = tokens(line)
    if parts.length() == 0 {
      continue
    }
    if in_header {
      let cmd = parts[0].to_owned()
      if cmd == "end_header" {
        in_header = false
        section = 1
      } else if cmd == "element" && parts.length() >= 3 {
        let kind = parts[1].to_owned()
        let cnt = pi(parts[2])
        if kind == "vertex" {
          expect_verts = cnt
        } else if kind == "face" {
          expect_faces = cnt
        }
      }
      continue
    }
    // body
    if section == 1 && mesh.vertices.length() < expect_verts {
      if parts.length() >= 3 {
        mesh.vertices.push(
          @core.Point3D::new(pd(parts[0]), pd(parts[1]), pd(parts[2])),
        )
      }
      if mesh.vertices.length() == expect_verts {
        section = 2
      }
    } else if section == 2 && mesh.faces.length() < expect_faces {
      if parts.length() >= 2 {
        let n = pi(parts[0])
        let face : Array[Int32] = []
        for k in 1..<(n + 1) {
          if k < parts.length() {
            face.push(pi(parts[k]))
          }
        }
        mesh.faces.push(face)
      }
    }
  }
  mesh
}
