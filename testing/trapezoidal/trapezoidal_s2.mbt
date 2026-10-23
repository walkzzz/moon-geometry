///|
/// Build a trapezoidal decomposition from a set of non-crossing segments. / 从一组不相交线段构建梯形分解。
pub fn build_trapezoidal_map(segments : Array[@core.Segment]) -> TrapezoidalMap {
  let mut min_x = 999999.0
  let mut max_x = -999999.0
  let mut min_y = 999999.0
  let mut max_y = -999999.0
  for seg in segments {
    min_x = min_x.min(seg.start.x()).min(seg.end.x())
    max_x = max_x.max(seg.start.x()).max(seg.end.x())
    min_y = min_y.min(seg.start.y()).min(seg.end.y())
    max_y = max_y.max(seg.start.y()).max(seg.end.y())
  }
  if segments.length() == 0 {
    min_x = 0.0
    max_x = 1.0
    min_y = 0.0
    max_y = 1.0
  }
  let trapezoids : Array[Trapezoid] = []
  let initial : Trapezoid = {
    left: min_x - 1.0,
    right: max_x + 1.0,
    top: -1,
    bottom: -1,
    left_p: None,
    right_p: None,
  }
  trapezoids.push(initial)
  { segments, trapezoids, }
}
