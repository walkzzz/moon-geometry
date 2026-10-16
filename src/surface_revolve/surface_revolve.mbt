/// |
/// # Surface of Revolution
/// # 旋转曲面
///
/// Create surfaces by revolving a profile curve around an axis.
/// 通过绕轴旋转轮廓曲线创建曲面。
///
/// ## Complexity: O(n × m) for mesh generation
/// ## 复杂度: 网格生成 O(n × m)

/// |
/// Revolve a profile curve around the Z-axis.
/// 绕 Z 轴旋转轮廓曲线。
///
/// # Arguments / 参数
/// - `profile`: profile points (r, z) where r is radius, z is height / 轮廓点 (r, z)
/// - `n_segments`: number of angular segments / 角度分段数
///
/// Returns (vertices, faces) of the revolution surface mesh.
/// 返回旋转曲面网格的 (顶点, 面)。
pub fn revolve_z(
  profile : Array[(Double, Double)],
  n_segments : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  let vertices : Array[(Double, Double, Double)] = []
  let faces : Array[(Int, Int, Int)] = []
  let n_profile = profile.length()
  for i in 0..<n_profile {
    let (r, z) = profile[i]
    for j in 0..<n_segments {
      let angle = 2.0 * 3.14159265358979323846 * j.to_double() / n_segments.to_double()
      let x = r * @math.cos(angle)
      let y = r * @math.sin(angle)
      vertices.push((x, y, z))
    }
  }
  for i in 0..<(n_profile - 1) {
    for j in 0..<n_segments {
      let j_next = (j + 1) % n_segments
      let v0 = i * n_segments + j
      let v1 = i * n_segments + j_next
      let v2 = (i + 1) * n_segments + j_next
      let v3 = (i + 1) * n_segments + j
      faces.push((v0, v1, v3))
      faces.push((v1, v2, v3))
    }
  }
  (vertices, faces)
}

/// |
/// Revolve a profile curve around the X-axis.
/// 绕 X 轴旋转轮廓曲线。
pub fn revolve_x(
  profile : Array[(Double, Double)],
  n_segments : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  let vertices : Array[(Double, Double, Double)] = []
  let faces : Array[(Int, Int, Int)] = []
  let n_profile = profile.length()
  for i in 0..<n_profile {
    let (r, x) = profile[i]
    for j in 0..<n_segments {
      let angle = 2.0 * 3.14159265358979323846 * j.to_double() / n_segments.to_double()
      let y = r * @math.cos(angle)
      let z = r * @math.sin(angle)
      vertices.push((x, y, z))
    }
  }
  for i in 0..<(n_profile - 1) {
    for j in 0..<n_segments {
      let j_next = (j + 1) % n_segments
      let v0 = i * n_segments + j
      let v1 = i * n_segments + j_next
      let v2 = (i + 1) * n_segments + j_next
      let v3 = (i + 1) * n_segments + j
      faces.push((v0, v1, v3))
      faces.push((v1, v2, v3))
    }
  }
  (vertices, faces)
}

/// |
/// Revolve a profile curve around the Y-axis.
/// 绕 Y 轴旋转轮廓曲线。
pub fn revolve_y(
  profile : Array[(Double, Double)],
  n_segments : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  let vertices : Array[(Double, Double, Double)] = []
  let faces : Array[(Int, Int, Int)] = []
  let n_profile = profile.length()
  for i in 0..<n_profile {
    let (r, y) = profile[i]
    for j in 0..<n_segments {
      let angle = 2.0 * 3.14159265358979323846 * j.to_double() / n_segments.to_double()
      let x = r * @math.cos(angle)
      let z = r * @math.sin(angle)
      vertices.push((x, y, z))
    }
  }
  for i in 0..<(n_profile - 1) {
    for j in 0..<n_segments {
      let j_next = (j + 1) % n_segments
      let v0 = i * n_segments + j
      let v1 = i * n_segments + j_next
      let v2 = (i + 1) * n_segments + j_next
      let v3 = (i + 1) * n_segments + j
      faces.push((v0, v1, v3))
      faces.push((v1, v2, v3))
    }
  }
  (vertices, faces)
}

/// |
/// Evaluate a point on a revolution surface (around Z-axis) at angle θ.
/// 在角度 θ 处求值旋转曲面（绕 Z 轴）上的点。
///
/// # Arguments / 参数
/// - `r`: radius at profile point / 轮廓点处的半径
/// - `z`: height at profile point / 轮廓点处的高度
/// - `theta`: rotation angle / 旋转角度
pub fn revolve_point_z(
  r : Double,
  z : Double,
  theta : Double,
) -> (Double, Double, Double) {
  (r * @math.cos(theta), r * @math.sin(theta), z)
}

/// |
/// Compute surface area of a revolution surface (around Z-axis).
/// 计算旋转曲面（绕 Z 轴）的表面积。
///
/// Uses the formula: A = 2π ∫ r ds, where ds = √(dr² + dz²).
/// 使用公式: A = 2π ∫ r ds, 其中 ds = √(dr² + dz²)。
pub fn revolve_area_z(profile : Array[(Double, Double)]) -> Double {
  let mut area = 0.0
  for i in 0..<(profile.length() - 1) {
    let (r1, z1) = profile[i]
    let (r2, z2) = profile[i + 1]
    let dr = r2 - r1
    let dz = z2 - z1
    let ds = (dr * dr + dz * dz).sqrt()
    let r_avg = (r1 + r2) / 2.0
    area += 2.0 * 3.14159265358979323846 * r_avg * ds
  }
  area
}