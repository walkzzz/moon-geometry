///|
pub fn laplacian_eigenvalue(mode : Int, area : Double) -> Double {
  if area < 0.000000000001 { return 0.0 }
  mode.to_double() * mode.to_double() * 3.141592653589793 * 3.141592653589793 / area
}


///|
pub fn is_harmonic(laplacian_val : Double, tol : Double) -> Bool {
  laplacian_val.abs() < tol
}
