///|
/// Build a quadtree. / 构建四叉树。
pub fn build_quadtree(points : Array[Point2D], bounds : Rectangle) -> Array[QuadNode] {
  @quadtree.build_quadtree(points, bounds)
}


///|
/// Range query in quadtree. / 四叉树范围查询。
pub fn quadtree_range_query(nodes : Array[QuadNode], rect : Rectangle) -> Array[Int] {
  @quadtree.quadtree_range_query(nodes, rect)
}


///|
/// Count points in quadtree. / 统计四叉树点数。
pub fn quadtree_count(nodes : Array[QuadNode]) -> Int {
  @quadtree.quadtree_count(nodes)
}

// ---------------------------------------------------------------------------
// grid_index: uniform grid / 均匀网格
// ---------------------------------------------------------------------------


///|
/// Grid index type. / 网格索引类型。
pub type GridIndex = @grid_index.GridIndex


///|
/// Build a grid index. / 构建网格索引。
pub fn build_grid_index(points : Array[Point2D], cell_size : Double) -> GridIndex {
  @grid_index.build_grid_index(points, cell_size)
}


///|
/// Query points within radius. / 查询半径内的点。
pub fn grid_query_radius(grid : GridIndex, center : Point2D, radius : Double) -> Array[Int] {
  @grid_index.grid_query_radius(grid, center, radius)
}


///|
/// Query points within rectangle. / 查询矩形内的点。
pub fn grid_query_rect(grid : GridIndex, rect : Rectangle) -> Array[Int] {
  @grid_index.grid_query_rect(grid, rect)
}
