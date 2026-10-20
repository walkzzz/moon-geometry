///|
/// # TDA Features
/// # 拓扑数据分析特征
///
/// Feature extraction from persistence diagrams for machine learning.
/// 从持久性图提取特征用于机器学习。

///|
pub fn tda_total_persistence(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let mut sum = 0.0
  for i in 0..<diagram.length() {
    sum += @persistence_diagram.persistence(diagram[i])
  }
  sum
}

///|
pub fn tda_max_persistence(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @persistence_diagram.max_persistence(diagram)
}

///|
pub fn tda_feature_vector(diagram : Array[@persistence_diagram.PersistencePoint]) -> Array[Double] {
  let total = tda_total_persistence(diagram)
  let max_p = tda_max_persistence(diagram)
  let n = diagram.length().to_double()
  let mean = if n > 0.0 { total / n } else { 0.0 }
  let mut var_sum = 0.0
  for i in 0..<diagram.length() {
    let p = @persistence_diagram.persistence(diagram[i])
    let diff = p - mean
    var_sum += diff * diff
  }
  let variance = if n > 0.0 { var_sum / n } else { 0.0 }
  [total, max_p, n, mean, variance]
}

///|
pub fn tda_amplitude(diagram : Array[@persistence_diagram.PersistencePoint], p : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<diagram.length() {
    let pers = @persistence_diagram.persistence(diagram[i])
    sum += pow_d(pers, p)
  }
  pow_d(sum, 1.0 / p)
}

fn pow_d(base : Double, exp : Double) -> Double {
  if base < 0.000000000001 { return 0.0 }
  @math.exp(exp * @math.ln(base))
}
