///|
/// # Discontinuous Galerkin Method
/// # 间断 Galerkin 方法
///
/// DG method for hyperbolic PDEs with discontinuous solutions.
/// 具有间断解的双曲 PDE 的 DG 方法。

///|
pub fn dg_mass_matrix(h : Double, p : Int) -> Double {
  h / (2.0 * p.to_double() + 1.0)
}

///|
pub fn dg_stiffness_matrix(h : Double, p : Int) -> Double {
  if p == 0 { return 0.0 }
  2.0 * p.to_double() / h
}

///|
pub fn dg_numerical_flux(u_left : Double, u_right : Double, alpha : Double) -> Double {
  0.5 * (u_left + u_right) - 0.5 * alpha * (u_right - u_left)
}

///|
pub fn dg_lax_friedrichs_flux(f_left : Double, f_right : Double, u_left : Double, u_right : Double, alpha : Double) -> Double {
  0.5 * (f_left + f_right) - 0.5 * alpha * (u_right - u_left)
}

///|
pub fn dg_error_estimate(element_error : Double, h : Double, p : Int) -> Double {
  element_error * pow_h(h, p + 1)
}

fn pow_h(h : Double, p : Int) -> Double {
  let mut result = 1.0
  for _ in 0..<p {
    result *= h
  }
  result
}
