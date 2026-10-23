///|
pub fn element_mass(u_val : Double, v_val : Double, area : Double) -> Double {
  area * u_val * v_val / 3.0
}

///|
pub fn assemble_stiffness(
  n : Int32,
  elements : Array[(Int32, Int32, Int32, Double)],
) -> Array[Array[Double]] {
  let k : Array[Array[Double]] = Array::make(n, Array::make(n, 0.0))
  for e in 0..<elements.length() {
    let (i, j, _l, val) = elements[e]
    k[i][j] += val
    k[j][i] += val
  }
  k
}
