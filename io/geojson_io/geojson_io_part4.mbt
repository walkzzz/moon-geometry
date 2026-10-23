///|
/// Parse GeoJSON text into geometry. / 将 GeoJSON 文本解析为几何。
pub fn geojson_parse(text : String) -> GeoJsonGeometry? {
  let typ = extract_string(text, "\"type\":\"")
  let coords_start = match text.find("\"coordinates\":") {
    Some(i) => i + "\"coordinates\":".length()
    None => return None
  }
  let jval = match parse_json_value(text.to_array(), coords_start) {
    Some((v, _)) => v
    None => return None
  }
  match typ {
    Some(t) => build_geometry(t, jval)
    None => None
  }
}

fn build_geometry(typ : String, val : JsonValue) -> GeoJsonGeometry? {
  if typ == "Point" {
    match val {
      JArray(arr) =>
        match jarr_to_point(arr) {
          Some(p) => Some(GeoPoint(p))
          None => None
        }
      _ => None
    }
  } else if typ == "LineString" {
    match val {
      JArray(arr) => Some(GeoLineString(jarr_to_points(arr)))
      _ => None
    }
  } else if typ == "Polygon" {
    match val {
      JArray(arr) => Some(GeoPolygon(jarr_to_rings(arr)))
      _ => None
    }
  } else if typ == "MultiPoint" {
    match val {
      JArray(arr) => Some(GeoMultiPoint(jarr_to_points(arr)))
      _ => None
    }
  } else if typ == "MultiLineString" {
    match val {
      JArray(arr) => Some(GeoMultiLineString(jarr_to_rings(arr)))
      _ => None
    }
  } else if typ == "MultiPolygon" {
    match val {
      JArray(arr) => Some(GeoMultiPolygon(jarr_to_polygons(arr)))
      _ => None
    }
  } else {
    None
  }
}

fn jarr_to_point(arr : Array[JsonValue]) -> @core.Point2D? {
  if arr.length() >= 2 {
    match (arr[0], arr[1]) {
      (JNumber(x), JNumber(y)) => Some(@core.Point2D::new(x, y))
      _ => None
    }
  } else {
    None
  }
}

fn jarr_to_points(arr : Array[JsonValue]) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for v in arr {
    match v {
      JArray(a) =>
        match jarr_to_point(a) {
          Some(p) => result.push(p)
          None => ()
        }
      _ => ()
    }
  }
  result
}

fn jarr_to_rings(arr : Array[JsonValue]) -> Array[Array[@core.Point2D]] {
  let result : Array[Array[@core.Point2D]] = []
  for v in arr {
    match v {
      JArray(a) => result.push(jarr_to_points(a))
      _ => ()
    }
  }
  result
}

fn jarr_to_polygons(arr : Array[JsonValue]) -> Array[Array[Array[@core.Point2D]]] {
  let result : Array[Array[Array[@core.Point2D]]] = []
  for v in arr {
    match v {
      JArray(a) => result.push(jarr_to_rings(a))
      _ => ()
    }
  }
  result
}

fn pts_to_json(points : Array[@core.Point2D]) -> String {
  let mut out = "["
  for i in 0..<points.length() {
    if i > 0 {
      out += ","
    }
    out += "[" + points[i].x().to_string() + "," + points[i].y().to_string() + "]"
  }
  out + "]"
}

fn extract_string(text : String, key : String) -> String? {
  let start = match text.find(key) {
    Some(i) => i + key.length()
    None => return None
  }
  let chars = text.to_array()
  let n = chars.length()
  let mut out = ""
  let mut i = start
  while i < n && chars[i] != '"' {
    out += chars[i].to_string()
    i += 1
  }
  Some(out)
}

fn parse_json_value(chars : Array[Char], start : Int) -> (JsonValue, Int)? {
  let n = chars.length()
  let mut i = start
  while i < n && (chars[i] == ' ' || chars[i] == '\n' || chars[i] == '\t') {
    i += 1
  }
  if i >= n {
    return None
  }
  if chars[i] == '[' {
    parse_json_array(chars, i)
  } else {
    let (num, ni) = parse_json_number(chars, i)
    Some((JNumber(num), ni))
  }
}

fn parse_json_array(chars : Array[Char], start : Int) -> (JsonValue, Int)? {
  let n = chars.length()
  let mut i = start + 1
  let arr : Array[JsonValue] = []
  while i < n {
    while i < n && (chars[i] == ' ' || chars[i] == ',' || chars[i] == '\n' || chars[i] == '\t') {
      i += 1
    }
    if i >= n {
      break
    }
    if chars[i] == ']' {
      return Some((JArray(arr), i + 1))
    }
    if chars[i] == '[' {
      match parse_json_array(chars, i) {
        Some((v, ni)) => {
          arr.push(v)
          i = ni
        }
        None => return None
      }
    } else {
      let (num, ni) = parse_json_number(chars, i)
      arr.push(JNumber(num))
      i = ni
    }
  }
  Some((JArray(arr), i))
}

fn parse_json_number(chars : Array[Char], start : Int) -> (Double, Int) {
  let n = chars.length()
  let mut i = start
  let mut s = ""
  while i < n {
    let c = chars[i]
    if c == ' ' || c == ',' || c == ']' || c == '}' || c == '\n' {
      break
    }
    s += c.to_string()
    i += 1
  }
  (pd(s.to_string_view()), i)
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