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