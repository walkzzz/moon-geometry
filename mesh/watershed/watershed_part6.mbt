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
