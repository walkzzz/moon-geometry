///|
/// Uniform grid spatial index. / 均匀网格空间索引。
pub struct GridIndex {
  points : Array[@core.Point2D]
  cell_size : Double
  cell_keys : Array[Int32]
} derive(Debug)

///|
pub extend GridIndex with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn grid_key(p : @core.Point2D, cell_size : Double) -> Int32 {
  let cx = (p.x() / cell_size).floor().to_int()
  let cy = (p.y() / cell_size).floor().to_int()
  cx * 1000000 + cy
}

///|
/// Build a grid index from points. / 构建网格索引。
pub fn build_grid_index(
  points : Array[@core.Point2D],
  cell_size : Double,
) -> GridIndex {
  let cell_keys : Array[Int32] = []
  for i in 0..<points.length() {
    cell_keys.push(grid_key(points[i], cell_size))
  }
  { points, cell_size, cell_keys, }
}

///|
/// Query all point indices within a radius. / 查询半径内的点索引。
pub fn grid_query_radius(
  grid : GridIndex,
  center : @core.Point2D,
  radius : Double,
) -> Array[Int32] {
  let result : Array[Int32] = []
  let r2 = radius * radius
  for i in 0..<grid.points.length() {
    let dx = grid.points[i].x() - center.x()
    let dy = grid.points[i].y() - center.y()
    if dx * dx + dy * dy <= r2 {
      result.push(i)
    }
  }
  result
}
