/// |
/// # Surface Reconstruction
/// # 曲面重建
///
/// Reconstruct surfaces from unorganized point clouds.
/// 从无组织点云重建曲面。
///
/// ## Complexity: O(n²) for normal estimation
/// ## 复杂度: 法线估计 O(n²)

///|
/// |
/// Estimate normal at a point using k nearest neighbors.
/// 使用 k 近邻估计点处的法线。
///
/// # Arguments / 参数
/// - `pts`: point cloud / 点云
/// - `idx`: point index / 点索引
/// - `k`: number of neighbors / 近邻数
///
/// Returns estimated normal (nx, ny, nz).
/// 返回估计法线 (nx, ny, nz)。
pub fn estimate_normal(
  pts : Array[(Double, Double, Double)],
  idx : Int32,
  k : Int32,
) -> (Double, Double, Double) {
  let n = pts.length()
  let (px, py, pz) = pts[idx]
  let dists : Array[(Int32, Double)] = []
  for i in 0..<n {
    if i == idx {
      continue
    }
    let (qx, qy, qz) = pts[i]
    let d = (px - qx) * (px - qx) +
      (py - qy) * (py - qy) +
      (pz - qz) * (pz - qz)
    dists.push((i, d))
  }
  dists.sort_by(fn(a, b) {
    let (_, da) = a
    let (_, db) = b
    if da < db {
      -1
    } else if da > db {
      1
    } else {
      0
    }
  })
  let kn = if k < dists.length() { k } else { dists.length() }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  for i in 0..<kn {
    let (ni, _) = dists[i]
    let (qx, qy, qz) = pts[ni]
    cx += qx
    cy += qy
    cz += qz
  }
  cx /= kn.to_double()
  cy /= kn.to_double()
  cz /= kn.to_double()
  let nx = px - cx
  let ny = py - cy
  let nz = pz - cz
  let len = (nx * nx + ny * ny + nz * nz).sqrt()
  if len.abs() < 0.0000000001 {
    return (0.0, 0.0, 1.0)
  }
  (nx / len, ny / len, nz / len)
}

///|
/// |
/// Reconstruct a triangle mesh from a point cloud using ball pivoting (simplified).
/// 使用球枢轴法（简化版）从点云重建三角网格。
///
/// # Arguments / 参数
/// - `pts`: point cloud / 点云
/// - `radius`: ball radius / 球半径
///
/// Returns (vertices, faces) of the reconstructed mesh.
/// 返回重建网格的 (顶点, 面)。
pub fn ball_pivot_reconstruct(
  pts : Array[(Double, Double, Double)],
  radius : Double,
) -> (Array[(Double, Double, Double)], Array[(Int32, Int32, Int32)]) {
  let n = pts.length()
  let faces : Array[(Int32, Int32, Int32)] = []
  for i in 0..<n {
    for j in (i + 1)..<n {
      let (xi, yi, zi) = pts[i]
      let (xj, yj, zj) = pts[j]
      let dij = ((xi - xj) * (xi - xj) +
      (yi - yj) * (yi - yj) +
      (zi - zj) * (zi - zj)).sqrt()
      if dij > 2.0 * radius || dij < 0.0000000001 {
        continue
      }
      for k in (j + 1)..<n {
        let (xk, yk, zk) = pts[k]
        let dik = ((xi - xk) * (xi - xk) +
        (yi - yk) * (yi - yk) +
        (zi - zk) * (zi - zk)).sqrt()
        let djk = ((xj - xk) * (xj - xk) +
        (yj - yk) * (yj - yk) +
        (zj - zk) * (zj - zk)).sqrt()
        if dik > 2.0 * radius || djk > 2.0 * radius {
          continue
        }
        faces.push((i, j, k))
      }
    }
  }
  (pts, faces)
}

///|
/// |
/// Compute signed distance from a point to a triangle mesh (simplified: min distance).
/// 计算点到三角网格的有符号距离（简化: 最小距离）。
///
/// # Arguments / 参数
/// - `pt`: query point / 查询点
/// - `vertices`: mesh vertices / 网格顶点
/// - `faces`: mesh faces / 网格面
pub fn distance_to_mesh(
  pt : (Double, Double, Double),
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int32, Int32, Int32)],
) -> Double {
  let (px, py, pz) = pt
  let mut min_d = 1000000000000000000.0
  for face in faces {
    let (i, j, k) = face
    let (x1, y1, z1) = vertices[i]
    let (x2, y2, z2) = vertices[j]
    let (x3, y3, z3) = vertices[k]
    let cx = (x1 + x2 + x3) / 3.0
    let cy = (y1 + y2 + y3) / 3.0
    let cz = (z1 + z2 + z3) / 3.0
    let d = ((px - cx) * (px - cx) +
    (py - cy) * (py - cy) +
    (pz - cz) * (pz - cz)).sqrt()
    if d < min_d {
      min_d = d
    }
  }
  min_d
}
