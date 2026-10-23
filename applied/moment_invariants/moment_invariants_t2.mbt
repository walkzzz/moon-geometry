///|
/// Integer power of a double. / Double 的整数幂。
fn powi(base : Double, exp : Int) -> Double {
  let mut result = 1.0
  for _ in 0..<exp {
    result *= base
  }
  result
}

