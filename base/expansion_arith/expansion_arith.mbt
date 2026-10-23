///| Expansion Arithmetic | 扩展算术

///| Non-overlapping floating-point expansions for exact arithmetic

///| 非重叠浮点扩展用于精确算术

///|
/// Scale expansion e by scalar b. / 将扩展 e 乘以标量 b。
pub fn scale_expansion(e : Array[Double], b : Double) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = e[i] * b
  }
  result
}

///|
/// Compress expansion into single-component result. / 将扩展压缩为单分量结果。
pub fn compress_expansion(e : Array[Double]) -> Array[Double] {
  let mut total = 0.0
  for v in e {
    total += v
  }
  [total]
}

///|
/// Count non-zero components in expansion. / 统计扩展中非零分量的个数。
pub fn expansion_length(e : Array[Double]) -> Int32 {
  let mut n = 0
  for v in e {
    if v.abs() > 0.0 {
      n += 1
    }
  }
  n
}

///|
/// Euclidean norm of expansion components. / 扩展分量的欧几里得范数。
pub fn expansion_norm(e : Array[Double]) -> Double {
  let mut sum = 0.0
  for v in e {
    sum += v * v
  }
  sum.sqrt()
}

///|
/// Negate all components of expansion. / 对扩展所有分量取负。
pub fn expansion_negate(e : Array[Double]) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = -e[i]
  }
  result
}
