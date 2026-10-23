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
