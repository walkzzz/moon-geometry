///| Cumulative normal angles via Gauss map. / 通过 Gauss 映射累积法向量角。
pub fn gauss_map_normals(angles : Array[Double]) -> Array[Double] {
  let result = Array::make(angles.length(), 0.0)
  let mut cumul = 0.0
  for i in 0..<angles.length() {
    cumul += angles[i]
    result[i] = cumul
  }
  result
}
