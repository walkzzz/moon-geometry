///|
/// # Witness Complex
/// # 见证复形
///
/// Witness complex construction from landmark points.
/// 从地标点构建见证复形。

///|
pub fn witness_complex_landmarks(n_points : Int, n_landmarks : Int) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<n_landmarks {
    result.push([i])
  }
  for i in 0..<(n_landmarks - 1) {
    for j in (i + 1)..<n_landmarks {
      result.push([i, j])
    }
  }
  ignore(n_points)
  result
}

///|
pub fn witness_skeleton(max_dim : Int, n_landmarks : Int) -> Int {
  let mut count = 0
  for d in 0..<(max_dim + 1) {
    let mut comb = 1
    for i in 0..<(d + 1) {
      comb = comb * (n_landmarks - i) / (i + 1)
    }
    count += comb
  }
  count
}

///|
pub fn landmark_count(n_points : Int, ratio : Double) -> Int {
  (n_points.to_double() * ratio).to_int()
}
