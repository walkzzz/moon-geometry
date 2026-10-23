///|
/// Parse binary PLY bytes into mesh. / 将二进制 PLY 字节解析为网格。
pub fn ply_parse_binary(data : Bytes) -> PlyMesh {
  let mesh = PlyMesh::new()
  if data.length() < 8 {
    return mesh
  }
  let nv = get_u32le(data, 0)
  let mut pos = 4
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
  if pos + 4 > data.length() {
    return mesh
  }
  let nf = get_u32le(data, pos)
  pos += 4
  for _ in 0..<nf {
    if pos + 1 > data.length() {
      break
    }
    let n = data.at(pos).to_int()
    pos += 1
    let face : Array[Int] = []
    for _ in 0..<n {
      if pos + 4 > data.length() {
        break
      }
      face.push(get_u32le(data, pos))
      pos += 4
    }
    mesh.faces.push(face)
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