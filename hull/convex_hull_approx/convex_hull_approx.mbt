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

///|
/// Approximate convex hull area using bounding box ratio. / 使用包围盒比率近似凸包面积。
pub fn approx_hull_area(
  points : Array[@core.Point2D],
) -> Double {
  if points.length() < 3 {
    return 0.0
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
  (max_x - min_x) * (max_y - min_y) * 0.785
}

///|
/// Approximate convex hull perimeter. / 近似凸包周长。
pub fn approx_hull_perimeter(
  points : Array[@core.Point2D],
) -> Double {
  if points.length() < 2 {
    return 0.0
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
  2.0 * ((max_x - min_x) + (max_y - min_y)) * 0.9
}

///|
/// Quick hull approximation error bound. / 快速凸包近似误差界。
pub fn approx_error_bound(
  points : Array[@core.Point2D],
  grid_size : Int,
) -> Double {
  if points.length() == 0 {
    return 0.0
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
  (dx * dx + dy * dy).sqrt()
}