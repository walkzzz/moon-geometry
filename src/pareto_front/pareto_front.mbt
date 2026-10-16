///|
/// # Pareto Front
/// # Pareto 前沿
///
/// Pareto front computation and analysis.
/// Pareto 前沿计算与分析。

///|
/// Check if point a dominates point b (minimization). / 检查a是否支配b（最小化）。
pub fn dominates(a : Array[Double], b : Array[Double]) -> Bool {
  let mut all_leq = true
  let mut some_lt = false
  for i in 0..<a.length() {
    if a[i] > b[i] { all_leq = false }
    if a[i] < b[i] { some_lt = true }
  }
  all_leq && some_lt
}

///|
/// Compute Pareto front from a set of objective vectors. / 从目标向量集合计算Pareto前沿。
pub fn pareto_front_points(objectives : Array[Array[Double]]) -> Array[Int] {
  let n = objectives.length()
  let result : Array[Int] = []
  for i in 0..<n {
    let mut is_dominated = false
    for j in 0..<n {
      if i != j && dominates(objectives[j], objectives[i]) {
        is_dominated = true
        break
      }
    }
    if !is_dominated { result.push(i) }
  }
  result
}

///|
/// Hypervolume indicator (2D). / 超体积指标（2D）。
pub fn hypervolume_2d(points : Array[(Double, Double)], ref_pt : (Double, Double)) -> Double {
  let n = points.length()
  if n == 0 { return 0.0 }
  let sorted : Array[(Double, Double)] = []
  for i in 0..<n {
    sorted.push(points[i])
  }
  sorted.sort()
  let mut hv = 0.0
  let mut prev_y = ref_pt.1
  for i in 0..<n {
    let x = ref_pt.0 - sorted[i].0
    let y = prev_y - sorted[i].1
    if x > 0.0 && y > 0.0 {
      hv += x * y
    }
    prev_y = sorted[i].1
  }
  hv
}
