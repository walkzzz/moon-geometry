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
