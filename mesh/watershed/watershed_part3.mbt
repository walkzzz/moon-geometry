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
