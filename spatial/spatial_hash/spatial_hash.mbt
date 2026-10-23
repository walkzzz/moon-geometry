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
