///| Expansion Arithmetic | 扩展算术
///| Non-overlapping floating-point expansions for exact arithmetic
///| 非重叠浮点扩展用于精确算术

pub fn scale_expansion(e : Array[Double], b : Double) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = e[i] * b
  }
  result
}

pub fn compress_expansion(e : Array[Double]) -> Array[Double] {
  let mut total = 0.0
  for v in e {
    total += v
  }
  [total]
}

pub fn expansion_length(e : Array[Double]) -> Int {
  let mut n = 0
  for v in e {
    if v.abs() > 0.0 {
      n += 1
    }
  }
  n
}

pub fn expansion_norm(e : Array[Double]) -> Double {
  let mut sum = 0.0
  for v in e {
    sum += v * v
  }
  sum.sqrt()
}

pub fn expansion_negate(e : Array[Double]) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = -e[i]
  }
  result
}
