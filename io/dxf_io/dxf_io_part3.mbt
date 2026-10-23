///|
/// Parse DXF text into document. / 将 DXF 文本解析为文档。
pub fn dxf_parse(text : String) -> DxfDocument {
  let doc = DxfDocument::new()
  let lines : Array[String] = []
  for line in text.split("\n") {
    lines.push(line.trim().to_owned())
  }
  let mut i = 0
  let n = lines.length()
  let mut in_entities = false
  let mut cur_type = ""
  let mut cur_x1 = 0.0
  let mut cur_y1 = 0.0
  let mut cur_z1 = 0.0
  let mut cur_x2 = 0.0
  let mut cur_y2 = 0.0
  let mut cur_z2 = 0.0
  let mut cur_r = 0.0
  let cur_pts : Array[@core.Point2D] = []
  while i + 1 < n {
    let code = pi(lines[i].to_string_view())
    let value = lines[i + 1]
    if code == 0 {
      if cur_type != "" {
        let e = build_entity(
          cur_type, cur_x1, cur_y1, cur_z1, cur_x2, cur_y2, cur_z2, cur_r, cur_pts,
        )
        match e {
          Some(ent) => doc.entities.push(ent)
          None => ()
        }
        cur_type = ""
        cur_pts.clear()
      }
      if value == "SECTION" {
        // expect next pair 2/ENTITIES
        i += 2
        continue
      } else if value == "ENDSEC" || value == "EOF" {
        in_entities = false
        i += 2
        continue
      } else {
        cur_type = value
        i += 2
        continue
      }
    }
    if code == 2 && value == "ENTITIES" {
      in_entities = true
      i += 2
      continue
    }
    if in_entities && cur_type != "" {
      let dv = pd(value.to_string_view())
      if code == 10 {
        cur_x1 = dv
      } else if code == 20 {
        cur_y1 = dv
        if cur_type == "LWPOLYLINE" {
          cur_pts.push(@core.Point2D::new(cur_x1, cur_y1))
        }
      } else if code == 30 {
        cur_z1 = dv
      } else if code == 11 {
        cur_x2 = dv
      } else if code == 21 {
        cur_y2 = dv
      } else if code == 31 {
        cur_z2 = dv
      } else if code == 40 {
        cur_r = dv
      }
    }
    i += 2
  }
  if cur_type != "" {
    let e = build_entity(
      cur_type, cur_x1, cur_y1, cur_z1, cur_x2, cur_y2, cur_z2, cur_r, cur_pts,
    )
    match e {
      Some(ent) => doc.entities.push(ent)
      None => ()
    }
  }
  doc
}

///|
fn build_entity(
  typ : String,
  x1 : Double,
  y1 : Double,
  z1 : Double,
  x2 : Double,
  y2 : Double,
  z2 : Double,
  r : Double,
  pts : Array[@core.Point2D],
) -> DxfEntity? {
  if typ == "LINE" {
    Some(
      DxfLine(@core.Point3D::new(x1, y1, z1), @core.Point3D::new(x2, y2, z2)),
    )
  } else if typ == "CIRCLE" {
    Some(DxfCircle(@core.Point2D::new(x1, y1), r))
  } else if typ == "LWPOLYLINE" {
    Some(DxfPolyline(pts))
  } else {
    None
  }
}

///|
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
    while i < n {
      if chars[i] >= '0' && chars[i] <= '9' {
        frac = frac * 10.0 + (chars[i].to_int() - 48).to_double()
        div *= 10.0
        i += 1
      } else {
        break
      }
    }
  }
  let res = int_part + frac / div
  if neg {
    -res
  } else {
    res
  }
}

///|
fn pi(s : StringView) -> Int32 {
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
