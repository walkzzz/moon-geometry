///|
/// A trapezoid in the trapezoidal decomposition. / 梯形分解中的梯形。
pub struct Trapezoid {
  left : Double
  right : Double
  top : Int32
  bottom : Int32
  left_p : @core.Point2D?
  right_p : @core.Point2D?
}

///|
/// Trapezoidal map for point location queries. / 用于点定位查询的梯形图。
pub struct TrapezoidalMap {
  segments : Array[@core.Segment]
  trapezoids : Array[Trapezoid]
}

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

///|
/// Locate which trapezoid contains a query point. / 定位包含查询点的梯形。
pub fn trapezoidal_locate(map : TrapezoidalMap, p : @core.Point2D) -> Int32 {
  for i in 0..<map.trapezoids.length() {
    let t = map.trapezoids[i]
    if p.x() >= t.left && p.x() <= t.right {
      return i
    }
  }
  -1
}

///|
/// Get the number of trapezoids. / 获取梯形数量。
pub fn trapezoidal_count(map : TrapezoidalMap) -> Int32 {
  map.trapezoids.length()
}

///|
/// Get all trapezoids. / 获取所有梯形。
pub fn trapezoidal_all(map : TrapezoidalMap) -> Array[Trapezoid] {
  map.trapezoids
}

///|
/// Query if a point is above or below a segment. / 查询点在线段上方还是下方。
pub fn trapezoidal_above_segment(
  seg : @core.Segment,
  p : @core.Point2D,
) -> Bool {
  let dx = seg.end.x() - seg.start.x()
  let dy = seg.end.y() - seg.start.y()
  let cross = dx * (p.y() - seg.start.y()) - dy * (p.x() - seg.start.x())
  cross > 0.0
}

///|
/// Compute the expected number of trapezoids (at most 3n + 1 for n segments). / 计算梯形期望数（n 条线段最多 3n + 1 个梯形）。
pub fn trapezoidal_expected_count(map : TrapezoidalMap) -> Int32 {
  3 * map.segments.length() + 1
}
