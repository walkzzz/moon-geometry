///|
/// # Discrete Morse Theory
/// # 离散 Morse 理论
///
/// Discrete Morse functions and critical point analysis.
/// 离散 Morse 函数与临界点分析。

///|
pub struct MorseFunction {
  values : Array[Double]
}

///|
pub fn MorseFunction::new(values : Array[Double]) -> MorseFunction {
  { values, }
}

///|
pub fn critical_points(mf : MorseFunction) -> Array[Int] {
  let n = mf.values.length()
  let result : Array[Int] = []
  if n == 0 { return result }
  if n == 1 { result.push(0); return result }
  for i in 0..<n {
    let mut is_critical = true
    if i > 0 && mf.values[i - 1] < mf.values[i] { is_critical = false }
    if i < n - 1 && mf.values[i + 1] < mf.values[i] { is_critical = false }
    if is_critical { result.push(i) }
  }
  result
}

///|
pub fn morse_inequality_lower(mf : MorseFunction, dim : Int) -> Int {
  ignore(dim)
  critical_points(mf).length()
}

///|
pub fn is_morse(mf : MorseFunction) -> Bool {
  let n = mf.values.length()
  for i in 1..<n {
    if (mf.values[i] - mf.values[i - 1]).abs() < 0.000000000001 {
      return false
    }
  }
  true
}
