///| Chaos Geometry | 混沌几何
///| Strange attractors, Lyapunov exponents, bifurcation geometry
///| 奇怪吸引子、Lyapunov 指数、分岔几何

pub fn lorenz_step(x : Double, y : Double, z : Double, sigma : Double, rho : Double, beta : Double, dt : Double) -> (Double, Double, Double) {
  let dx = sigma * (y - x) * dt
  let dy = (x * (rho - z) - y) * dt
  let dz = (x * y - beta * z) * dt
  (x + dx, y + dy, z + dz)
}

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

pub fn henon_map(x : Double, y : Double, a : Double, b : Double) -> (Double, Double) {
  (1.0 - a * x * x + y, b * x)
}

pub fn bifurcation_point_logistic() -> Double {
  3.569945672
}

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
