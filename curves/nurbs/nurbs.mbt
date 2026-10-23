/// |
/// # NURBS Curves and Surfaces
/// # NURBS 曲线与曲面
///
/// Non-Uniform Rational B-Spline evaluation using Cox-de Boor recursion.
/// 使用 Cox-de Boor 递推的非均匀有理 B 样条求值。
///
/// ## Complexity: O(p²) per basis evaluation
/// ## 复杂度: 每次基函数求值 O(p²)

///|
/// |
/// Compute B-spline basis function N(i, p, u) using Cox-de Boor recursion.
/// 使用 Cox-de Boor 递推计算 B 样条基函数 N(i, p, u)。
///
/// # Arguments / 参数
/// - `i`: basis index / 基函数索引
/// - `p`: degree / 次数
/// - `u`: parameter / 参数
/// - `knots`: knot vector / 节点向量
pub fn bspline_basis(
  i : Int32,
  p : Int32,
  u : Double,
  knots : Array[Double],
) -> Double {
  if p == 0 {
    if knots[i] <= u && u < knots[i + 1] {
      return 1.0
    }
    return 0.0
  }
  let mut result = 0.0
  let denom1 = knots[i + p] - knots[i]
  if denom1.abs() > 0.0000000001 {
    result += (u - knots[i]) / denom1 * bspline_basis(i, p - 1, u, knots)
  }
  let denom2 = knots[i + p + 1] - knots[i + 1]
  if denom2.abs() > 0.0000000001 {
    result += (knots[i + p + 1] - u) /
      denom2 *
      bspline_basis(i, p - 1, u, knots)
  }
  result
}

///|
/// |
/// Evaluate a B-spline curve at parameter u.
/// 在参数 u 处求值 B 样条曲线。
///
/// # Arguments / 参数
/// - `control_pts`: control points as (x, y, z) tuples / 控制点
/// - `degree`: spline degree / 样条次数
/// - `u`: parameter / 参数
/// - `knots`: knot vector / 节点向量
pub fn bspline_curve_point(
  control_pts : Array[(Double, Double, Double)],
  degree : Int32,
  u : Double,
  knots : Array[Double],
) -> (Double, Double, Double) {
  let n = control_pts.length()
  let mut x = 0.0
  let mut y = 0.0
  let mut z = 0.0
  for i in 0..<n {
    let basis = bspline_basis(i, degree, u, knots)
    let (px, py, pz) = control_pts[i]
    x += basis * px
    y += basis * py
    z += basis * pz
  }
  (x, y, z)
}

///|
/// |
/// Evaluate a NURBS curve at parameter u (rational B-spline).
/// 在参数 u 处求值 NURBS 曲线（有理 B 样条）。
///
/// # Arguments / 参数
/// - `control_pts`: control points / 控制点
/// - `weights`: weight for each control point / 每个控制点的权重
/// - `degree`: spline degree / 样条次数
/// - `u`: parameter / 参数
/// - `knots`: knot vector / 节点向量
pub fn nurbs_curve_point(
  control_pts : Array[(Double, Double, Double)],
  weights : Array[Double],
  degree : Int32,
  u : Double,
  knots : Array[Double],
) -> (Double, Double, Double) {
  let n = control_pts.length()
  let mut nx = 0.0
  let mut ny = 0.0
  let mut nz = 0.0
  let mut dw = 0.0
  for i in 0..<n {
    let bi = bspline_basis(i, degree, u, knots)
    let wi = weights[i]
    let basis = bi * wi
    let (px, py, pz) = control_pts[i]
    nx += basis * px
    ny += basis * py
    nz += basis * pz
    dw += basis
  }
  if dw.abs() < 0.0000000001 {
    return (0.0, 0.0, 0.0)
  }
  (nx / dw, ny / dw, nz / dw)
}

///|
/// |
/// Evaluate a NURBS surface at (u, v).
/// 在 (u, v) 处求值 NURBS 曲面。
///
/// # Arguments / 参数
/// - `control_net`: m × n grid of control points / 控制网格
/// - `weights`: m × n grid of weights / 权重网格
/// - `degree_u`, `degree_v`: degrees in u and v directions / u/v 方向次数
/// - `u`, `v`: parameters / 参数
/// - `knots_u`, `knots_v`: knot vectors / 节点向量
pub fn nurbs_surface_point(
  control_net : Array[Array[(Double, Double, Double)]],
  weights : Array[Array[Double]],
  degree_u : Int32,
  degree_v : Int32,
  u : Double,
  v : Double,
  knots_u : Array[Double],
  knots_v : Array[Double],
) -> (Double, Double, Double) {
  let m = control_net.length()
  let n = control_net[0].length()
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sz = 0.0
  let mut sw = 0.0
  for i in 0..<m {
    let bu = bspline_basis(i, degree_u, u, knots_u)
    for j in 0..<n {
      let bv = bspline_basis(j, degree_v, v, knots_v)
      let w = weights[i][j]
      let basis = bu * bv * w
      let (px, py, pz) = control_net[i][j]
      sx += basis * px
      sy += basis * py
      sz += basis * pz
      sw += basis
    }
  }
  if sw.abs() < 0.0000000001 {
    return (0.0, 0.0, 0.0)
  }
  (sx / sw, sy / sw, sz / sw)
}

///|
/// |
/// Find the knot span index for parameter u.
/// 查找参数 u 所在的节点区间索引。
///
/// # Arguments / 参数
/// - `n`: number of control points - 1 / 控制点数 - 1
/// - `p`: degree / 次数
/// - `u`: parameter / 参数
/// - `knots`: knot vector / 节点向量
pub fn find_span(
  n : Int32,
  p : Int32,
  u : Double,
  knots : Array[Double],
) -> Int32 {
  if u >= knots[n + 1] {
    return n
  }
  if u <= knots[p] {
    return p
  }
  let mut low = p
  let mut high = n + 1
  let mut mid = (low + high) / 2
  while u < knots[mid] || u >= knots[mid + 1] {
    if u < knots[mid] {
      high = mid
    } else {
      low = mid
    }
    mid = (low + high) / 2
  }
  mid
}

///|
/// |
/// Generate uniform clamped knot vector.
/// 生成均匀钳制节点向量。
///
/// # Arguments / 参数
/// - `num_ctrl`: number of control points / 控制点数
/// - `degree`: spline degree / 样条次数
pub fn uniform_knots(num_ctrl : Int32, degree : Int32) -> Array[Double] {
  let n = num_ctrl + degree + 1
  let knots : Array[Double] = []
  for i in 0..<n {
    if i <= degree {
      knots.push(0.0)
    } else if i >= num_ctrl {
      knots.push(1.0)
    } else {
      knots.push((i - degree).to_double() / (num_ctrl - degree).to_double())
    }
  }
  knots
}
