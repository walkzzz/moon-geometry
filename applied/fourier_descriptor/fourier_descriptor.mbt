///|
/// # Fourier Descriptors
/// # 傅里叶描述子
///
/// FFT coefficients of a closed boundary, with rotation/translation/scale invariants.
/// 闭合边界的 FFT 系数，含旋转/平移/缩放不变量。
///
/// ## Complexity: O(n log n) for FFT
/// ## 复杂度: FFT 为 O(n log n)

///|
/// Next power of two >= n. / 大于等于 n 的下一个 2 的幂。
fn next_pow2(n : Int32) -> Int32 {
  let mut p = 1
  while p < n {
    p *= 2
  }
  p
}

///|
/// Bit reversal of integer with given number of bits. / 指定位数的整数位反转。
fn bit_reverse(x : Int32, bits : Int32) -> Int32 {
  let mut result = 0
  let mut v = x
  for _ in 0..<bits {
    result = (result << 1) | (v & 1)
    v = v >> 1
  }
  result
}
