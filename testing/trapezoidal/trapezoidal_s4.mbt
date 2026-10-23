///|
/// Get the number of trapezoids. / 获取梯形数量。
pub fn trapezoidal_count(map : TrapezoidalMap) -> Int {
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
