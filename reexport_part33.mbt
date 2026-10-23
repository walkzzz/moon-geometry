///|
/// Query points in a grid cell. / 查询网格单元内的点。
pub fn grid_query_cell(grid : GridIndex, p : Point2D) -> Array[Int] {
  @grid_index.grid_query_cell(grid, p)
}


///|
/// Number of points in grid. / 网格中的点数。
pub fn grid_size(grid : GridIndex) -> Int {
  @grid_index.grid_size(grid)
}

// ---------------------------------------------------------------------------
// range_tree: range tree / 范围树
// ---------------------------------------------------------------------------


///|
/// Range tree type. / 范围树类型。
pub type RangeTree = @range_tree.RangeTree


///|
/// Build a range tree. / 构建范围树。
pub fn build_range_tree(points : Array[Point2D]) -> RangeTree {
  @range_tree.build_range_tree(points)
}


///|
/// Orthogonal range query. / 正交范围查询。
pub fn range_query(
  tree : RangeTree,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
) -> Array[Int] {
  @range_tree.range_query(tree, x_lo, x_hi, y_lo, y_hi)
}


///|
/// Query by x-range. / 按 x 范围查询。
pub fn range_query_x(tree : RangeTree, x_lo : Double, x_hi : Double) -> Array[Int] {
  @range_tree.range_query_x(tree, x_lo, x_hi)
}


///|
/// Query by y-range. / 按 y 范围查询。
pub fn range_query_y(tree : RangeTree, y_lo : Double, y_hi : Double) -> Array[Int] {
  @range_tree.range_query_y(tree, y_lo, y_hi)
}
