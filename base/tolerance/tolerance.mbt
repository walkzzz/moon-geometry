///|
/// Tolerance context for geometric operations. / 几何操作的公差上下文。
///
/// Real engineering data never has "exact equality". All coincidence, collinearity,
/// tangency, and intersection tests need configurable tolerance thresholds.
///
/// 真实工程数据不存在"绝对相等"，所有重合、共线、相切、相交判断都需要可配置的公差阈值。
pub struct ToleranceCtx {
  /// Distance tolerance for point coincidence. / 点重合的距离公差。
  dist_tol : Double
  /// Angle tolerance in radians for parallel/perpendicular tests. / 平行/垂直测试的角度公差（弧度）。
  angle_tol : Double
  /// Area tolerance for zero-area triangle detection. / 零面积三角形检测的面积公差。
  area_tol : Double
  /// Relative tolerance for scalar comparisons. / 标量比较的相对公差。
  rel_tol : Double
}

///|
/// Default tolerance for general-purpose geometry (1e-9). / 通用几何默认公差（1e-9）。
pub fn ToleranceCtx::default() -> ToleranceCtx {
  {
    dist_tol: 0.000000001,
    angle_tol: 0.000000001,
    area_tol: 0.000000001,
    rel_tol: 0.000000001,
  }
}

///|
/// Strict tolerance for high-precision CAD (1e-12). / 高精度 CAD 严格公差（1e-12）。
pub fn ToleranceCtx::strict() -> ToleranceCtx {
  {
    dist_tol: 0.000000000001,
    angle_tol: 0.000000000001,
    area_tol: 0.000000000001,
    rel_tol: 0.000000000001,
  }
}

///|
/// Loose tolerance for interactive editing (1e-6). / 交互式编辑宽松公差（1e-6）。
pub fn ToleranceCtx::loose() -> ToleranceCtx {
  {
    dist_tol: 0.000001,
    angle_tol: 0.000001,
    area_tol: 0.000001,
    rel_tol: 0.000001,
  }
}

///|
/// Custom tolerance with specified distance threshold. / 自定义公差，指定距离阈值。
pub fn ToleranceCtx::custom(dist_tol : Double) -> ToleranceCtx {
  {
    dist_tol,
    angle_tol: dist_tol,
    area_tol: dist_tol * dist_tol,
    rel_tol: dist_tol,
  }
}

///|
/// Check if two points coincide within tolerance. / 检查两点在公差范围内是否重合。
pub fn points_coincide(
  a : @core.Point2D,
  b : @core.Point2D,
  tol : ToleranceCtx,
) -> Bool {
  a.dist(b) <= tol.dist_tol
}

///|
/// Check if three points are collinear within tolerance. / 检查三点在公差范围内是否共线。
pub fn points_collinear(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  tol : ToleranceCtx,
) -> Bool {
  let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)).abs() / 2.0
  area <= tol.area_tol
}

///|
/// Orientation test with tolerance: returns -1 (CW), 0 (collinear), 1 (CCW). / 带公差的方向判定：-1 顺时针，0 共线，1 逆时针。
pub fn orient_with_tol(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  tol : ToleranceCtx,
) -> Int32 {
  let cross = (b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)
  let area = cross.abs() / 2.0
  if area <= tol.area_tol {
    return 0
  }
  if cross > 0.0 {
    1
  } else {
    -1
  }
}

///|
/// Check if two segments overlap within tolerance. / 检查两条线段在公差范围内是否重叠。
pub fn segments_overlap(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
  tol : ToleranceCtx,
) -> Bool {
  if !points_collinear(a1, a2, b1, tol) {
    return false
  }
  if !points_collinear(a1, a2, b2, tol) {
    return false
  }
  let d1 = a1.dist(a2)
  if d1 <= tol.dist_tol {
    return points_coincide(a1, b1, tol) || points_coincide(a1, b2, tol)
  }
  let t_b1 = ((b1.x - a1.x) * (a2.x - a1.x) + (b1.y - a1.y) * (a2.y - a1.y)) /
    (d1 * d1)
  let t_b2 = ((b2.x - a1.x) * (a2.x - a1.x) + (b2.y - a1.y) * (a2.y - a1.y)) /
    (d1 * d1)
  let t_min = if t_b1 < t_b2 { t_b1 } else { t_b2 }
  let t_max = if t_b1 > t_b2 { t_b1 } else { t_b2 }
  t_min <= 1.0 + tol.rel_tol && t_max >= 0.0 - tol.rel_tol
}

///|
/// Check if a triangle has near-zero area. / 检查三角形面积是否接近零。
pub fn is_degenerate_triangle(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  tol : ToleranceCtx,
) -> Bool {
  points_collinear(a, b, c, tol) ||
  a.dist(b) <= tol.dist_tol ||
  b.dist(c) <= tol.dist_tol ||
  a.dist(c) <= tol.dist_tol
}

///|
/// Check if two angles are nearly equal within tolerance. / 检查两个角度在公差范围内是否近似相等。
pub fn angles_equal(a : Double, b : Double, tol : ToleranceCtx) -> Bool {
  let diff = (a - b).abs()
  let normalized = if diff > 3.141592653589793 {
    6.283185307179586 - diff
  } else {
    diff
  }
  normalized <= tol.angle_tol
}

///|
/// Check if two vectors are parallel within tolerance. / 检查两个向量在公差范围内是否平行。
pub fn vectors_parallel(
  v1x : Double,
  v1y : Double,
  v2x : Double,
  v2y : Double,
  tol : ToleranceCtx,
) -> Bool {
  let cross = (v1x * v2y - v1y * v2x).abs()
  let len1 = (v1x * v1x + v1y * v1y).sqrt()
  let len2 = (v2x * v2x + v2y * v2y).sqrt()
  if len1 <= tol.dist_tol || len2 <= tol.dist_tol {
    return true
  }
  cross / (len1 * len2) <= tol.angle_tol
}

///|
/// Check if two vectors are perpendicular within tolerance. / 检查两个向量在公差范围内是否垂直。
pub fn vectors_perpendicular(
  v1x : Double,
  v1y : Double,
  v2x : Double,
  v2y : Double,
  tol : ToleranceCtx,
) -> Bool {
  let dot = (v1x * v2x + v1y * v2y).abs()
  let len1 = (v1x * v1x + v1y * v1y).sqrt()
  let len2 = (v2x * v2x + v2y * v2y).sqrt()
  if len1 <= tol.dist_tol || len2 <= tol.dist_tol {
    return false
  }
  dot / (len1 * len2) <= tol.angle_tol
}

///|
/// Snap a value to zero if within tolerance. / 如果值在公差范围内，吸附到零。
pub fn snap_to_zero(value : Double, tol : ToleranceCtx) -> Double {
  if value.abs() <= tol.rel_tol {
    0.0
  } else {
    value
  }
}

///|
/// Snap a point to another if within distance tolerance. / 如果点在距离公差范围内，吸附到另一点。
pub fn snap_point(
  p : @core.Point2D,
  reference : @core.Point2D,
  tol : ToleranceCtx,
) -> @core.Point2D {
  if p.dist(reference) <= tol.dist_tol {
    reference
  } else {
    p
  }
}
