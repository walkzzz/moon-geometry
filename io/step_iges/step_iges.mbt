///|

///|
/// STEP/IGES entity: type name + parameter list. / STEP/IGES 实体：类型名 + 参数列表。
pub struct StepEntity {
  entity_type : String
  params : Array[String]
}

///|
/// Construct a STEP entity. / 构造 STEP 实体。
pub fn StepEntity::new(
  entity_type : String,
  params : Array[String],
) -> StepEntity {
  { entity_type, params, }
}

///|
/// Parse STEP file content into entities (simple line-by-line). / 将 STEP 文件内容解析为实体（简单逐行解析）。
pub fn parse_step(content : String) -> Array[StepEntity] {
  let entities : Array[StepEntity] = []
  for line in content.split("\n") {
    let s = line.trim().to_owned()
    if s.length() == 0 {
      continue
    }
    let chars = s.to_array()
    if chars[0] != '#' {
      continue
    }
    let eq_pos = find_char(chars, '=', 0)
    if eq_pos < 0 {
      continue
    }
    let paren_pos = find_char(chars, '(', eq_pos + 1)
    if paren_pos < 0 {
      let t = slice_str(chars, eq_pos + 1, chars.length()).trim().to_owned()
      if t.length() > 0 {
        entities.push(StepEntity::new(t, []))
      }
      continue
    }
    let t = slice_str(chars, eq_pos + 1, paren_pos).trim().to_owned()
    let close_pos = find_matching_paren(chars, paren_pos)
    let pstr = slice_str(chars, paren_pos + 1, close_pos)
    entities.push(StepEntity::new(t, split_commas(pstr)))
  }
  entities
}

///|
/// Write STEP entities to file content (simple writer). / 将 STEP 实体写为文件内容（简单写入）。
pub fn write_step(entities : Array[StepEntity]) -> String {
  let mut out = "ISO-10303-21;\nHEADER;\nENDSEC;\nDATA;\n"
  for i in 0..<entities.length() {
    let e = entities[i]
    out += "#" + (i + 1).to_string() + " = " + e.entity_type + "("
    for j in 0..<e.params.length() {
      if j > 0 {
        out += ", "
      }
      out += e.params[j]
    }
    out += ");\n"
  }
  out + "ENDSEC;\nEND-ISO-10303-21;\n"
}

///|
fn find_char(chars : Array[Char], c : Char, start : Int32) -> Int32 {
  let n = chars.length()
  if start >= n {
    return -1
  }
  for i in start..<n {
    if chars[i] == c {
      return i
    }
  }
  -1
}

///|
fn find_matching_paren(chars : Array[Char], open_pos : Int32) -> Int32 {
  let n = chars.length()
  if open_pos + 1 >= n {
    return n
  }
  let mut depth = 1
  for i in (open_pos + 1)..<n {
    if chars[i] == '(' {
      depth += 1
    } else if chars[i] == ')' {
      depth -= 1
      if depth == 0 {
        return i
      }
    }
  }
  n
}

///|
fn slice_str(chars : Array[Char], lo : Int32, hi : Int32) -> String {
  let mut s = ""
  if lo < 0 || hi > chars.length() || lo >= hi {
    return s
  }
  for i in lo..<hi {
    s += chars[i].to_string()
  }
  s
}

///|
fn split_commas(s : String) -> Array[String] {
  let result : Array[String] = []
  let chars = s.to_array()
  let n = chars.length()
  let mut depth = 0
  let mut cur = ""
  for i in 0..<n {
    let c = chars[i]
    if c == '(' {
      depth += 1
      cur += c.to_string()
    } else if c == ')' {
      depth -= 1
      cur += c.to_string()
    } else if c == ',' && depth == 0 {
      result.push(cur.trim().to_owned())
      cur = ""
    } else {
      cur += c.to_string()
    }
  }
  let t = cur.trim().to_owned()
  if t.length() > 0 {
    result.push(t)
  }
  result
}
