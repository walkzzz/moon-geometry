///|
/// Check if a polygon is star-shaped (kernel is non-empty). / 检查多边形是否为星形（核非空）。
pub fn is_star_shaped(poly : Array[@core.Point2D]) -> Bool {
  let kernel = polygon_kernel(poly)
  kernel.length() >= 3
}

///|
/// Compute the area of the kernel. / 计算核的面积。
pub fn polygon_kernel_area(poly : Array[@core.Point2D]) -> Double {
  let kernel = polygon_kernel(poly)
  let n = kernel.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area += kernel[i].x() * kernel[j].y() - kernel[j].x() * kernel[i].y()
  }
  area.abs() / 2.0
}
