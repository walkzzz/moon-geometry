///| Geometric Hashing | 几何哈希
///| Geometric hash tables for model-based recognition
///| 基于模型的识别用几何哈希表

pub fn hash_point_2d(x : Double, y : Double, grid_size : Double) -> (Int, Int) {
  ((x / grid_size).floor().to_int(), (y / grid_size).floor().to_int())
}

pub fn hash_basis_invariant(p1x : Double, p1y : Double, p2x : Double, p2y : Double, p3x : Double, p3y : Double) -> (Double, Double) {
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

pub fn hash_key(x : Double, y : Double, bins : Int) -> Int {
  let v = ((x + y) * bins.to_double()).floor().to_int()
  if v < 0 { 0 } else if v >= bins { bins - 1 } else { v }
}

pub fn similarity_score(h1 : Array[Int], h2 : Array[Int]) -> Double {
  let mut match_count = 0
  let n = if h1.length() < h2.length() { h1.length() } else { h2.length() }
  for i in 0..<n {
    if h1[i] == h2[i] {
      match_count += 1
    }
  }
  match_count.to_double() / n.to_double()
}
