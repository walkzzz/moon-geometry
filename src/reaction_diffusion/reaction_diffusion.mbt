///|
/// # Reaction-Diffusion | 反应扩散系统
/// Reaction-diffusion systems. / 反应扩散系统。
///|
pub fn gray_scott(u : Double, v : Double, f : Double, k : Double) -> (Double, Double) {
  let du = -u * v * v + f * (1.0 - u)
  let dv = u * v * v - (f + k) * v
  (du, dv)
}
///|
pub fn diffusion_step(field : Array[Double], d : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = field.length()
  let coef = d * dt / (dx * dx)
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { field[i - 1] } else { field[i] }
    let right = if i < n - 1 { field[i + 1] } else { field[i] }
    result[i] = field[i] + coef * (left - 2.0 * field[i] + right)
  }
  result
}
///|
pub fn turing_pattern_step(u : Array[Double], v : Array[Double], du : Double, dv : Double, f : Double, k : Double, dt : Double, dx : Double) -> (Array[Double], Array[Double]) {
  let u_diff = diffusion_step(u, du, dt, dx)
  let v_diff = diffusion_step(v, dv, dt, dx)
  let new_u = Array::make(u.length(), 0.0)
  let new_v = Array::make(v.length(), 0.0)
  for i in 0..<u.length() {
    let (ru, rv) = gray_scott(u[i], v[i], f, k)
    new_u[i] = u_diff[i] + ru * dt
    new_v[i] = v_diff[i] + rv * dt
  }
  (new_u, new_v)
}
