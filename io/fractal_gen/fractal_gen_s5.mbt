///| Estimate fractal box-counting dimension from count samples. / 由计数样本估计分形盒计数维数。
pub fn fractal_dimension_box(counts : Array[(Double, Int)]) -> Double {
  if counts.length() < 2 {
    return 0.0
  }
  let p1 = counts[0]
  let p2 = counts[counts.length() - 1]
  let log_n1 = @math.ln(p1.1.to_double())
  let log_n2 = @math.ln(p2.1.to_double())
  let log_e1 = @math.ln(1.0 / p1.0)
  let log_e2 = @math.ln(1.0 / p2.0)
  (log_n2 - log_n1) / (log_e2 - log_e1)
}


///| Compute Koch curve length at given iteration from base length. / 由基础长度计算给定迭代次数的 Koch 曲线长度。
pub fn koch_curve_length(iteration : Int, base_length : Double) -> Double {
  base_length * @math.pow(4.0 / 3.0, iteration.to_double())
}
