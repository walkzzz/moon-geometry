///|
/// # Reeds-Shepp Curves
/// # Reeds-Shepp 曲线
///
/// Shortest path for a car-like robot that can move forward and backward.
/// 可前进和后退的小车模型最短路径。
///
/// ## Complexity: O(1) for path computation (48 word families)
/// ## 复杂度: 路径计算 O(1)（48 种路径字族）

///|
/// Reeds-Shepp path segment type. / Reeds-Shepp 路径段类型。
pub(all) enum RSSegmentType {
  Left
  Straight
  Right
}

///|
/// Reeds-Shepp path segment with direction. / 带方向的 Reeds-Shepp 路径段。
pub struct RSSegment {
  seg_type : RSSegmentType
  length : Double
  forward : Bool
}

///|
/// Construct a Reeds-Shepp segment. / 构造 Reeds-Shepp 路径段。
pub fn RSSegment::new(
  seg_type : RSSegmentType,
  length : Double,
  forward : Bool,
) -> RSSegment {
  { seg_type, length, forward, }
}

///|
/// Reeds-Shepp path. / Reeds-Shepp 路径。
pub struct RSPath {
  segments : Array[RSSegment]
  total_length : Double
  radius : Double
}
