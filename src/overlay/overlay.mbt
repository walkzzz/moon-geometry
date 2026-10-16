///|
/// Overlay result of two planar subdivisions. / 两个平面细分的叠加结果。
pub struct OverlayResult {
  vertices : Array[@core.Point2D]
  edges : Array[(Int, Int)]
}

///|
/// Compute the overlay of two sets of segments (find all intersections and split edges). / 计算两组线段的叠加（找出所有交点并分割边）。
pub fn overlay(
  segs1 : Array[@core.Segment],
  segs2 : Array[@core.Segment],
) -> OverlayResult {
  let vertices : Array[@core.Point2D] = []
  let edges : Array[(Int, Int)] = []
  for seg in segs1 {
    let i0 = add_vertex_unique(vertices, seg.start)
    let i1 = add_vertex_unique(vertices, seg.end)
    edges.push((i0, i1))
  }
  for seg in segs2 {
    let i0 = add_vertex_unique(vertices, seg.start)
    let i1 = add_vertex_unique(vertices, seg.end)
    edges.push((i0, i1))
  }
  let all_segs = segs1 + segs2
  for i in 0..<all_segs.length() {
    for j in (i + 1)..<all_segs.length() {
      match seg_intersect(
        all_segs[i].start,
        all_segs[i].end,
        all_segs[j].start,
        all_segs[j].end,
      ) {
        Some(pt) => {
          let vi = add_vertex_unique(vertices, pt)
          ignore(vi)
        }
        None => continue
      }
    }
  }
  { vertices, edges }
}

fn add_vertex_unique(
  vertices : Array[@core.Point2D],
  p : @core.Point2D,
) -> Int {
  for k in 0..<vertices.length() {
    if vertices[k].dist(p) < 0.000000001 {
      return k
    }
  }
  let idx = vertices.length()
  vertices.push(p)
  idx
}

fn seg_intersect(
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
  if t > 0.0 && t < 1.0 && u > 0.0 && u < 1.0 {
    Some(@core.Point2D::new(p1.x() + t * d1x, p1.y() + t * d1y))
  } else {
    None
  }
}

///|
/// Get the number of vertices in the overlay. / 获取叠加结果中的顶点数。
pub fn overlay_vertex_count(result : OverlayResult) -> Int {
  result.vertices.length()
}

///|
/// Get the number of edges in the overlay. / 获取叠加结果中的边数。
pub fn overlay_edge_count(result : OverlayResult) -> Int {
  result.edges.length()
}

///|
/// Get all vertices of the overlay. / 获取叠加结果的所有顶点。
pub fn overlay_vertices(
  result : OverlayResult,
) -> Array[@core.Point2D] {
  result.vertices
}

///|
/// Get all edges of the overlay. / 获取叠加结果的所有边。
pub fn overlay_edges(result : OverlayResult) -> Array[(Int, Int)] {
  result.edges
}