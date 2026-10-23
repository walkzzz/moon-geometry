///|
pub fn rational_degree(m : RationalMap) -> Int {
  let nd = m.num_coeffs.length() - 1
  let dd = m.den_coeffs.length() - 1
  if nd > dd { nd - dd } else { 0 }
}
