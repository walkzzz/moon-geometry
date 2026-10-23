///|
/// Estimate guard count. / 估计守卫数。
pub fn art_gallery_estimate(poly : Array[Point2D]) -> Int {
  @art_gallery.art_gallery_estimate(poly)
}

// ---------------------------------------------------------------------------
// polygon_kernel: polygon kernel / 多边形核
// ---------------------------------------------------------------------------


///|
/// Compute polygon kernel. / 计算多边形核。
pub fn polygon_kernel(poly : Array[Point2D]) -> Array[Point2D] {
  @polygon_kernel.polygon_kernel(poly)
}


///|
/// Check if polygon is star-shaped. / 检查多边形是否为星形。
pub fn is_star_shaped(poly : Array[Point2D]) -> Bool {
  @polygon_kernel.is_star_shaped(poly)
}


///|
/// Kernel area. / 核面积。
pub fn polygon_kernel_area(poly : Array[Point2D]) -> Double {
  @polygon_kernel.polygon_kernel_area(poly)
}


///|
/// Find a point in the kernel. / 在核中找一点。
pub fn kernel_point(poly : Array[Point2D]) -> Point2D? {
  @polygon_kernel.kernel_point(poly)
}

// ---------------------------------------------------------------------------
// convex_decomp: convex decomposition / 凸分解
// ---------------------------------------------------------------------------
