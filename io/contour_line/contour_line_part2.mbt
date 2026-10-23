///|
/// World Y coordinate of a grid row (row 0 at top). / 网格行对应的世界 Y 坐标（第 0 行在顶部）。
fn world_y(g : ContourGrid, row : Double) -> Double {
  g.y_origin + (g.rows.to_double() - 1.0 - row) * g.cell_size
}


///|
/// Linear interpolation along an edge to find contour crossing. / 沿边线性插值找等值线交点。
fn interp_edge(v1 : Double, v2 : Double, level : Double) -> Double {
  if v2 == v1 {
    0.5
  } else {
    (level - v1) / (v2 - v1)
  }
}
