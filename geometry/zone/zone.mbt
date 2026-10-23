///|
/// Zone of a line in an arrangement: the sequence of faces crossed by the line. / 线在排列中的区域：线穿过的面的序列。
pub struct Zone {
  line : @core.Line
  crossed_faces : Array[Int32]
  entry_points : Array[@core.Point2D]
}

///|
/// Compute the zone of a line with respect to a set of segments. / 计算线相对于线段集的区域。
pub fn compute_zone(line : @core.Line, segments : Array[@core.Segment]) -> Zone {
  let crossed_faces : Array[Int32] = []
  let entry_points : Array[@core.Point2D] = []
  for i in 0..<segments.length() {
    match line_segment_intersect(line, segments[i]) {
      Some(pt) => {
        crossed_faces.push(i)
        entry_points.push(pt)
      }
      None => continue
    }
  }
  { line, crossed_faces, entry_points, }
}

///|
fn line_segment_intersect(
  line : @core.Line,
  seg : @core.Segment,
) -> @core.Point2D? {
  let p1 = seg.start
  let p2 = seg.end
  let v1 = line.evaluate(p1)
  let v2 = line.evaluate(p2)
  if v1 == 0.0 {
    return Some(p1)
  }
  if v2 == 0.0 {
    return Some(p2)
  }
  if v1 * v2 > 0.0 {
    return None
  }
  let t = v1 / (v1 - v2)
  Some(
    @core.Point2D::new(
      p1.x() + t * (p2.x() - p1.x()),
      p1.y() + t * (p2.y() - p1.y()),
    ),
  )
}

///|
/// Get the number of faces crossed by the zone line. / 获取区域线穿过的面数。
pub fn zone_crossed_count(zone : Zone) -> Int32 {
  zone.crossed_faces.length()
}

///|
/// Get the entry points where the zone line crosses segments. / 获取区域线穿过线段的入口点。
pub fn zone_entry_points(zone : Zone) -> Array[@core.Point2D] {
  zone.entry_points
}

///|
/// Get the crossed face indices. / 获取穿过的面索引。
pub fn zone_crossed_faces(zone : Zone) -> Array[Int32] {
  zone.crossed_faces
}

///|
/// Compute the zone complexity (number of edges in the zone). / 计算区域复杂度（区域中的边数）。
pub fn zone_complexity(zone : Zone) -> Int32 {
  zone.crossed_faces.length() + 1
}

///|
/// Theoretical upper bound on zone complexity: O(n) for n segments. / 区域复杂度的理论上界：n 条线段为 O(n)。
pub fn zone_complexity_bound(n : Int32) -> Int32 {
  5 * n + 1
}
