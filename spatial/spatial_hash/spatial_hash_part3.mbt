///|
/// Query all point indices within a rectangle. / 查询矩形内的点索引。
pub fn spatial_hash_query_rect(
  hash : SpatialHash,
  rect : @core.Rectangle,
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<hash.points.length() {
    let px = hash.points[i].x()
    let py = hash.points[i].y()
    if px >= rect.min_x &&
      px <= rect.max_x &&
      py >= rect.min_y &&
      py <= rect.max_y {
      result.push(i)
    }
  }
  result
}
