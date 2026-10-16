///|
/// # Ground Detection
/// # 地面检测
///
/// Detect ground plane from point clouds using height and slope filtering.
/// 通过高度和坡度过滤从点云检测地面。

///|
/// Detect ground by simple height thresholding. / 通过高度阈值检测地面。
pub fn detect_ground_height(points : Array[@core.Point3D], threshold : Double) -> Array[Bool] {
  let result : Array[Bool] = []
  for i in 0..<points.length() {
    result.push(points[i].z < threshold)
  }
  result
}

///|
/// Detect ground by progressive height with slope. / 通过渐进高度和坡度检测地面。
pub fn detect_ground_progressive(points : Array[@core.Point3D], base_height : Double, slope : Double) -> Array[Bool] {
  let result : Array[Bool] = []
  for i in 0..<points.length() {
    let adjusted = base_height + slope * (points[i].x.abs() + points[i].y.abs())
    result.push(points[i].z < adjusted)
  }
  result
}

///|
/// Count ground points. / 地面点计数。
pub fn ground_point_count(labels : Array[Bool]) -> Int {
  let mut count = 0
  for i in 0..<labels.length() {
    if labels[i] {
      count += 1
    }
  }
  count
}

///|
/// Ground ratio. / 地面比例。
pub fn ground_ratio(labels : Array[Bool]) -> Double {
  if labels.length() == 0 {
    return 0.0
  }
  ground_point_count(labels).to_double() / labels.length().to_double()
}
