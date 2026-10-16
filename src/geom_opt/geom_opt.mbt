///| Geometric Optimization | 几何优化
///| Geometric programming, convex optimization on geometric domains
///| 几何规划、几何域上的凸优化

pub fn smallest_enclosing_circle_radius(points : Array[(Double, Double)]) -> Double {
  let mut max_r = 0.0
  for i in 0..<points.length() {
    for j in (i + 1)..<points.length() {
      let dx = points[j].0 - points[i].0
      let dy = points[j].1 - points[i].1
      let d = (dx * dx + dy * dy).sqrt() / 2.0
      if d > max_r {
        max_r = d
      }
    }
  }
  max_r
}

pub fn minimum_width_rectangle(points : Array[(Double, Double)]) -> Double {
  let mut min_w = 1.0e18
  for i in 0..<points.length() {
    for j in (i + 1)..<points.length() {
      let dx = points[j].0 - points[i].0
      let dy = points[j].1 - points[i].1
      let len = (dx * dx + dy * dy).sqrt()
      if len >= 1.0e-10 {
        let mut max_d = 0.0
        for k in 0..<points.length() {
          let dist = ((points[k].0 - points[i].0) * dy - (points[k].1 - points[i].1) * dx).abs() / len
          if dist > max_d {
            max_d = dist
          }
        }
        if max_d < min_w {
          min_w = max_d
        }
      }
    }
  }
  min_w
}

pub fn geometric_mean(values : Array[Double]) -> Double {
  let mut log_sum = 0.0
  for v in values {
    log_sum += @math.ln(v)
  }
  @math.exp(log_sum / values.length().to_double())
}

pub fn fermat_point_approx(x_a : Double, y_a : Double, x_b : Double, y_b : Double, x_c : Double, y_c : Double) -> (Double, Double) {
  ((x_a + x_b + x_c) / 3.0, (y_a + y_b + y_c) / 3.0)
}
