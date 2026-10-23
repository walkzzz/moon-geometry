///|
/// Degenerate configuration detection and handling. / 退化构型检测与处理。
///
/// Degenerate cases (collinear points, overlapping edges, zero-area triangles,
/// near-tangent intersections, extremely small angles, self-intersecting contours)
/// are the source of 90% of problems in real-world geometric projects.
///
/// 退化场景（共线点、重叠边、零面积三角形、近切相交、极小角度、自交轮廓）
/// 是实际项目中 90% 问题的来源。

///|
/// Degenerate case type. / 退化类型。
pub enum DegenerateType {
  /// Collinear points. / 共线点。
  CollinearPoints
  /// Overlapping edges. / 重叠边。
  OverlappingEdges
  /// Zero-area triangle. / 零面积三角形。
  ZeroAreaTriangle
  /// Near-tangent intersection. / 近切相交。
  NearTangent
  /// Extremely small angle. / 极小角度。
  SmallAngle
  /// Self-intersecting contour. / 自交轮廓。
  SelfIntersecting
  /// Coincident points. / 重合点。
  CoincidentPoints
} derive(Debug, Eq)

///|
pub extend DegenerateType with Eq::{not_equal, equal}

///|
pub extend DegenerateType with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Suppress unused constructor warnings — all variants are part of public API. / 抑制未使用构造子警告——所有变体都是公共 API 的一部分。
fn _suppress_unused_degenerate() -> Unit {
  ignore(CollinearPoints)
  ignore(OverlappingEdges)
  ignore(NearTangent)
}

///|
/// Degenerate case detection result. / 退化检测结果。
pub struct DegenerateResult {
  degenerate_type : DegenerateType
  severity : Double
  message : String
}

///|
/// Detect all degenerate cases in a point set. / 检测点集中的所有退化情况。
pub fn detect_degenerate_points(
  points : Array[@core.Point2D],
  tol : Double,
) -> Array[DegenerateResult] {
  let results : Array[DegenerateResult] = []
  let n = points.length()
  for i in 0..<n {
    for j in 0..<(i + 1) {
      if points[i].dist(points[j]) <= tol {
        results.push({
          degenerate_type: CoincidentPoints,
          severity: points[i].dist(points[j]),
          message: "Points {i} and {j} are coincident",
        })
      }
    }
  }
  results
}

///|
/// Detect degenerate triangles in a mesh. / 检测网格中的退化三角形。
pub fn detect_degenerate_triangles(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  tol : Double,
) -> Array[DegenerateResult] {
  let results : Array[DegenerateResult] = []
  for i in 0..<faces.length() {
    let (a, b, c) = faces[i]
    let pa = vertices[a]
    let pb = vertices[b]
    let pc = vertices[c]
    let ab = @core.Point3D::new(pb.x - pa.x, pb.y - pa.y, pb.z - pa.z)
    let ac = @core.Point3D::new(pc.x - pa.x, pc.y - pa.y, pc.z - pa.z)
    let cross_x = ab.y * ac.z - ab.z * ac.y
    let cross_y = ab.z * ac.x - ab.x * ac.z
    let cross_z = ab.x * ac.y - ab.y * ac.x
    let area = (cross_x * cross_x + cross_y * cross_y + cross_z * cross_z).sqrt() /
      2.0
    if area <= tol {
      results.push({
        degenerate_type: ZeroAreaTriangle,
        severity: area,
        message: "Face {i} has near-zero area ({area})",
      })
    }
  }
  results
}

///|
/// Detect self-intersecting polygon edges. / 检测自交多边形边。
pub fn detect_self_intersection(
  points : Array[@core.Point2D],
  tol : Double,
) -> Array[DegenerateResult] {
  let results : Array[DegenerateResult] = []
  let n = points.length()
  if n < 4 {
    return results
  }
  for i in 0..<n {
    let j = (i + 1) % n
    for k in (i + 2)..<n {
      let l = (k + 1) % n
      if k == i || l == j {
        continue
      }
      if segments_intersect_tol(points[i], points[j], points[k], points[l], tol) {
        results.push({
          degenerate_type: SelfIntersecting,
          severity: 1.0,
          message: "Edges {i}-{j} and {k}-{l} intersect",
        })
      }
    }
  }
  results
}

///|
/// Check if two segments intersect within tolerance. / 检查两条线段在公差范围内是否相交。
fn segments_intersect_tol(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  d : @core.Point2D,
  tol : Double,
) -> Bool {
  let d1 = (c.x - a.x) * (b.y - a.y) - (c.y - a.y) * (b.x - a.x)
  let d2 = (d.x - a.x) * (b.y - a.y) - (d.y - a.y) * (b.x - a.x)
  let d3 = (a.x - c.x) * (d.y - c.y) - (a.y - c.y) * (d.x - c.x)
  let d4 = (b.x - c.x) * (d.y - c.y) - (b.y - c.y) * (d.x - c.x)
  let eps = tol * tol
  if ((d1 > eps && d2 < -eps) || (d1 < -eps && d2 > eps)) &&
    ((d3 > eps && d4 < -eps) || (d3 < -eps && d4 > eps)) {
    return true
  }
  false
}

///|
/// Detect extremely small angles in a polygon. / 检测多边形中的极小角度。
pub fn detect_small_angles(
  points : Array[@core.Point2D],
  angle_tol : Double,
) -> Array[DegenerateResult] {
  let results : Array[DegenerateResult] = []
  let n = points.length()
  if n < 3 {
    return results
  }
  for i in 0..<n {
    let prev = points[(i + n - 1) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let v1x = prev.x - curr.x
    let v1y = prev.y - curr.y
    let v2x = next.x - curr.x
    let v2y = next.y - curr.y
    let len1 = (v1x * v1x + v1y * v1y).sqrt()
    let len2 = (v2x * v2x + v2y * v2y).sqrt()
    if len1 < 0.000000001 || len2 < 0.000000001 {
      continue
    }
    let cos_angle = (v1x * v2x + v1y * v2y) / (len1 * len2)
    let clamped = if cos_angle > 1.0 {
      1.0
    } else if cos_angle < -1.0 {
      -1.0
    } else {
      cos_angle
    }
    if clamped >= 1.0 - angle_tol {
      results.push({
        degenerate_type: SmallAngle,
        severity: 0.0,
        message: "Vertex {i} has small angle",
      })
    }
  }
  results
}

///|
/// Remove degenerate (coincident) points, keeping first occurrence. / 移除退化（重合）点，保留首次出现。
pub fn remove_coincident_points(
  points : Array[@core.Point2D],
  tol : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    let mut found = false
    for q in result {
      if p.dist(q) <= tol {
        found = true
        break
      }
    }
    if !found {
      result.push(p)
    }
  }
  result
}
