///|
/// Parse glTF JSON text into mesh. / 将 glTF JSON 文本解析为网格。
pub fn gltf_parse_json(text : String) -> GltfMesh {
  let mesh = GltfMesh::new()
  let verts = extract_array(text, "\"vertices\":[")
  let mut vi = 0
  while vi + 2 < verts.length() {
    mesh.vertices.push(
      @core.Point3D::new(pd(verts[vi]), pd(verts[vi + 1]), pd(verts[vi + 2])),
    )
    vi += 3
  }
  let idxs = extract_array(text, "\"indices\":[")
  for s in idxs {
    mesh.indices.push(pi(s))
  }
  mesh
}

fn extract_array(text : String, key : String) -> Array[StringView] {
  let result : Array[StringView] = []
  let start = match text.find(key) {
    Some(i) => i + key.length()
    None => return result
  }
  let chars = text.to_array()
  let n = chars.length()
  let mut depth = 1
  let mut i = start
  let mut token = ""
  while i < n && depth > 0 {
    let c = chars[i]
    if c == '[' {
      depth += 1
      i += 1
    } else if c == ']' {
      depth -= 1
      if depth == 0 {
        if token.length() > 0 {
          result.push(token.to_string_view())
          token = ""
        }
      }
      i += 1
    } else if c == ',' && depth == 1 {
      if token.length() > 0 {
        result.push(token.to_string_view())
        token = ""
      }
      i += 1
    } else if c == ' ' || c == '\n' || c == '\t' {
      i += 1
    } else {
      token += c.to_string()
      i += 1
    }
  }
  result
}

