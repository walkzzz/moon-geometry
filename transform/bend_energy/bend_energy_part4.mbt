///|
/// Total arc length of a closed curve. / 闭合曲线的总弧长。
pub fn curve_length(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  @core.polyline_length(points) + points[n - 1].dist(points[0])
}

///|
/// Normalized bend energy: E / (2π). / 归一化弯曲能量：E / (2π)。
///
/// Scale-invariant shape descriptor commonly used in computer vision.
/// 尺度不变的形状描述子，常用于计算机视觉。
pub fn normalized_bend_energy(points : Array[@core.Point2D]) -> Double {
  bend_energy(points) / (2.0 * @math.PI)
}
