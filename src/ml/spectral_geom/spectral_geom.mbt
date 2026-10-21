///| Spectral Geometry | 谱几何
///| Laplacian spectra, heat kernel, spectral invariants
///| Laplacian 谱、热核、谱不变量

///| Compute first n eigenvalues of 1D Laplacian on an interval. / 计算区间上一维 Laplacian 前 n 个特征值。
pub fn laplacian_spectrum_1d(n : Int, length : Double) -> Array[Double] {
  let result = Array::make(n, 0.0)
  for k in 1..=n {
    let lambda = @math.pow(k.to_double() * @math.PI / length, 2.0)
    result[k - 1] = lambda
  }
  result
}

///| Evaluate 1D heat kernel series at position x and time t. / 在位置 x 与时间 t 处求一维热核级数。
pub fn heat_kernel_1d(x : Double, t : Double, n_terms : Int) -> Double {
  let mut sum = 0.0
  for k in 1..=n_terms {
    let kn = k.to_double() * @math.PI
    sum += @math.exp(-kn * kn * t) * @math.sin(kn * x)
  }
  sum
}

///| Apply Weyl asymptotic law for 2D Laplacian eigenvalue counting. / 应用 Weyl 渐近律估计二维 Laplacian 特征值计数。
pub fn weyl_law_2d(lambda : Double, area : Double) -> Double {
  area * lambda / (4.0 * @math.PI)
}

///| Compute spectral zeta function sum of eigenvalues to power -s. / 计算特征值负 s 次幂和的谱 zeta 函数。
pub fn spectral_zeta(eigenvalues : Array[Double], s : Double) -> Double {
  let mut sum = 0.0
  for ev in eigenvalues {
    if ev > 1.0e-10 {
      sum += @math.pow(ev, -s)
    }
  }
  sum
}

///| Compute heat trace sum of exp(-eigenvalue * t). / 计算 exp(-特征值 * t) 的热迹和。
pub fn heat_trace(eigenvalues : Array[Double], t : Double) -> Double {
  let mut sum = 0.0
  for ev in eigenvalues {
    sum += @math.exp(-ev * t)
  }
  sum
}

///| Check whether two spectra are equal within tolerance. / 检查两个谱在容差内是否相等。
pub fn isospectral_check(spec1 : Array[Double], spec2 : Array[Double]) -> Bool {
  if spec1.length() != spec2.length() {
    return false
  }
  for i in 0..<spec1.length() {
    if (spec1[i] - spec2[i]).abs() > 1.0e-10 {
      return false
    }
  }
  true
}
