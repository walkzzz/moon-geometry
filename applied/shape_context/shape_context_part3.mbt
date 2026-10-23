///|
/// Chi-square distance between two shape context histograms.
/// 两个形状上下文直方图间的卡方距离。
pub fn shape_context_distance(h1 : Array[Double], h2 : Array[Double]) -> Double {
  let n = h1.length()
  let m = h2.length()
  let len = if n < m { n } else { m }
  let mut dist = 0.0
  for i in 0..<len {
    let sum = h1[i] + h2[i]
    if sum > 0.000000000001 {
      let diff = h1[i] - h2[i]
      dist += diff * diff / sum
    }
  }
  dist / 2.0
}

///|
/// Cost matrix between two sets of shape context descriptors.
/// 两组形状上下文描述子之间的代价矩阵。
pub fn shape_context_cost(
  sc1 : Array[Array[Double]],
  sc2 : Array[Array[Double]],
) -> Array[Array[Double]] {
  let n = sc1.length()
  let m = sc2.length()
  let cost : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<m {
      row.push(shape_context_distance(sc1[i], sc2[j]))
    }
    cost.push(row)
  }
  cost
}
