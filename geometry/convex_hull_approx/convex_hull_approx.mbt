///|
/// Approximate convex hull using grid-based sampling. / 基于网格采样的近似凸包。
pub fn approx_convex_hull(
  points : Array[@core.Point2D],
  grid_size : Int,
) -> Array[@core.Point2D] {
  if points.length() <= 3 {
    return points
  }
  let mut min_x = points[0].x()
  let mut max_x = points[0].x()
  let mut min_y = points[0].y()
  let mut max_y = points[0].y()
  for p in points {
    min_x = min_x.min(p.x())
    max_x = max_x.max(p.x())
    min_y = min_y.min(p.y())
    max_y = max_y.max(p.y())
  }
  let dx = (max_x - min_x) / grid_size.to_double()
  let dy = (max_y - min_y) / grid_size.to_double()
  if dx < 0.000000001 || dy < 0.000000001 {
    return points
  }
  let grid : Array[@core.Point2D] = Array::make(grid_size * grid_size, @core.Point2D::new(0.0, 0.0))
  let filled : Array[Bool] = Array::make(grid_size * grid_size, false)
  for p in points {
    let gx = ((p.x() - min_x) / dx).floor().to_int()
    let gy = ((p.y() - min_y) / dy).floor().to_int()
    let gx = if gx >= grid_size { grid_size - 1 } else { gx }
    let gy = if gy >= grid_size { grid_size - 1 } else { gy }
    let idx = gy * grid_size + gx
    if !filled[idx] {
      grid[idx] = p
      filled[idx] = true
    }
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<(grid_size * grid_size) {
    if filled[i] {
      result.push(grid[i])
    }
  }
  result
}
