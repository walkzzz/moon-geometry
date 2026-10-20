///| Spectral Geometry | 谱几何
///| Laplacian spectra, heat kernel, spectral invariants
///| Laplacian 谱、热核、谱不变量

pub fn laplacian_spectrum_1d(n : Int, length : Double) -> Array[Double] {
  let result = Array::make(n, 0.0)
  for k in 1..=n {
    let lambda = @math.pow(k.to_double() * @math.PI / length, 2.0)
    result[k - 1] = lambda
  }
  result
}

pub fn heat_kernel_1d(x : Double, t : Double, n_terms : Int) -> Double {
  let mut sum = 0.0
  for k in 1..=n_terms {
    let kn = k.to_double() * @math.PI
    sum += @math.exp(-kn * kn * t) * @math.sin(kn * x)
  }
  sum
}

pub fn weyl_law_2d(lambda : Double, area : Double) -> Double {
  area * lambda / (4.0 * @math.PI)
}

pub fn spectral_zeta(eigenvalues : Array[Double], s : Double) -> Double {
  let mut sum = 0.0
  for ev in eigenvalues {
    if ev > 1.0e-10 {
      sum += @math.pow(ev, -s)
    }
  }
  sum
}

pub fn heat_trace(eigenvalues : Array[Double], t : Double) -> Double {
  let mut sum = 0.0
  for ev in eigenvalues {
    sum += @math.exp(-ev * t)
  }
  sum
}

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
