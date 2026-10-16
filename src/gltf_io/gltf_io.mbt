///|
/// glTF mesh: vertices + triangle indices.
/// glTF 网格：顶点 + 三角形索引。
pub struct GltfMesh {
  vertices : Array[@core.Point3D]
  indices : Array[Int]
}

///|
/// Create an empty glTF mesh. / 创建空 glTF 网格。
pub fn GltfMesh::new() -> GltfMesh {
  { vertices: [], indices: [] }
}

///|
/// Number of vertices. / 顶点数。
pub fn GltfMesh::vertex_count(m : GltfMesh) -> Int {
  m.vertices.length()
}

///|
/// Number of indices. / 索引数。
pub fn GltfMesh::index_count(m : GltfMesh) -> Int {
  m.indices.length()
}

///|
/// Write glTF 2.0 mesh as JSON text (simplified embedded format).
/// 将 glTF 2.0 网格写为 JSON 文本（简化嵌入格式）。
pub fn gltf_write_json(mesh : GltfMesh) -> String {
  let mut out = "{\"asset\":{\"version\":\"2.0\"},\"vertices\":["
  for i in 0..<mesh.vertices.length() {
    let p = mesh.vertices[i]
    if i > 0 {
      out += ","
    }
    out += p.x.to_string() + "," + p.y.to_string() + "," + p.z.to_string()
  }
  out += "],\"indices\":["
  for i in 0..<mesh.indices.length() {
    if i > 0 {
      out += ","
    }
    out += mesh.indices[i].to_string()
  }
  out + "]}"
}

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


///|
/// Write glTF mesh as binary bytes (compact format).
/// 将 glTF 网格写为二进制字节（紧凑格式）。
pub fn gltf_write_binary(mesh : GltfMesh) -> Bytes {
  let nv = mesh.vertices.length()
  let ni = mesh.indices.length()
  let total = 8 + nv * 12 + ni * 4
  let buf : Array[Byte] = Array::make(total, Byte::default())
  let mut pos = 0
  pos = set_u32le(buf, pos, nv)
  pos = set_u32le(buf, pos, ni)
  for p in mesh.vertices {
    pos = set_f32le(buf, pos, p.x)
    pos = set_f32le(buf, pos, p.y)
    pos = set_f32le(buf, pos, p.z)
  }
  for idx in mesh.indices {
    pos = set_u32le(buf, pos, idx)
  }
  Bytes::from_iter(buf.iter())
}

///|
/// Parse binary glTF bytes into mesh. / 将二进制 glTF 字节解析为网格。
pub fn gltf_parse_binary(data : Bytes) -> GltfMesh {
  let mesh = GltfMesh::new()
  if data.length() < 8 {
    return mesh
  }
  let nv = get_u32le(data, 0)
  let ni = get_u32le(data, 4)
  let mut pos = 8
  for _ in 0..<nv {
    if pos + 12 > data.length() {
      break
    }
    let x = get_f32le(data, pos)
    let y = get_f32le(data, pos + 4)
    let z = get_f32le(data, pos + 8)
    mesh.vertices.push(@core.Point3D::new(x, y, z))
    pos += 12
  }
  for _ in 0..<ni {
    if pos + 4 > data.length() {
      break
    }
    mesh.indices.push(get_u32le(data, pos))
    pos += 4
  }
  mesh
}

fn set_u32le(buf : Array[Byte], offset : Int, v : Int) -> Int {
  buf[offset] = (v & 255).to_byte()
  buf[offset + 1] = ((v >> 8) & 255).to_byte()
  buf[offset + 2] = ((v >> 16) & 255).to_byte()
  buf[offset + 3] = ((v >> 24) & 255).to_byte()
  offset + 4
}

fn get_u32le(data : Bytes, offset : Int) -> Int {
  data.at(offset).to_int() |
  (data.at(offset + 1).to_int() << 8) |
  (data.at(offset + 2).to_int() << 16) |
  (data.at(offset + 3).to_int() << 24)
}

fn set_f32le(buf : Array[Byte], offset : Int, v : Double) -> Int {
  let bits = Float::from_double(v).reinterpret_as_int()
  buf[offset] = (bits & 255).to_byte()
  buf[offset + 1] = ((bits >> 8) & 255).to_byte()
  buf[offset + 2] = ((bits >> 16) & 255).to_byte()
  buf[offset + 3] = ((bits >> 24) & 255).to_byte()
  offset + 4
}

fn get_f32le(data : Bytes, offset : Int) -> Double {
  let b0 = data.at(offset).to_int()
  let b1 = data.at(offset + 1).to_int() << 8
  let b2 = data.at(offset + 2).to_int() << 16
  let b3 = data.at(offset + 3).to_int() << 24
  Float::reinterpret_from_int(b0 | b1 | b2 | b3).to_double()
}

fn pd(s : StringView) -> Double {
  let t = s.trim()
  if t.length() == 0 {
    return 0.0
  }
  let chars = t.to_array()
  let n = chars.length()
  let mut i = 0
  let mut neg = false
  if chars[0] == '-' {
    neg = true
    i = 1
  } else if chars[0] == '+' {
    i = 1
  }
  let mut int_part = 0.0
  while i < n && chars[i] != '.' && chars[i] != 'e' && chars[i] != 'E' {
    if chars[i] >= '0' && chars[i] <= '9' {
      int_part = int_part * 10.0 + (chars[i].to_int() - 48).to_double()
      i += 1
    } else {
      break
    }
  }
  let mut frac = 0.0
  let mut div = 1.0
  if i < n && chars[i] == '.' {
    i += 1
    while i < n && chars[i] != 'e' && chars[i] != 'E' {
      if chars[i] >= '0' && chars[i] <= '9' {
        frac = frac * 10.0 + (chars[i].to_int() - 48).to_double()
        div *= 10.0
        i += 1
      } else {
        break
      }
    }
  }
  let mut res = int_part + frac / div
  if i < n && (chars[i] == 'e' || chars[i] == 'E') {
    i += 1
    let mut en = false
    if i < n && chars[i] == '-' {
      en = true
      i += 1
    } else if i < n && chars[i] == '+' {
      i += 1
    }
    let mut e = 0
    while i < n && chars[i] >= '0' && chars[i] <= '9' {
      e = e * 10 + (chars[i].to_int() - 48)
      i += 1
    }
    let m = @math.pow(10.0, e.to_double())
    if en {
      res = res / m
    } else {
      res = res * m
    }
  }
  if neg {
    -res
  } else {
    res
  }
}

fn pi(s : StringView) -> Int {
  let t = s.trim()
  if t.length() == 0 {
    return 0
  }
  let chars = t.to_array()
  let n = chars.length()
  let mut i = 0
  let mut neg = false
  if chars[0] == '-' {
    neg = true
    i = 1
  } else if chars[0] == '+' {
    i = 1
  }
  let mut v = 0
  while i < n && chars[i] >= '0' && chars[i] <= '9' {
    v = v * 10 + (chars[i].to_int() - 48)
    i += 1
  }
  if neg {
    -v
  } else {
    v
  }
}
