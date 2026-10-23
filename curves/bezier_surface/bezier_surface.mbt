/// |
/// # Bézier Surfaces
/// # 贝塞尔曲面
///
/// Tensor product Bézier surfaces using Bernstein polynomials and de Casteljau evaluation.
/// 使用伯恩斯坦多项式和 de Casteljau 求值的张量积贝塞尔曲面。
///
/// ## Complexity: O(m × n) per evaluation
/// ## 复杂度: 每次求值 O(m × n)

///|
/// |
/// Compute Bernstein polynomial B(i, n, t).
/// 计算伯恩斯坦多项式 B(i, n, t)。
///
/// B(i, n, t) = C(n, i) * t^i * (1-t)^(n-i)
pub fn bernstein(i : Int32, n : Int32, t : Double) -> Double {
  let mut coeff = 1.0
  for k in 0..<i {
    coeff *= (n - k).to_double() / (k + 1).to_double()
  }
  let mut ti = 1.0
  for _ in 0..<i {
    ti *= t
  }
  let mut tni = 1.0
  for _ in 0..<(n - i) {
    tni *= 1.0 - t
  }
  coeff * ti * tni
}

///|
/// |
/// Evaluate a Bézier curve using de Casteljau algorithm.
/// 使用 de Casteljau 算法求值贝塞尔曲线。
///
/// # Arguments / 参数
/// - `control_pts`: control points (x, y, z) / 控制点
/// - `t`: parameter [0, 1] / 参数
pub fn bezier_curve(
  control_pts : Array[(Double, Double, Double)],
  t : Double,
) -> (Double, Double, Double) {
  let n = control_pts.length()
  let pts : Array[(Double, Double, Double)] = []
  for p in control_pts {
    pts.push(p)
  }
  for r in 1..<n {
    for i in 0..<(n - r) {
      let (x0, y0, z0) = pts[i]
      let (x1, y1, z1) = pts[i + 1]
      pts[i] = (
        (1.0 - t) * x0 + t * x1,
        (1.0 - t) * y0 + t * y1,
        (1.0 - t) * z0 + t * z1,
      )
      ignore((x0, y0, z0, x1, y1, z1))
    }
  }
  pts[0]
}

///|
/// |
/// Evaluate a tensor product Bézier surface at (u, v).
/// 在 (u, v) 处求值张量积贝塞尔曲面。
///
/// # Arguments / 参数
/// - `control_net`: m × n grid of control points / 控制网格
/// - `u`, `v`: parameters [0, 1] / 参数
pub fn bezier_surface(
  control_net : Array[Array[(Double, Double, Double)]],
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  let m = control_net.length()
  let n = control_net[0].length()
  let mut x = 0.0
  let mut y = 0.0
  let mut z = 0.0
  for i in 0..<m {
    let bu = bernstein(i, m - 1, u)
    for j in 0..<n {
      let bv = bernstein(j, n - 1, v)
      let (px, py, pz) = control_net[i][j]
      x += bu * bv * px
      y += bu * bv * py
      z += bu * bv * pz
    }
  }
  (x, y, z)
}

///|
/// |
/// Evaluate a Bézier surface using de Casteljau in both directions.
/// 在两个方向上使用 de Casteljau 求值贝塞尔曲面。
///
/// # Arguments / 参数
/// - `control_net`: m × n grid of control points / 控制网格
/// - `u`, `v`: parameters [0, 1] / 参数
pub fn bezier_surface_decasteljau(
  control_net : Array[Array[(Double, Double, Double)]],
  u : Double,
  v : Double,
) -> (Double, Double, Double) {
  let m = control_net.length()
  let curves : Array[(Double, Double, Double)] = []
  for i in 0..<m {
    curves.push(bezier_curve(control_net[i], v))
  }
  bezier_curve(curves, u)
}

///|
/// |
/// Compute the derivative of a Bézier curve (hodograph).
/// 计算贝塞尔曲线的导数（速端曲线）。
///
/// # Arguments / 参数
/// - `control_pts`: control points / 控制点
/// - `t`: parameter / 参数
pub fn bezier_curve_derivative(
  control_pts : Array[(Double, Double, Double)],
  t : Double,
) -> (Double, Double, Double) {
  let n = control_pts.length() - 1
  if n == 0 {
    return (0.0, 0.0, 0.0)
  }
  let deriv_ctrl : Array[(Double, Double, Double)] = []
  for i in 0..<n {
    let (x0, y0, z0) = control_pts[i]
    let (x1, y1, z1) = control_pts[i + 1]
    deriv_ctrl.push(
      (
        n.to_double() * (x1 - x0),
        n.to_double() * (y1 - y0),
        n.to_double() * (z1 - z0),
      ),
    )
  }
  bezier_curve(deriv_ctrl, t)
}

///|
/// |
/// Elevate the degree of a Bézier curve by one.
/// 将贝塞尔曲线的次数提升一阶。
///
/// # Arguments / 参数
/// - `control_pts`: original control points / 原始控制点
///
/// Returns the new control points with degree n+1.
/// 返回次数为 n+1 的新控制点。
pub fn bezier_degree_elevate(
  control_pts : Array[(Double, Double, Double)],
) -> Array[(Double, Double, Double)] {
  let n = control_pts.length()
  let result : Array[(Double, Double, Double)] = []
  result.push(control_pts[0])
  for i in 1..<n {
    let (x0, y0, z0) = control_pts[i - 1]
    let (x1, y1, z1) = control_pts[i]
    let alpha = i.to_double() / n.to_double()
    result.push(
      (
        alpha * x0 + (1.0 - alpha) * x1,
        alpha * y0 + (1.0 - alpha) * y1,
        alpha * z0 + (1.0 - alpha) * z1,
      ),
    )
  }
  result.push(control_pts[n - 1])
  result
}
