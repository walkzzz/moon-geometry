///|
/// Get the minimum translation vector (MTV) from a SAT result. / 从 SAT 结果获取最小平移向量。
pub fn sat_mtv(result : SATResult) -> @core.Point2D {
  @core.Point2D::new(result.axis_x * result.overlap, result.axis_y * result.overlap)
}


///|
/// Get the separating axis direction from a SAT result. / 从 SAT 结果获取分离轴方向。
pub fn sat_separating_axis(result : SATResult) -> @core.Point2D {
  @core.Point2D::new(result.axis_x, result.axis_y)
}