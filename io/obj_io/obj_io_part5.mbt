///|
/// Parse a Double from a string view. / 从字符串视图解析 Double。
pub fn parse_double_sv(s : StringView) -> Double {
  pd(s)
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