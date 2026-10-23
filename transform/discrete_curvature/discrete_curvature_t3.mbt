///|
pub fn angle_defect(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<angles.length() {
    sum += angles[i]
  }
  6.283185307179586 - sum
}


///|
pub fn voronoi_area(edge_len : Double) -> Double {
  edge_len * edge_len / 8.0
}
