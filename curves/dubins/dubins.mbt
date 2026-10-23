///|
/// # Dubins Curves
/// # Dubins 曲线
///
/// Shortest path for a car-like robot with minimum turning radius (forward only).
/// 前向行驶小车模型的最短路径（最小转弯半径约束）。
///
/// ## Complexity: O(1) for path computation
/// ## 复杂度: 路径计算 O(1)


///|
/// Dubins path segment type. / Dubins 路径段类型。
pub(all) enum DubinsSegmentType {
  Left
  Straight
  Right
}


///|
/// Dubins path segment. / Dubins 路径段。
pub struct DubinsSegment {
  seg_type : DubinsSegmentType
  length : Double
}


///|
/// Construct a Dubins segment. / 构造 Dubins 路径段。
pub fn DubinsSegment::new(seg_type : DubinsSegmentType, length : Double) -> DubinsSegment {
  { seg_type, length }
}


///|
/// Dubins path consisting of up to 3 segments. / Dubins 路径（最多 3 段）。
pub struct DubinsPath {
  segments : Array[DubinsSegment]
  total_length : Double
  radius : Double
}
