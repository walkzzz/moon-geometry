///|
/// Marching Squares: extract contour segments at a given level. / Marching Squares：提取指定等值层的线段。
pub fn marching_squares(g : ContourGrid, level : Double) -> Array[ContourSegment] {
  let segments : Array[ContourSegment] = []
  for row in 0..<(g.rows - 1) {
    for col in 0..<(g.cols - 1) {
      let v00 = grid_get(g, col, row)
      let v10 = grid_get(g, col + 1, row)
      let v11 = grid_get(g, col + 1, row + 1)
      let v01 = grid_get(g, col, row + 1)
      let mut code = 0
      if v00 > level {
        code += 1
      }
      if v10 > level {
        code += 2
      }
      if v11 > level {
        code += 4
      }
      if v01 > level {
        code += 8
      }
      let x0 = col.to_double()
      let x1 = (col + 1).to_double()
      let y0 = row.to_double()
      let y1 = (row + 1).to_double()
      // Edge interpolation: bottom, right, top, left
      let bot_t = interp_edge(v00, v10, level)
      let right_t = interp_edge(v10, v11, level)
      let top_t = interp_edge(v01, v11, level)
      let left_t = interp_edge(v00, v01, level)
      let bot = (x0 + bot_t, y0)
      let right = (x1, y0 + right_t)
      let top = (x0 + top_t, y1)
      let left = (x0, y0 + left_t)
      let segs = match code {
        0 | 15 => []
        1 | 14 => [(left, bot)]
        2 | 13 => [(bot, right)]
        3 | 12 => [(left, right)]
        4 | 11 => [(right, top)]
        5 => [(left, top), (bot, right)]
        10 => [(left, bot), (right, top)]
        6 | 9 => [(bot, top)]
        7 | 8 => [(left, top)]
        _ => []
      }
      for seg in segs {
        let (sx1, sy1) = seg.0
        let (sx2, sy2) = seg.1
        segments.push(ContourSegment::new(
          world_x(g, sx1),
          world_y(g, sy1),
          world_x(g, sx2),
          world_y(g, sy2),
        ))
      }
    }
  }
  segments
}
