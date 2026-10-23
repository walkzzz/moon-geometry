///|
/// Return maximum absolute scale as IFS contractive factor. / 返回最大绝对缩放因子作为 IFS 压缩因子。
pub fn ifs_contractive_factor(scales : Array[Double]) -> Double {
  let mut max_s = 0.0
  for s in scales {
    let a = s.abs()
    if a > max_s {
      max_s = a
    }
  }
  max_s
}
