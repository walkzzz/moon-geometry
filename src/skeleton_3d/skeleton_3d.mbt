///|
/// # 3D Skeleton (Surface Thinning)
/// # 三维骨架（表面细化）
///
/// Thinning of a 3D voxel grid to extract a skeleton preserving topology.
/// 三维体素网格的细化以提取保持拓扑的骨架。
///
/// ## Complexity: O(iter * nx * ny * nz)
/// ## 复杂度: O(iter * nx * ny * nz)

///|
/// Voxel index in flattened 3D grid. / 展平三维网格中的体素索引。
pub fn voxel_index(
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
) -> Int {
  x + y * nx + z * nx * ny
}

///|
/// Check if coordinates are in bounds. / 检查坐标是否越界。
fn in_bounds(
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  x >= 0 && x < nx && y >= 0 && y < ny && z >= 0 && z < nz
}

///|
/// Count 6-connected object neighbors. / 统计 6-连通对象邻居数。
pub fn count_6_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  let mut count = 0
  let offsets = [(1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)]
  for off in offsets {
    let (dx, dy, dz) = off
    let nx_ = x + dx
    let ny_ = y + dy
    let nz_ = z + dz
    if in_bounds(nx_, ny_, nz_, nx, ny, nz) {
      if voxels[voxel_index(nx_, ny_, nz_, nx, ny)] {
        count += 1
      }
    }
  }
  count
}

///|
/// Count 26-connected object neighbors. / 统计 26-连通对象邻居数。
pub fn count_26_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  let mut count = 0
  for dx in -1..=1 {
    for dy in -1..=1 {
      for dz in -1..=1 {
        if dx == 0 && dy == 0 && dz == 0 {
          continue
        }
        let nx_ = x + dx
        let ny_ = y + dy
        let nz_ = z + dz
        if in_bounds(nx_, ny_, nz_, nx, ny, nz) {
          if voxels[voxel_index(nx_, ny_, nz_, nx, ny)] {
            count += 1
          }
        }
      }
    }
  }
  count
}

///|
/// Check if a voxel is a boundary voxel (has at least one background 6-neighbor).
/// 检查体素是否为边界体素（至少有一个背景 6-邻居）。
pub fn is_boundary(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  let offsets = [(1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)]
  for off in offsets {
    let (dx, dy, dz) = off
    let nx_ = x + dx
    let ny_ = y + dy
    let nz_ = z + dz
    if !in_bounds(nx_, ny_, nz_, nx, ny, nz) {
      return true
    }
    if !voxels[voxel_index(nx_, ny_, nz_, nx, ny)] {
      return true
    }
  }
  false
}

///|
/// Check if a voxel is deletable (simple point, simplified criterion).
/// 检查体素是否可删除（简化简单点判据）。
///
/// A voxel is deletable if it is a boundary voxel, has at least 2 object
/// 6-neighbors (not an endpoint), and fewer than 6 (not fully interior).
/// 体素为边界体素、对象 6-邻居数 >= 2（非端点）且 < 6（非完全内部）时可删除。
fn is_deletable(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  if !is_boundary(voxels, x, y, z, nx, ny, nz) {
    return false
  }
  let n = count_6_neighbors(voxels, x, y, z, nx, ny, nz)
  n >= 2 && n < 6
}

///|
/// 3D skeleton via iterative surface thinning.
/// 通过迭代表面细化提取三维骨架。
///
/// # Arguments / 参数
/// - `voxels`: flattened 3D voxel grid / 展平三维体素网格
/// - `nx`, `ny`, `nz`: grid dimensions / 网格维度
///
/// Returns the thinned skeleton voxel grid.
/// 返回细化后的骨架体素网格。
pub fn skeleton_3d(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  let result : Array[Bool] = []
  for v in voxels {
    result.push(v)
  }
  let mut changed = true
  while changed {
    changed = false
    let to_remove : Array[Int] = []
    for z in 0..<nz {
      for y in 0..<ny {
        for x in 0..<nx {
          let idx = voxel_index(x, y, z, nx, ny)
          if result[idx] {
            if is_deletable(result, x, y, z, nx, ny, nz) {
              to_remove.push(idx)
            }
          }
        }
      }
    }
    if to_remove.length() > 0 {
      changed = true
      for idx in to_remove {
        result[idx] = false
      }
    }
  }
  result
}

///|
/// Count object voxels (volume). / 统计对象体素数（体积）。
pub fn skeleton_volume(voxels : Array[Bool]) -> Int {
  let mut count = 0
  for v in voxels {
    if v {
      count += 1
    }
  }
  count
}

///|
/// Count skeleton endpoints (object voxels with exactly 1 object 6-neighbor).
/// 统计骨架端点（对象 6-邻居数恰为 1 的体素）。
pub fn skeleton_endpoints(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  let mut count = 0
  for z in 0..<nz {
    for y in 0..<ny {
      for x in 0..<nx {
        let idx = voxel_index(x, y, z, nx, ny)
        if voxels[idx] {
          if count_6_neighbors(voxels, x, y, z, nx, ny, nz) == 1 {
            count += 1
          }
        }
      }
    }
  }
  count
}

///|
/// Electric field method skeleton: voxels with high field divergence.
/// 电场法骨架：场散度较高的体素。
///
/// Simplified: keep voxels that are local maxima of the distance transform
/// (approximated by neighbor count). / 简化：保留距离变换局部极大值体素。
pub fn skeleton_field(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  let result : Array[Bool] = Array::make(voxels.length(), false)
  for z in 0..<nz {
    for y in 0..<ny {
      for x in 0..<nx {
        let idx = voxel_index(x, y, z, nx, ny)
        if voxels[idx] {
          let n = count_26_neighbors(voxels, x, y, z, nx, ny, nz)
          if n <= 6 {
            result[idx] = true
          }
        }
      }
    }
  }
  result
}