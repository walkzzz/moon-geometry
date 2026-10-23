///| Geometric Hashing | 几何哈希

///| Geometric hash tables for model-based recognition

///| 基于模型的识别用几何哈希表

///|
/// Hash a 2D point to a grid cell index. / 将二维点哈希到网格单元索引。
pub fn hash_point_2d(
  x : Double,
  y : Double,
  grid_size : Double,
) -> (Int32, Int32) {
  ((x / grid_size).floor().to_int(), (y / grid_size).floor().to_int())
}

///|
/// Compute basis-invariant coordinates of a point relative to a basis. / 计算点相对于基底的不变坐标。
pub fn hash_basis_invariant(
  p1x : Double,
  p1y : Double,
  p2x : Double,
  p2y : Double,
  p3x : Double,
  p3y : Double,
) -> (Double, Double) {
  let dx = p2x - p1x
  let dy = p2y - p1y
  let scale = (dx * dx + dy * dy).sqrt()
  if scale < 1.0e-10 {
    (0.0, 0.0)
  } else {
    let cos_a = dx / scale
    let sin_a = dy / scale
    let tx = (p3x - p1x) * cos_a + (p3y - p1y) * sin_a
    let ty = -(p3x - p1x) * sin_a + (p3y - p1y) * cos_a
    (tx / scale, ty / scale)
  }
}

///|
/// Compute a quantized hash key from 2D coordinates. / 由二维坐标计算量化哈希键。
pub fn hash_key(x : Double, y : Double, bins : Int32) -> Int32 {
  let v = ((x + y) * bins.to_double()).floor().to_int()
  if v < 0 {
    0
  } else if v >= bins {
    bins - 1
  } else {
    v
  }
}

///|
/// Compute the match ratio between two hash arrays. / 计算两个哈希数组的匹配率。
pub fn similarity_score(h1 : Array[Int32], h2 : Array[Int32]) -> Double {
  let mut match_count = 0
  let n = if h1.length() < h2.length() { h1.length() } else { h2.length() }
  for i in 0..<n {
    if h1[i] == h2[i] {
      match_count += 1
    }
  }
  match_count.to_double() / n.to_double()
}
