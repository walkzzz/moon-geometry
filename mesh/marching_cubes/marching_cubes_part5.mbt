///|
/// Count active (non-empty) voxel configurations. / 统计活动（非空）体素配置数。
pub fn count_active_configs(grid : McGrid, isolevel : Double) -> Int32 {
  let mut count = 0
  for k in 0..<(grid.nz - 1) {
    for j in 0..<(grid.ny - 1) {
      for i in 0..<(grid.nx - 1) {
        let mut idx = 0
        for b in 0..<8 {
          let (bi, bj, bk) = corner_offset(b, i, j, k)
          if McGrid::get(grid, bi, bj, bk) < isolevel {
            idx = idx | (1 << b)
          }
        }
        if idx != 0 && idx != 255 {
          count += 1
        }
      }
    }
  }
  count
}

///|
fn corner_offset(
  b : Int32,
  i : Int32,
  j : Int32,
  k : Int32,
) -> (Int32, Int32, Int32) {
  match b {
    0 => (i, j, k)
    1 => (i + 1, j, k)
    2 => (i + 1, j + 1, k)
    3 => (i, j + 1, k)
    4 => (i, j, k + 1)
    5 => (i + 1, j, k + 1)
    6 => (i + 1, j + 1, k + 1)
    7 => (i, j + 1, k + 1)
    _ => (i, j, k)
  }
}
