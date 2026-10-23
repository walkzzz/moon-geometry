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
