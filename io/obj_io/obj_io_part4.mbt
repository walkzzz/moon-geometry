///|
/// Parse OBJ text into mesh. / 将 OBJ 文本解析为网格。
pub fn obj_parse(text : String) -> ObjMesh {
  let mesh = ObjMesh::new()
  for line in text.split("\n") {
    let parts = tokens(line)
    if parts.length() == 0 {
      continue
    }
    let cmd = parts[0].to_owned()
    if cmd == "v" && parts.length() >= 4 {
      mesh.vertices.push(
        @core.Point3D::new(pd(parts[1]), pd(parts[2]), pd(parts[3])),
      )
    } else if cmd == "vt" && parts.length() >= 3 {
      mesh.texcoords.push((pd(parts[1]), pd(parts[2])))
    } else if cmd == "vn" && parts.length() >= 4 {
      mesh.normals.push(
        @core.Point3D::new(pd(parts[1]), pd(parts[2]), pd(parts[3])),
      )
    } else if cmd == "f" && parts.length() >= 2 {
      let fv : Array[ObjFaceVertex] = []
      for k in 1..<parts.length() {
        fv.push(parse_face_vert(parts[k]))
      }
      if fv.length() > 0 {
        mesh.faces.push(ObjFace::new(fv))
      }
    }
  }
  mesh
}

fn parse_face_vert(s : StringView) -> ObjFaceVertex {
  let mut v = 0
  let mut vt = 0
  let mut vn = 0
  let mut idx = 0
  for tok in s.split("/") {
    let t = tok.trim()
    if t.length() > 0 {
      let n = pi(t)
      if idx == 0 {
        v = n
      } else if idx == 1 {
        vt = n
      } else {
        vn = n
      }
    }
    idx += 1
  }
  { v, vt, vn }
}
