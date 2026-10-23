///|
/// A contour line segment. / 等值线段。
pub struct ContourSegment {
  x1 : Double
  y1 : Double
  x2 : Double
  y2 : Double
}

///|
/// Construct a contour segment. / 构造等值线段。
pub fn ContourSegment::new(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> ContourSegment {
  { x1, y1, x2, y2, }
}

///|
/// Raster grid for contouring (rows x cols). / 用于等值线提取的栅格（rows x cols）。
pub struct ContourGrid {
  cols : Int32
  rows : Int32
  data : Array[Double]
  cell_size : Double
  x_origin : Double
  y_origin : Double
}

///|
/// Construct a contour grid. / 构造等值线栅格。
pub fn ContourGrid::new(
  cols : Int32,
  rows : Int32,
  data : Array[Double],
  cell_size : Double,
  x_origin : Double,
  y_origin : Double,
) -> ContourGrid {
  { cols, rows, data, cell_size, x_origin, y_origin, }
}

///|
/// Get grid value at (col, row). / 获取 (col, row) 处的网格值。
fn grid_get(g : ContourGrid, col : Int32, row : Int32) -> Double {
  g.data[row * g.cols + col]
}

///|
/// World X coordinate of a grid column. / 网格列对应的世界 X 坐标。
fn world_x(g : ContourGrid, col : Double) -> Double {
  g.x_origin + col * g.cell_size
}

///|
/// World Y coordinate of a grid row (row 0 at top). / 网格行对应的世界 Y 坐标（第 0 行在顶部）。
fn world_y(g : ContourGrid, row : Double) -> Double {
  g.y_origin + (g.rows.to_double() - 1.0 - row) * g.cell_size
}

///|
/// Linear interpolation along an edge to find contour crossing. / 沿边线性插值找等值线交点。
fn interp_edge(v1 : Double, v2 : Double, level : Double) -> Double {
  if v2 == v1 {
    0.5
  } else {
    (level - v1) / (v2 - v1)
  }
}

///|
/// Marching Squares: extract contour segments at a given level. / Marching Squares：提取指定等值层的线段。
pub fn marching_squares(
  g : ContourGrid,
  level : Double,
) -> Array[ContourSegment] {
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
        segments.push(
          ContourSegment::new(
            world_x(g, sx1),
            world_y(g, sy1),
            world_x(g, sx2),
            world_y(g, sy2),
          ),
        )
      }
    }
  }
  segments
}

///|
/// Extract multiple contour levels. / 提取多个等值层。
pub fn extract_contours(
  g : ContourGrid,
  levels : Array[Double],
) -> Array[(Double, Array[ContourSegment])] {
  let result : Array[(Double, Array[ContourSegment])] = []
  for level in levels {
    let segs = marching_squares(g, level)
    result.push((level, segs))
  }
  result
}

///|
/// Label a cell with its case index (0-15) for a given level. / 用给定等值层的情形索引（0-15）标记单元。
pub fn label_cell(
  g : ContourGrid,
  col : Int32,
  row : Int32,
  level : Double,
) -> Int32 {
  if col < 0 || col >= g.cols - 1 || row < 0 || row >= g.rows - 1 {
    return -1
  }
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
  code
}

///|
/// Count total contour segments at a level. / 统计某等值层的线段总数。
pub fn count_contour_segments(g : ContourGrid, level : Double) -> Int32 {
  marching_squares(g, level).length()
}
