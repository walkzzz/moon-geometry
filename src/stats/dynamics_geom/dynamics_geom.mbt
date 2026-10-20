///|
/// # Dynamics Geometry | 刚体动力学几何
/// Rigid body dynamics geometry. / 刚体动力学几何。
///|
pub fn inertia_tensor_rect(mass : Double, width : Double, height : Double, depth : Double) -> (Double, Double, Double) {
  let ixx = mass * (height * height + depth * depth) / 12.0
  let iyy = mass * (width * width + depth * depth) / 12.0
  let izz = mass * (width * width + height * height) / 12.0
  (ixx, iyy, izz)
}
///|
pub fn inertia_tensor_sphere(mass : Double, r : Double) -> Double {
  2.0 * mass * r * r / 5.0
}
///|
pub fn angular_momentum(i_val : Double, omega : Double) -> Double {
  i_val * omega
}
///|
pub fn torque(i_val : Double, alpha : Double) -> Double {
  i_val * alpha
}
///|
pub fn kinetic_energy_rot(i_val : Double, omega : Double) -> Double {
  0.5 * i_val * omega * omega
}
