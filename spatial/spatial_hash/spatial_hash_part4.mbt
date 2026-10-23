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