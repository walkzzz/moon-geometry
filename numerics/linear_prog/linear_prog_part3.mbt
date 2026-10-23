///|
/// Check if constraints are feasible. / 检查约束是否可行。
pub fn is_feasible(constraints : Array[(Double, Double, Double)]) -> Bool {
  let result = linear_program_2d(constraints, 0.0, 0.0)
  match result {
    Some(_) => true
    None => false
  }
}

///|
/// Find a feasible point. / 寻找可行点。
pub fn find_feasible_point(
  constraints : Array[(Double, Double, Double)],
) -> @core.Point2D? {
  let result = linear_program_2d(constraints, 0.0, 0.0)
  match result {
    Some(r) => Some(r.point)
    None => None
  }
}
