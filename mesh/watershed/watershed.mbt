///|
/// Watershed result: label for each cell (0 = unlabeled). / 分水岭结果：每个像元的标签（0 = 未标记）。
pub struct WatershedResult {
  cols : Int32
  rows : Int32
  labels : Array[Int32]
}

///|
/// Number of columns. / 列数。
pub fn WatershedResult::cols(r : WatershedResult) -> Int32 {
  r.cols
}

///|
/// Number of rows. / 行数。
pub fn WatershedResult::rows(r : WatershedResult) -> Int32 {
  r.rows
}

///|
/// Get label at (col, row). / 获取 (col, row) 处的标签。
pub fn WatershedResult::get(
  r : WatershedResult,
  col : Int32,
  row : Int32,
) -> Int32 {
  if col < 0 || col >= r.cols || row < 0 || row >= r.rows {
    return 0
  }
  r.labels[row * r.cols + col]
}

///|
/// Marker-driven watershed segmentation. / 标记驱动的分水岭分割。
/// dem: elevation grid (rows x cols), markers: marker labels (0 = no marker). / dem: 高程网格，markers: 标记标签（0 = 无标记）。
/// Floods from markers following steepest descent. / 从标记出发沿最陡下降方向淹没。
pub fn marker_watershed(
  cols : Int32,
  rows : Int32,
  dem : Array[Double],
  markers : Array[Int32],
) -> WatershedResult {
  let n = cols * rows
  let labels = Array::make(n, 0)
  // Initialize with markers
  for i in 0..<n {
    if markers[i] != 0 {
      labels[i] = markers[i]
    }
  }
  // Priority flood: process cells from lowest elevation, BFS-like
  // Build index list sorted by elevation
  let indices : Array[Int32] = []
  for i in 0..<n {
    indices.push(i)
  }
  // Simple selection sort by elevation (for small grids)
  for i in 0..<n {
    let mut min_idx = i
    for j in (i + 1)..<n {
      if dem[indices[j]] < dem[indices[min_idx]] {
        min_idx = j
      }
    }
    let tmp = indices[i]
    indices[i] = indices[min_idx]
    indices[min_idx] = tmp
  }
  // Process cells in elevation order: propagate label from lowest labeled neighbor
  for idx in indices {
    if labels[idx] != 0 {
      continue
    }
    let col = idx % cols
    let row = idx / cols
    let mut best_label = 0
    let mut best_elev = 0.0
    let mut has_best = false
    // Check 4 neighbors
    let neighbors = [
      (col - 1, row),
      (col + 1, row),
      (col, row - 1),
      (col, row + 1),
    ]
    for nb in neighbors {
      let (nc, nr) = nb
      if nc >= 0 && nc < cols && nr >= 0 && nr < rows {
        let ni = nr * cols + nc
        if labels[ni] != 0 {
          if !has_best || dem[ni] < best_elev {
            best_elev = dem[ni]
            best_label = labels[ni]
            has_best = true
          }
        }
      }
    }
    labels[idx] = best_label
  }
  { cols, rows, labels, }
}

///|
/// Compute drainage direction (D8) at each cell: 0-7 for 8 directions, -1 for pit. / 各像元的 D8 排水方向：0-7 表示 8 个方向，-1 表示洼地。
pub fn d8_flow_directions(
  cols : Int32,
  rows : Int32,
  dem : Array[Double],
) -> Array[Int32] {
  let n = cols * rows
  let dirs = Array::make(n, -1)
  let dx = [1, 1, 0, -1, -1, -1, 0, 1]
  let dy = [0, 1, 1, 1, 0, -1, -1, -1]
  for i in 0..<n {
    let col = i % cols
    let row = i / cols
    let mut max_drop = 0.0
    let mut best_dir = -1
    for d in 0..<8 {
      let nc = col + dx[d]
      let nr = row + dy[d]
      if nc >= 0 && nc < cols && nr >= 0 && nr < rows {
        let ni = nr * cols + nc
        let drop = dem[i] - dem[ni]
        if drop > max_drop {
          max_drop = drop
          best_dir = d
        }
      }
    }
    dirs[i] = best_dir
  }
  dirs
}

///|
/// Count catchment basin cells for each label. / 统计各标签的汇水盆地像元数。
pub fn basin_cell_counts(r : WatershedResult) -> Array[(Int32, Int32)] {
  // Collect unique labels
  let unique_labels : Array[Int32] = []
  for label in r.labels {
    if label != 0 {
      let mut found = false
      for ul in unique_labels {
        if ul == label {
          found = true
          break
        }
      }
      if !found {
        unique_labels.push(label)
      }
    }
  }
  let result : Array[(Int32, Int32)] = []
  for ul in unique_labels {
    let mut count = 0
    for label in r.labels {
      if label == ul {
        count += 1
      }
    }
    result.push((ul, count))
  }
  result
}

///|
/// Fill depressions (pits) in DEM to ensure drainage. / 填充 DEM 中的洼地以确保排水。
pub fn fill_depressions(
  cols : Int32,
  rows : Int32,
  dem : Array[Double],
) -> Array[Double] {
  let n = cols * rows
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = dem[i]
  }
  let dx = [1, 0, -1, 0, 1, 1, -1, -1]
  let dy = [0, 1, 0, -1, 1, -1, 1, -1]
  let mut changed = true
  let mut iter = 0
  while changed && iter < n {
    changed = false
    for i in 0..<n {
      let col = i % cols
      let row = i / cols
      // Skip outer-edge cells that can drain off the grid
      let on_col_edge = cols > 1 && (col == 0 || col == cols - 1)
      let on_row_edge = rows > 1 && (row == 0 || row == rows - 1)
      if on_col_edge || on_row_edge {
        continue
      }
      let mut min_neighbor = 0.0
      let mut has_neighbor = false
      for d in 0..<8 {
        let nc = col + dx[d]
        let nr = row + dy[d]
        if nc >= 0 && nc < cols && nr >= 0 && nr < rows {
          let ni = nr * cols + nc
          if !has_neighbor || result[ni] < min_neighbor {
            min_neighbor = result[ni]
            has_neighbor = true
          }
        }
      }
      if has_neighbor && result[i] < min_neighbor {
        result[i] = min_neighbor
        changed = true
      }
    }
    iter += 1
  }
  result
}
