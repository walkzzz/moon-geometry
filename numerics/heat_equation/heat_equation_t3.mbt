///|
pub fn heat_steady_state_1d(boundary_left : Double, boundary_right : Double, n : Int) -> Array[Double] {
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = boundary_left + (boundary_right - boundary_left) * i.to_double() / (n - 1).to_double()
  }
  result
}

///|
pub fn heat_analytical_1d(x : Double, t : Double, alpha : Double, length : Double) -> Double {
  @math.exp(-alpha * @math.PI * @math.PI * t / (length * length)) * @math.sin(@math.PI * x / length)
}
