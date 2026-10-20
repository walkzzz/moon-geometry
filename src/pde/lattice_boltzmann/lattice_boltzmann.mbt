///|
/// # Lattice Boltzmann Method
/// # 格子 Boltzmann 方法
///
/// Lattice Boltzmann method for fluid dynamics simulation.
/// 流体动力学模拟的格子 Boltzmann 方法。

///|
pub fn equilibrium_dist(rho : Double, u : Double, w : Double, cx : Double) -> Double {
  let cu = cx * u
  w * rho * (1.0 + 3.0 * cu + 4.5 * cu * cu - 1.5 * u * u)
}

///|
pub fn collide(f : Double, f_eq : Double, tau : Double) -> Double {
  f - (f - f_eq) / tau
}

///|
pub fn compute_density(dists : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<dists.length() {
    sum += dists[i]
  }
  sum
}

///|
pub fn compute_velocity(dists : Array[Double], velocities : Array[Double]) -> Double {
  let rho = compute_density(dists)
  if rho < 0.000000000001 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<dists.length() {
    sum += dists[i] * velocities[i]
  }
  sum / rho
}

///|
pub fn relaxation_time(nu : Double, dt : Double, dx : Double) -> Double {
  3.0 * nu * dt / (dx * dx) + 0.5
}
