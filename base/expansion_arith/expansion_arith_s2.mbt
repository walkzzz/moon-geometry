///| Scale expansion e by scalar b. / 将扩展 e 乘以标量 b。
pub fn scale_expansion(e : Array[Double], b : Double) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = e[i] * b
  }
  result
}


///| Compress expansion into single-component result. / 将扩展压缩为单分量结果。
pub fn compress_expansion(e : Array[Double]) -> Array[Double] {
  let mut total = 0.0
  for v in e {
    total += v
  }
  [total]
}
