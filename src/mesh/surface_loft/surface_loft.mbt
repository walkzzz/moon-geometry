/// |
/// # Lofted Surfaces
/// # 放样曲面
///
/// Interpolate between multiple cross-section curves to create a surface.
/// 在多个截面曲线之间插值以创建曲面。
///
/// ## Complexity: O(n × m) for mesh generation
/// ## 复杂度: 网格生成 O(n × m)

/// |
/// Linear lofting between two cross-sections.
/// 两个截面之间的线性放样。
///
/// # Arguments / 参数
/// - `c1`, `c2`: cross-section curves / 截面曲线
/// - `t`: interpolation parameter [0, 1] / 插值参数 [0, 1]
pub fn loft_linear(
  c1 : Array[(Double, Double, Double)],
  c2 : Array[(Double, Double, Double)],
  t : Double,
) -> Array[(Double, Double, Double)] {
  let result : Array[(Double, Double, Double)] = []
  let n = c1.length()
  for i in 0..<n {
    let (x1, y1, z1) = c1[i]
    let (x2, y2, z2) = c2[i]
    result.push((x1 * (1.0 - t) + x2 * t, y1 * (1.0 - t) + y2 * t, z1 * (1.0 - t) + z2 * t))
  }
  result
}

/// |
/// Cubic lofting between four cross-sections.
/// 四个截面之间的三次放样。
///
/// # Arguments / 参数
/// - `c0`, `c1`, `c2`, `c3`: cross-section curves / 截面曲线
/// - `t`: interpolation parameter [0, 1] / 插值参数 [0, 1]
pub fn loft_cubic(
  c0 : Array[(Double, Double, Double)],
  c1 : Array[(Double, Double, Double)],
  c2 : Array[(Double, Double, Double)],
  c3 : Array[(Double, Double, Double)],
  t : Double,
) -> Array[(Double, Double, Double)] {
  let t2 = t * t
  let t3 = t2 * t
  let h0 = 2.0 * t3 - 3.0 * t2 + 1.0
  let h1 = t3 - 2.0 * t2 + t
  let h2 = -2.0 * t3 + 3.0 * t2
  let h3 = t3 - t2
  let result : Array[(Double, Double, Double)] = []
  let n = c0.length()
  for i in 0..<n {
    let (x0, y0, z0) = c0[i]
    let (x1, y1, z1) = c1[i]
    let (x2, y2, z2) = c2[i]
    let (x3, y3, z3) = c3[i]
    result.push((
      h0 * x0 + h1 * x1 + h2 * x2 + h3 * x3,
      h0 * y0 + h1 * y1 + h2 * y2 + h3 * y3,
      h0 * z0 + h1 * z1 + h2 * z2 + h3 * z3,
    ))
  }
  result
}

/// |
/// Generate a lofted surface mesh from multiple cross-sections.
/// 从多个截面生成放样曲面网格。
///
/// # Arguments / 参数
/// - `sections`: array of cross-section curves / 截面曲线数组
/// - `n_subdiv`: subdivisions between sections / 截面间细分 数
///
/// Returns (vertices, faces) of the lofted surface mesh.
/// 返回放样曲面网格的 (顶点, 面)。
pub fn loft_mesh(
  sections : Array[Array[(Double, Double, Double)]],
  n_subdiv : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  let vertices : Array[(Double, Double, Double)] = []
  let faces : Array[(Int, Int, Int)] = []
  let n_sections = sections.length()
  let n_pts = sections[0].length()
  for i in 0..<(n_sections - 1) {
    for k in 0..=n_subdiv {
      let t = k.to_double() / n_subdiv.to_double()
      let layer = loft_linear(sections[i], sections[i + 1], t)
      for p in layer {
        vertices.push(p)
      }
    }
  }
  let n_layers = (n_sections - 1) * (n_subdiv + 1)
  for layer in 0..<(n_layers - 1) {
    for j in 0..<(n_pts - 1) {
      let v0 = layer * n_pts + j
      let v1 = layer * n_pts + j + 1
      let v2 = (layer + 1) * n_pts + j + 1
      let v3 = (layer + 1) * n_pts + j
      faces.push((v0, v1, v3))
      faces.push((v1, v2, v3))
    }
  }
  (vertices, faces)
}

/// |
/// Evaluate a lofted surface at parameter (s, t).
/// 在参数 (s, t) 处求值放样曲面。
///
/// # Arguments / 参数
/// - `sections`: cross-section curves / 截面曲线
/// - `s`: section parameter [0, n-1] / 截面参数
/// - `t`: point parameter within section [0, 1] / 截面内点参数
pub fn loft_point(
  sections : Array[Array[(Double, Double, Double)]],
  s : Double,
  t : Double,
) -> (Double, Double, Double) {
  let n = sections.length()
  let i = s.floor().to_int()
  let idx_low = if i < 0 { 0 } else if i >= n - 1 { n - 2 } else { i }
  let frac = s - idx_low.to_double()
  let n_pts = sections[idx_low].length()
  let j = t.floor().to_int()
  let j_low = if j < 0 { 0 } else if j >= n_pts - 1 { n_pts - 2 } else { j }
  let t_frac = t - j_low.to_double()
  let (x00, y00, z00) = sections[idx_low][j_low]
  let (x01, y01, z01) = sections[idx_low][j_low + 1]
  let (x10, y10, z10) = sections[idx_low + 1][j_low]
  let (x11, y11, z11) = sections[idx_low + 1][j_low + 1]
  let x = (1.0 - frac) * (1.0 - t_frac) * x00 + (1.0 - frac) * t_frac * x01 + frac * (1.0 - t_frac) * x10 + frac * t_frac * x11
  let y = (1.0 - frac) * (1.0 - t_frac) * y00 + (1.0 - frac) * t_frac * y01 + frac * (1.0 - t_frac) * y10 + frac * t_frac * y11
  let z = (1.0 - frac) * (1.0 - t_frac) * z00 + (1.0 - frac) * t_frac * z01 + frac * (1.0 - t_frac) * z10 + frac * t_frac * z11
  (x, y, z)
}