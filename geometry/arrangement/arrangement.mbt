///|
/// Intersection point in a line segment arrangement. / 线段排列中的交点。
pub struct ArrangementVertex {
  point : @core.Point2D
  seg_ids : Array[Int32]
}

///|
/// Line segment arrangement: computes all intersection points of a set of segments. / 线段排列：计算一组线段的所有交点。
pub struct Arrangement {
  segments : Array[@core.Segment]
  vertices : Array[ArrangementVertex]
}

///|
/// Build an arrangement from a set of segments using brute-force intersection. / 使用暴力相交从线段集构建排列。
pub fn build_arrangement(segments : Array[@core.Segment]) -> Arrangement {
  let vertices : Array[ArrangementVertex] = []
  for i in 0..<segments.length() {
    let v : ArrangementVertex = { point: segments[i].start, seg_ids: [i], }
    vertices.push(v)
    let v2 : ArrangementVertex = { point: segments[i].end, seg_ids: [i], }
    vertices.push(v2)
  }
  for i in 0..<segments.length() {
    for j in (i + 1)..<segments.length() {
      match
        segment_intersect(
          segments[i].start,
          segments[i].end,
          segments[j].start,
          segments[j].end,
        ) {
        Some(pt) => {
          let v : ArrangementVertex = { point: pt, seg_ids: [i, j], }
          vertices.push(v)
        }
        None => continue
      }
    }
  }
  { segments, vertices, }
}

///|
fn segment_intersect(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> @core.Point2D? {
  let d1x = p2.x() - p1.x()
  let d1y = p2.y() - p1.y()
  let d2x = p4.x() - p3.x()
  let d2y = p4.y() - p3.y()
  let denom = d1x * d2y - d1y * d2x
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return None
  }
  let t = ((p3.x() - p1.x()) * d2y - (p3.y() - p1.y()) * d2x) / denom
  let u = ((p3.x() - p1.x()) * d1y - (p3.y() - p1.y()) * d1x) / denom
  if t >= 0.0 && t <= 1.0 && u >= 0.0 && u <= 1.0 {
    Some(@core.Point2D::new(p1.x() + t * d1x, p1.y() + t * d1y))
  } else {
    None
  }
}

///|
/// Get all vertices of the arrangement. / 获取排列的所有顶点。
pub fn arrangement_vertices(arr : Arrangement) -> Array[ArrangementVertex] {
  arr.vertices
}

///|
/// Count the number of intersection vertices (excluding endpoints). / 计算交点顶点数（不含端点）。
pub fn arrangement_intersection_count(arr : Arrangement) -> Int32 {
  let mut count = 0
  for v in arr.vertices {
    if v.seg_ids.length() >= 2 {
      count += 1
    }
  }
  count
}

///|
/// Get the total number of edges in the arrangement (upper bound). / 获取排列中边的总数（上界）。
pub fn arrangement_edge_count(arr : Arrangement) -> Int32 {
  let n = arr.segments.length()
  let k = arrangement_intersection_count(arr)
  n + k
}

///|
/// Get the number of faces in the arrangement (Euler formula: F = E - V + 2). / 用欧拉公式获取排列的面数（F = E - V + 2）。
pub fn arrangement_face_count(arr : Arrangement) -> Int32 {
  let v = arr.vertices.length()
  let e = arrangement_edge_count(arr)
  e - v + 2
}
