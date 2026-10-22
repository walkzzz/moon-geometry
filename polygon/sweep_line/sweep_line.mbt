///|
/// Check if any pair of segments in the set intersects.
/// Returns true if at least one pair intersects.
/// Brute-force O(n²) check using existing intersection test.
///
/// 检测线段集合中是否有任何一对线段相交。暴力 O(n²) 检测。
pub fn has_any_intersection(segments : Array[@core.Segment]) -> Bool {
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        return true
      }
    }
  }
  false
}

///|
/// Find all intersecting pairs of segments.
/// Returns array of (i, j) index pairs with i < j.
/// Brute-force O(n² + k) where k is the number of intersections.
///
/// 找出所有相交线段对。返回 (i, j) 索引对数组，i < j。
pub fn find_all_intersections(
  segments : Array[@core.Segment],
) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        result.push((i, j))
      }
    }
  }
  result
}

///|
/// Count the number of intersecting pairs.
/// O(n²) brute-force. / 计数相交线段对数。O(n²) 暴力。
pub fn count_intersections(segments : Array[@core.Segment]) -> Int {
  let mut count = 0
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        count += 1
      }
    }
  }
  count
}

///|
/// Find all intersection points between segments.
/// Returns array of (i, j, point) triples.
/// For overlapping segments, returns one endpoint.
///
/// 找出所有线段交点。返回 (i, j, 交点) 三元组数组。
pub fn find_intersection_points(
  segments : Array[@core.Segment],
) -> Array[(Int, Int, @core.Point2D)] {
  let result : Array[(Int, Int, @core.Point2D)] = []
  let n = segments.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      match @intersect.segment_intersection(segments[i], segments[j]) {
        Some(p) => result.push((i, j, p))
        None => continue
      }
    }
  }
  result
}

///|
/// Check if a set of segments forms a simple polygon (no self-intersections
/// except at shared endpoints). Segments should form a closed chain.
///
/// 检测线段集合是否构成简单多边形（无非端点自相交）。
pub fn is_simple_polygon_chain(segments : Array[@core.Segment]) -> Bool {
  let n = segments.length()
  if n < 3 {
    return false
  }
  for i in 0..<n {
    let j_start = i + 2
    let j_end = if i == 0 { n - 1 } else { n }
    for j in j_start..<j_end {
      if @intersect.segments_intersect(segments[i], segments[j]) {
        return false
      }
    }
  }
  true
}
