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
      cur_verts.push(@core.Point3D::new(pd(parts[1]), pd(parts[2]), pd(parts[3])))
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

///|
/// Write STL mesh as binary bytes. / 将 STL 网格写为二进制字节。
pub fn stl_write_binary(mesh : StlMesh) -> Bytes {
  let n = mesh.triangles.length()
  let total = 84 + n * 50
  let fa : Array[Byte] = Array::make(total, Byte::default())
  let mut pos = 0
  // 80-byte header (name)
  for c in mesh.name.iter() {
    if pos >= 80 {
      break
    }
    fa[pos] = (c.to_int() & 255).to_byte()
    pos += 1
  }
  while pos < 80 {
    fa[pos] = Byte::default()
    pos += 1
  }
  // triangle count (uint32 little-endian) at offset 80
  set_uint32_le(fa, 80, n)
  pos = 84
  for t in mesh.triangles {
    pos = set_float_le(fa, pos, t.normal.x)
    pos = set_float_le(fa, pos, t.normal.y)
    pos = set_float_le(fa, pos, t.normal.z)
    pos = set_float_le(fa, pos, t.v0.x)
    pos = set_float_le(fa, pos, t.v0.y)
    pos = set_float_le(fa, pos, t.v0.z)
    pos = set_float_le(fa, pos, t.v1.x)
    pos = set_float_le(fa, pos, t.v1.y)
    pos = set_float_le(fa, pos, t.v1.z)
    pos = set_float_le(fa, pos, t.v2.x)
    pos = set_float_le(fa, pos, t.v2.y)
    pos = set_float_le(fa, pos, t.v2.z)
    // attribute byte count = 0
    fa[pos] = Byte::default()
    fa[pos + 1] = Byte::default()
    pos += 2
  }
  Bytes::from_iter(fa.iter())
}

///|
/// Parse binary STL bytes into mesh. / 将二进制 STL 字节解析为网格。
pub fn stl_parse_binary(data : Bytes) -> StlMesh {
  let mesh = StlMesh::new("binary")
  if data.length() < 84 {
    return mesh
  }
  let n = get_uint32_le(data, 80)
  let mut pos = 84
  for _ in 0..<n {
    if pos + 50 > data.length() {
      break
    }
    let nx = get_float_le(data, pos)
    let ny = get_float_le(data, pos + 4)
    let nz = get_float_le(data, pos + 8)
    let v0x = get_float_le(data, pos + 12)
    let v0y = get_float_le(data, pos + 16)
    let v0z = get_float_le(data, pos + 20)
    let v1x = get_float_le(data, pos + 24)
    let v1y = get_float_le(data, pos + 28)
    let v1z = get_float_le(data, pos + 32)
    let v2x = get_float_le(data, pos + 36)
    let v2y = get_float_le(data, pos + 40)
    let v2z = get_float_le(data, pos + 44)
    mesh.triangles.push(
      StlTriangle::new(
        @core.Point3D::new(nx, ny, nz),
        @core.Point3D::new(v0x, v0y, v0z),
        @core.Point3D::new(v1x, v1y, v1z),
        @core.Point3D::new(v2x, v2y, v2z),
      ),
    )
    pos += 50
  }
  mesh
}

fn set_uint32_le(fa : Array[Byte], offset : Int, v : Int) -> Unit {
  fa[offset] = (v & 255).to_byte()
  fa[offset + 1] = ((v >> 8) & 255).to_byte()
  fa[offset + 2] = ((v >> 16) & 255).to_byte()
  fa[offset + 3] = ((v >> 24) & 255).to_byte()
}

fn get_uint32_le(data : Bytes, offset : Int) -> Int {
  data.at(offset).to_int() |
  (data.at(offset + 1).to_int() << 8) |
  (data.at(offset + 2).to_int() << 16) |
  (data.at(offset + 3).to_int() << 24)
}

fn set_float_le(fa : Array[Byte], offset : Int, v : Double) -> Int {
  let bits = Float::from_double(v).reinterpret_as_int()
  fa[offset] = (bits & 255).to_byte()
  fa[offset + 1] = ((bits >> 8) & 255).to_byte()
  fa[offset + 2] = ((bits >> 16) & 255).to_byte()
  fa[offset + 3] = ((bits >> 24) & 255).to_byte()
  offset + 4
}

fn get_float_le(data : Bytes, offset : Int) -> Double {
  let b0 = data.at(offset).to_int()
  let b1 = data.at(offset + 1).to_int() << 8
  let b2 = data.at(offset + 2).to_int() << 16
  let b3 = data.at(offset + 3).to_int() << 24
  let bits = b0 | b1 | b2 | b3
  Float::reinterpret_from_int(bits).to_double()
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

fn tokens(s : StringView) -> Array[StringView] {
  let result : Array[StringView] = []
  let mut cur = ""
  for c in s.iter() {
    if c == ' ' || c == '\t' || c == '\r' {
      if cur.length() > 0 {
        result.push(cur.to_string_view())
        cur = ""
      }
    } else {
      cur += c.to_string()
    }
  }
  if cur.length() > 0 {
    result.push(cur.to_string_view())
  }
  result
}