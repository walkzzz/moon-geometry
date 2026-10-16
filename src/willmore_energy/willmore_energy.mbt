///|
/// # Willmore Energy
/// # Willmore 能量
///
/// Willmore energy: integral of mean curvature squared.
/// Willmore 能量：平均曲率平方的积分。

///|
pub fn willmore_energy(mean_curvatures : Array[Double], areas : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<mean_curvatures.length() {
    sum += mean_curvatures[i] * mean_curvatures[i] * areas[i]
  }
  sum
}

///|
pub fn willmore_gradient(h : Double, area : Double) -> Double {
  4.0 * h * h * h * area
}

///|
pub fn willmore_of_sphere(radius : Double) -> Double {
  if radius < 0.000000000001 { return 0.0 }
  16.0 * 3.141592653589793
}

///|
pub fn willmore_flow_step(curvatures : Array[Double], gradient : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<curvatures.length() {
    result.push(curvatures[i] - dt * gradient[i])
  }
  result
}

///|
pub fn is_willmore_minimal(gradient_norm : Double, tol : Double) -> Bool {
  gradient_norm < tol
}
