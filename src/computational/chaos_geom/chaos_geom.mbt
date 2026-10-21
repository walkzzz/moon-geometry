///| Chaos Geometry | 混沌几何
///| Strange attractors, Lyapunov exponents, bifurcation geometry
///| 奇怪吸引子、Lyapunov 指数、分岔几何

///| Perform one step of the Lorenz system integration. / 执行一步 Lorenz 系统积分。
pub fn lorenz_step(x : Double, y : Double, z : Double, sigma : Double, rho : Double, beta : Double, dt : Double) -> (Double, Double, Double) {
  let dx = sigma * (y - x) * dt
  let dy = (x * (rho - z) - y) * dt
  let dz = (x * y - beta * z) * dt
  (x + dx, y + dy, z + dz)
}

///| Compute the Lyapunov exponent for the logistic map. / 计算逻辑斯蒂映射的 Lyapunov 指数。
pub fn lyapunov_exponent_logistic(r : Double, x0 : Double, n : Int) -> Double {
  let mut x = x0
  let mut sum = 0.0
  for _ in 0..<n {
    let deriv = r * (1.0 - 2.0 * x)
    if deriv.abs() > 1.0e-10 {
      sum += @math.ln(deriv.abs())
    }
    x = r * x * (1.0 - x)
  }
  sum / n.to_double()
}

///| Apply the Hénon map transformation. / 应用 Hénon 映射变换。
pub fn henon_map(x : Double, y : Double, a : Double, b : Double) -> (Double, Double) {
  (1.0 - a * x * x + y, b * x)
}

///| Return the bifurcation onset point of the logistic map. / 返回逻辑斯蒂映射的分岔起始点。
pub fn bifurcation_point_logistic() -> Double {
  3.569945672
}

///| Estimate the Kaplan-Yorke dimension of a strange attractor. / 估计奇怪吸引子的 Kaplan-Yorke 维数。
pub fn strange_attractor_dimension(lyapunov : Array[Double]) -> Double {
  let mut sum_pos = 0.0
  let mut sum_all = 0.0
  for l in lyapunov {
    sum_all += l
    if l > 0.0 {
      sum_pos += l
    }
  }
  if sum_pos < 1.0e-10 {
    0.0
  } else {
    sum_all / sum_pos
  }
}
