/// |
/// # Trimmed Surfaces
/// # 裁剪曲面
///
/// Trim a parametric surface using boundary (trimming) curves in parameter space.
/// 使用参数空间中的边界（裁剪）曲线裁剪参数曲面。
///
/// ## Representation: trimming curves in (u, v) parameter space
/// ## 表示: (u, v) 参数空间中的裁剪曲线

/// |
/// Check if a parameter point (u, v) is inside a trimming loop.
/// 检查参数点 (u, v) 是否在裁剪环内。
///
/// Uses ray casting algorithm in parameter space.
/// 在参数空间中使用射线投射算法。
///
/// # Arguments / 参数
/// - `u`, `v`: parameter point / 参数点
/// - `trim_loop`: trimming loop as array of (u, v) points / 裁剪环
pub fn is_inside_trim(
  u : Double,
  v : Double,
  trim_loop : Array[(Double, Double)],
) -> Bool {
  let n = trim_loop.length()
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let (ui, vi) = trim_loop[i]
    let (uj, vj) = trim_loop[j]
    if (vi < v && vj >= v) || (vj < v && vi >= v) {
      if ui + (v - vi) / (vj - vi) * (uj - ui) < u {
        inside = !inside
      }
    }
    j = i
  }
  inside
}

/// |
/// Check if a parameter point (u, v) is in the valid (untrimmed) region.
/// 检查参数点 (u, v) 是否在有效（未裁剪）区域。
///
/// # Arguments / 参数
/// - `u`, `v`: parameter point / 参数点
/// - `outer`: outer boundary loop / 外边界环
/// - `inner`: array of inner trimming loops / 内裁剪环数组
pub fn is_in_valid_region(
  u : Double,
  v : Double,
  outer : Array[(Double, Double)],
  inner : Array[Array[(Double, Double)]],
) -> Bool {
  if !is_inside_trim(u, v, outer) {
    return false
  }
  for trim_loop in inner {
    if is_inside_trim(u, v, trim_loop) {
      return false
    }
  }
  true
}

/// |
/// Generate a trimmed surface mesh by filtering grid points.
/// 通过过滤网格点生成裁剪曲面网格。
///
/// # Arguments / 参数
/// - `surface`: surface function S(u,v) / 曲面函数
/// - `outer`: outer boundary in parameter space / 参数空间外边界
/// - `inner`: inner trimming loops / 内裁剪环
/// - `n_u`, `n_v`: grid resolution / 网格分辨率
///
/// Returns (vertices, faces) of the trimmed surface mesh.
/// 返回裁剪曲面网格的 (顶点, 面)。
pub fn trimmed_mesh(
  surface : (Double, Double) -> (Double, Double, Double),
  outer : Array[(Double, Double)],
  inner : Array[Array[(Double, Double)]],
  n_u : Int,
  n_v : Int,
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  let (u_min, v_min) = outer[0]
  let mut u_max = u_min
  let mut v_max = v_min
  for p in outer {
    let (u, v) = p
    if u > u_max {
      u_max = u
    }
    if v > v_max {
      v_max = v
    }
  }
  let vertices : Array[(Double, Double, Double)] = []
  let faces : Array[(Int, Int, Int)] = []
  let grid : Array[Array[Int]] = []
  for i in 0..<n_u {
    let row : Array[Int] = []
    let u = u_min + (u_max - u_min) * i.to_double() / (n_u - 1).to_double()
    for j in 0..<n_v {
      let v = v_min + (v_max - v_min) * j.to_double() / (n_v - 1).to_double()
      if is_in_valid_region(u, v, outer, inner) {
        let idx = vertices.length()
        vertices.push(surface(u, v))
        row.push(idx)
      } else {
        row.push(-1)
      }
    }
    grid.push(row)
  }
  for i in 0..<(n_u - 1) {
    for j in 0..<(n_v - 1) {
      let v0 = grid[i][j]
      let v1 = grid[i][j + 1]
      let v2 = grid[i + 1][j + 1]
      let v3 = grid[i + 1][j]
      if v0 >= 0 && v1 >= 0 && v2 >= 0 && v3 >= 0 {
        faces.push((v0, v1, v3))
        faces.push((v1, v2, v3))
      }
    }
  }
  (vertices, faces)
}

/// |
/// Compute the trimmed surface area by summing valid triangle areas.
/// 通过累加有效三角形面积计算裁剪曲面面积。
///
/// # Arguments / 参数
/// - `vertices`, `faces`: trimmed mesh / 裁剪网格
pub fn trimmed_area(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int, Int, Int)],
) -> Double {
  let mut area = 0.0
  for face in faces {
    let (i, j, k) = face
    let (x1, y1, z1) = vertices[i]
    let (x2, y2, z2) = vertices[j]
    let (x3, y3, z3) = vertices[k]
    let ux = x2 - x1
    let uy = y2 - y1
    let uz = z2 - z1
    let vx = x3 - x1
    let vy = y3 - y1
    let vz = z3 - z1
    let cx = uy * vz - uz * vy
    let cy = uz * vx - ux * vz
    let cz = ux * vy - uy * vx
    area += 0.5 * (cx * cx + cy * cy + cz * cz).sqrt()
  }
  area
}