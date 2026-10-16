/// |
/// # Sweep Surfaces
/// # 扫掠曲面
///
/// Sweep a profile curve along a path curve to create a surface.
/// 沿路径曲线扫掠轮廓曲线以创建曲面。
///
/// ## Complexity: O(n × m) for mesh generation
/// ## 复杂度: 网格生成 O(n × m)

/// |
/// Sweep a profile curve along a path.
/// 沿路径扫掠轮廓曲线。
///
/// # Arguments / 参数
/// - `profile`: profile points (x, y) in local coordinates / 局部坐标中的轮廓点
/// - `path`: path points (x, y, z) in world coordinates / 世界坐标中的路径点
/// - `n_path`: number of path segments / 路径分段数
///
/// Returns (vertices, faces) of the sweep surface mesh.
/// 返回扫掠曲面网格的 (顶点, 面)。
pub fn sweep_surface(
  profile : Array[(Double, Double)],
  path : Array[(Double, Double, Double)],
) -> (Array[(Double, Double, Double)], Array[(Int, Int, Int)]) {
  let vertices : Array[(Double, Double, Double)] = []
  let faces : Array[(Int, Int, Int)] = []
  let n_profile = profile.length()
  let n_path = path.length()
  for i in 0..<n_path {
    let (px, py, pz) = path[i]
    let mut tx = 0.0
    let mut ty = 0.0
    let mut tz = 0.0
    if i < n_path - 1 {
      let (nx, ny, nz) = path[i + 1]
      tx = nx - px
      ty = ny - py
      tz = nz - pz
    } else if i > 0 {
      let (ppx, ppy, ppz) = path[i - 1]
      tx = px - ppx
      ty = py - ppy
      tz = pz - ppz
    }
    let tlen = (tx * tx + ty * ty + tz * tz).sqrt()
    if tlen.abs() < 0.0000000001 {
      tx = 0.0
      ty = 0.0
      tz = 1.0
    } else {
      tx /= tlen
      ty /= tlen
      tz /= tlen
    }
    let mut bx = 1.0
    let mut by = 0.0
    let mut bz = 0.0
    let dot = bx * tx + by * ty + bz * tz
    bx -= dot * tx
    by -= dot * ty
    bz -= dot * tz
    let blen = (bx * bx + by * by + bz * bz).sqrt()
    if blen.abs() < 0.0000000001 {
      bx = 0.0
      by = 1.0
      bz = 0.0
    } else {
      bx /= blen
      by /= blen
      bz /= blen
    }
    let nxx = ty * bz - tz * by
    let nyy = tz * bx - tx * bz
    let nzz = tx * by - ty * bx
    for j in 0..<n_profile {
      let (fx, fy) = profile[j]
      let vx = px + fx * bx + fy * nxx
      let vy = py + fx * by + fy * nyy
      let vz = pz + fx * bz + fy * nzz
      vertices.push((vx, vy, vz))
    }
  }
  for i in 0..<(n_path - 1) {
    for j in 0..<(n_profile - 1) {
      let v0 = i * n_profile + j
      let v1 = i * n_profile + j + 1
      let v2 = (i + 1) * n_profile + j + 1
      let v3 = (i + 1) * n_profile + j
      faces.push((v0, v1, v3))
      faces.push((v1, v2, v3))
    }
  }
  (vertices, faces)
}

/// |
/// Evaluate a point on a sweep surface at (s, t).
/// 在 (s, t) 处求值扫掠曲面上的点。
///
/// # Arguments / 参数
/// - `profile_fn`: profile function (t) -> (x, y) / 轮廓函数
/// - `path_fn`: path function (s) -> (x, y, z) / 路径函数
/// - `s`, `t`: parameters / 参数
pub fn sweep_point(
  profile_fn : (Double) -> (Double, Double),
  path_fn : (Double) -> (Double, Double, Double),
  s : Double,
  t : Double,
) -> (Double, Double, Double) {
  let (px, py, pz) = path_fn(s)
  let (fx, fy) = profile_fn(t)
  (px + fx, py + fy, pz)
}

/// |
/// Compute approximate surface area of a sweep surface.
/// 计算扫掠曲面的近似表面积。
///
/// # Arguments / 参数
/// - `profile`: profile points / 轮廓点
/// - `path`: path points / 路径点
pub fn sweep_area(
  profile : Array[(Double, Double)],
  path : Array[(Double, Double, Double)],
) -> Double {
  let mut area = 0.0
  let n_profile = profile.length()
  let n_path = path.length()
  for i in 0..<(n_path - 1) {
    let (px1, py1, pz1) = path[i]
    let (px2, py2, pz2) = path[i + 1]
    let dx = px2 - px1
    let dy = py2 - py1
    let dz = pz2 - pz1
    let dl = (dx * dx + dy * dy + dz * dz).sqrt()
    let mut perimeter = 0.0
    for j in 0..<(n_profile - 1) {
      let (x1, y1) = profile[j]
      let (x2, y2) = profile[j + 1]
      perimeter += ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)).sqrt()
    }
    area += perimeter * dl
  }
  area
}