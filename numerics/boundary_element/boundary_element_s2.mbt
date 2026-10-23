///|
pub fn boundary_integral_kernel(r : Double, normal_dist : Double) -> Double {
  if r < 0.000000000001 {
    return 0.0
  }
  normal_dist / (2.0 * 3.141592653589793 * r * r)
}

///|
pub fn bem_matrix_entry(r : Double, weight : Double) -> Double {
  fundamental_solution_2d(r) * weight
}
