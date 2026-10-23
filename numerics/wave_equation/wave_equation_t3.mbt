///|
pub fn wave_damping(u : Double, damping : Double, dt : Double) -> Double {
  u * @math.exp(-damping * dt)
}

///|
pub fn wave_energy(u : Array[Double], u_prev : Array[Double], dt : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<u.length() {
    let v = (u[i] - u_prev[i]) / dt
    sum += v * v
  }
  sum * dt / 2.0
}
