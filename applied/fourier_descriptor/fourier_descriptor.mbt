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

///|
/// In-place iterative FFT (Cooley-Tukey). / 原地迭代 FFT（Cooley-Tukey）。
///
/// `re` and `im` are real/imag parts. `inverse` = true for inverse transform.
/// `re` 和 `im` 为实/虚部。`inverse` 为 true 时执行逆变换。
fn fft(re : Array[Double], im : Array[Double], inverse : Bool) -> Unit {
  let n = re.length()
  if n <= 1 {
    return
  }
  let mut bits = 0
  let mut sz = 1
  while sz < n {
    sz *= 2
    bits += 1
  }
  for i in 0..<n {
    let j = bit_reverse(i, bits)
    if j > i {
      let tr = re[i]
      let ti = im[i]
      re[i] = re[j]
      im[i] = im[j]
      re[j] = tr
      im[j] = ti
    }
  }
  let mut len = 2
  while len <= n {
    let ang = if inverse {
      6.283185307179586 / len.to_double()
    } else {
      -6.283185307179586 / len.to_double()
    }
    let wlen_re = @math.cos(ang)
    let wlen_im = @math.sin(ang)
    let mut i = 0
    while i < n {
      let mut w_re = 1.0
      let mut w_im = 0.0
      let half = len / 2
      for j in 0..<half {
        let u_re = re[i + j]
        let u_im = im[i + j]
        let v_re = re[i + j + half] * w_re - im[i + j + half] * w_im
        let v_im = re[i + j + half] * w_im + im[i + j + half] * w_re
        re[i + j] = u_re + v_re
        im[i + j] = u_im + v_im
        re[i + j + half] = u_re - v_re
        im[i + j + half] = u_im - v_im
        let nw_re = w_re * wlen_re - w_im * wlen_im
        let nw_im = w_re * wlen_im + w_im * wlen_re
        w_re = nw_re
        w_im = nw_im
      }
      i += len
    }
    len *= 2
  }
  if inverse {
    let nd = n.to_double()
    for i in 0..<n {
      re[i] = re[i] / nd
      im[i] = im[i] / nd
    }
  }
}

///|
/// Compute Fourier descriptors of a closed boundary.
/// 计算闭合边界的傅里叶描述子。
///
/// Returns complex coefficients (real, imag) padded to power of two.
/// 返回复数系数 (实, 虚)，填充至 2 的幂。
pub fn fourier_descriptors(
  points : Array[@core.Point2D],
) -> Array[(Double, Double)] {
  let n = points.length()
  let result : Array[(Double, Double)] = []
  if n == 0 {
    return result
  }
  let n2 = next_pow2(n)
  let re : Array[Double] = Array::make(n2, 0.0)
  let im : Array[Double] = Array::make(n2, 0.0)
  for i in 0..<n {
    re[i] = points[i].x()
    im[i] = points[i].y()
  }
  fft(re, im, false)
  for i in 0..<n2 {
    result.push((re[i], im[i]))
  }
  result
}

///|
/// Rotation/translation/scale invariant Fourier descriptors.
/// 旋转/平移/缩放不变的傅里叶描述子。
///
/// Normalize by |FD[1]|, take magnitudes, skip DC component (index 0).
/// 以 |FD[1]| 归一化，取模长，跳过直流分量（索引 0）。
pub fn fourier_invariant(points : Array[@core.Point2D]) -> Array[Double] {
  let coeffs = fourier_descriptors(points)
  let result : Array[Double] = []
  if coeffs.length() < 2 {
    return result
  }
  let (r1, i1) = coeffs[1]
  let mag1 = (r1 * r1 + i1 * i1).sqrt()
  if mag1 < 0.000000000001 {
    for _ in 1..<coeffs.length() {
      result.push(0.0)
    }
    return result
  }
  for i in 1..<coeffs.length() {
    let (re, im) = coeffs[i]
    let mag = (re * re + im * im).sqrt()
    result.push(mag / mag1)
  }
  result
}

///|
/// Reconstruct boundary from Fourier descriptors.
/// 从傅里叶描述子重建边界。
pub fn fourier_reconstruct(
  coeffs : Array[(Double, Double)],
  n : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let nc = coeffs.length()
  if nc == 0 || n == 0 {
    return result
  }
  let re : Array[Double] = Array::make(nc, 0.0)
  let im : Array[Double] = Array::make(nc, 0.0)
  for i in 0..<nc {
    let (r, img) = coeffs[i]
    re[i] = r
    im[i] = img
  }
  fft(re, im, true)
  let count = if n < nc { n } else { nc }
  for i in 0..<count {
    result.push(@core.Point2D::new(re[i], im[i]))
  }
  result
}

///|
/// Truncate Fourier descriptors to keep only first k coefficients (low-pass).
/// 截断傅里叶描述子，仅保留前 k 个系数（低通）。
pub fn fourier_truncate(
  coeffs : Array[(Double, Double)],
  k : Int32,
) -> Array[(Double, Double)] {
  let result : Array[(Double, Double)] = []
  let nc = coeffs.length()
  let keep = if k < nc { k } else { nc }
  for i in 0..<keep {
    result.push(coeffs[i])
  }
  for _ in keep..<nc {
    result.push((0.0, 0.0))
  }
  result
}
