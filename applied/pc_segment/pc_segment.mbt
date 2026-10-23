///|
/// # Point Cloud Segmentation
/// # 点云分割
///
/// Region growing and plane segmentation for point clouds.
/// 点云的区域生长和平面分割。


///|
/// Segment points by Z-value threshold (ground vs non-ground). / 按Z值阈值分割点云。
pub fn segment_by_height(points : Array[@core.Point3D], threshold : Double) -> (Array[Int], Array[Int]) {
  let ground : Array[Int] = []
  let non_ground : Array[Int] = []
  for i in 0..<points.length() {
    if points[i].z < threshold {
      ground.push(i)
    } else {
      non_ground.push(i)
    }
  }
  (ground, non_ground)
}
