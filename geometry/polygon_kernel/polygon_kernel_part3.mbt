///|
/// Find a point in the kernel (centroid of kernel vertices). / 在核中找一点（核顶点的质心）。
pub fn kernel_point(poly : Array[@core.Point2D]) -> @core.Point2D? {
  let kernel = polygon_kernel(poly)
  if kernel.length() < 3 {
    return None
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in kernel {
    sx += p.x()
    sy += p.y()
  }
  let n = kernel.length().to_double()
  Some(@core.Point2D::new(sx / n, sy / n))
}
