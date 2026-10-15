///|
/// Spatial hash table for proximity queries. / 空间哈希表。
pub struct SpatialHash {
  points : Array[@core.Point2D]
  cell_size : Double
} derive(Debug)

pub extend SpatialHash with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Build a spatial hash from points. / 构建空间哈希。
pub fn build_spatial_hash(
  points : Array[@core.Point2D],
  cell_size : Double,
) -> SpatialHash {
  { points, cell_size }
}

///|
/// Query all point indices within a radius. / 查询半径内的点索引。
pub fn spatial_hash_query_radius(
  hash : SpatialHash,
  center : @core.Point2D,
  radius : Double,
) -> Array[Int] {
  let result : Array[Int] = []
  let r2 = radius * radius
  let cell_range = (radius / hash.cell_size).ceil().to_int()
  let cx = (center.x() / hash.cell_size).floor().to_int()
  let cy = (center.y() / hash.cell_size).floor().to_int()
  for i in 0..<hash.points.length() {
    let px = (hash.points[i].x() / hash.cell_size).floor().to_int()
    let py = (hash.points[i].y() / hash.cell_size).floor().to_int()
    if (px - cx).abs() <= cell_range && (py - cy).abs() <= cell_range {
      let dx = hash.points[i].x() - center.x()
      let dy = hash.points[i].y() - center.y()
      if dx * dx + dy * dy <= r2 {
        result.push(i)
      }
    }
  }
  result
}

///|
/// Query all point indices within a rectangle. / 查询矩形内的点索引。
pub fn spatial_hash_query_rect(
  hash : SpatialHash,
  rect : @core.Rectangle,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<hash.points.length() {
    let px = hash.points[i].x()
    let py = hash.points[i].y()
    if px >= rect.min_x && px <= rect.max_x && py >= rect.min_y && py <= rect.max_y {
      result.push(i)
    }
  }
  result
}

///|
/// Query nearby points (same or adjacent cells). / 查询邻近点。
pub fn spatial_hash_nearby(
  hash : SpatialHash,
  p : @core.Point2D,
) -> Array[Int] {
  let result : Array[Int] = []
  let cx = (p.x() / hash.cell_size).floor().to_int()
  let cy = (p.y() / hash.cell_size).floor().to_int()
  for i in 0..<hash.points.length() {
    let px = (hash.points[i].x() / hash.cell_size).floor().to_int()
    let py = (hash.points[i].y() / hash.cell_size).floor().to_int()
    if (px - cx).abs() <= 1 && (py - cy).abs() <= 1 {
      result.push(i)
    }
  }
  result
}

///|
/// Number of points. / 点数。
pub fn spatial_hash_size(hash : SpatialHash) -> Int {
  hash.points.length()
}