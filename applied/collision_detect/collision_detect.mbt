///|
/// # Collision Detection
/// # 碰撞检测
///
/// Broad phase (AABB sweep and prune) and narrow phase (segment, polygon, circle).
/// 宽相（AABB 扫掠修剪）和窄相（线段、多边形、圆）碰撞检测。
///
/// ## Complexity: O(n log n) broad phase + O(1) narrow phase per pair
/// ## 复杂度: 宽相 O(n log n) + 每对窄相 O(1)


///|
/// AABB (axis-aligned bounding box) in 2D. / 二维轴对齐包围盒。
pub struct AABB {
  min_x : Double
  min_y : Double
  max_x : Double
  max_y : Double
}


///|
/// Construct an AABB. / 构造 AABB。
pub fn AABB::new(min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> AABB {
  { min_x, min_y, max_x, max_y }
}


///|
/// Construct an AABB from a center and half-extents. / 从中心和半边长构造 AABB。
pub fn AABB::from_center(cx : Double, cy : Double, hx : Double, hy : Double) -> AABB {
  { min_x: cx - hx, min_y: cy - hy, max_x: cx + hx, max_y: cy + hy }
}
