///|
/// Query all point indices within a rectangle. / 查询矩形内的点索引。
pub fn grid_query_rect(
  grid : GridIndex,
  rect : @core.Rectangle,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<grid.points.length() {
    let px = grid.points[i].x()
    let py = grid.points[i].y()
    if px >= rect.min_x && px <= rect.max_x && py >= rect.min_y && py <= rect.max_y {
      result.push(i)
    }
  }
  result
}
