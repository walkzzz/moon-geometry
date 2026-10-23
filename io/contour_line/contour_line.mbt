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
  { x1, y1, x2, y2 }
}


///|
/// Raster grid for contouring (rows x cols). / 用于等值线提取的栅格（rows x cols）。
pub struct ContourGrid {
  cols : Int
  rows : Int
  data : Array[Double]
  cell_size : Double
  x_origin : Double
  y_origin : Double
}


///|
/// Construct a contour grid. / 构造等值线栅格。
pub fn ContourGrid::new(
  cols : Int,
  rows : Int,
  data : Array[Double],
  cell_size : Double,
  x_origin : Double,
  y_origin : Double,
) -> ContourGrid {
  { cols, rows, data, cell_size, x_origin, y_origin }
}


///|
/// Get grid value at (col, row). / 获取 (col, row) 处的网格值。
fn grid_get(g : ContourGrid, col : Int, row : Int) -> Double {
  g.data[row * g.cols + col]
}


///|
/// World X coordinate of a grid column. / 网格列对应的世界 X 坐标。
fn world_x(g : ContourGrid, col : Double) -> Double {
  g.x_origin + col * g.cell_size
}
