///|
/// Query all point indices within a radius. / 查询半径内的点索引。
pub fn spatial_hash_query_radius(
  hash : SpatialHash,
  center : @core.Point2D,
  radius : Double,
) -> Array[Int32] {
  let result : Array[Int32] = []
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
