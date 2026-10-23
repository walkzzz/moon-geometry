///|
/// Count simplices in the alpha complex. / 计算 Alpha 复形中的单纯形数。
pub fn alpha_complex_count(ac : AlphaComplex) -> Int {
  ac.simplices.length()
}