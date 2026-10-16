///|
/// # Schrödinger Solver | 薛定谔方程求解器
/// Schrödinger equation solver. / 薛定谔方程求解器。
///|
pub fn schrodinger_kinetic(psi_real : Array[Double], psi_imag : Array[Double], hbar : Double, m : Double, dx : Double, dt : Double) -> (Array[Double], Array[Double]) {
  let n = psi_real.length()
  let coef = hbar * hbar / (2.0 * m * dx * dx)
  let dr = Array::make(n, 0.0)
  let di = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    let lap_r = psi_real[i + 1] - 2.0 * psi_real[i] + psi_real[i - 1]
    let lap_i = psi_imag[i + 1] - 2.0 * psi_imag[i] + psi_imag[i - 1]
    dr[i] = -coef * lap_r * dt / hbar
    di[i] = -coef * lap_i * dt / hbar
  }
  (dr, di)
}
///|
pub fn probability_density(psi_real : Double, psi_imag : Double) -> Double {
  psi_real * psi_real + psi_imag * psi_imag
}
///|
pub fn normalize_wavefunction(psi_real : Array[Double], psi_imag : Array[Double], dx : Double) -> (Array[Double], Array[Double]) {
  let mut norm = 0.0
  for i in 0..<psi_real.length() {
    norm += psi_real[i] * psi_real[i] + psi_imag[i] * psi_imag[i]
  }
  norm *= dx
  let sqrt_norm = norm.sqrt()
  let nr = []
  let ni = []
  for i in 0..<psi_real.length() {
    if sqrt_norm.abs() < 0.000000000001 { nr.push(0.0); ni.push(0.0) }
    else { nr.push(psi_real[i] / sqrt_norm); ni.push(psi_imag[i] / sqrt_norm) }
  }
  (nr, ni)
}
