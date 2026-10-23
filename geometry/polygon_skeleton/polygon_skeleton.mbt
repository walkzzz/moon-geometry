/// |
/// # Straight Skeleton Approximation
/// # 直骨架近似
///
/// Approximate the straight skeleton of a simple polygon by computing
/// the angle bisector intersection for each vertex.
/// 通过计算每个顶点的角平分线交点来近似简单多边形的直骨架。
///
/// ## Complexity: O(n²)
/// ## 复杂度: O(n²)

///|
/// |
/// Compute approximate straight skeleton edges.
/// 计算近似直骨架边。
///
/// Returns an array of segments representing the skeleton.
/// 返回表示骨架的线段数组。
pub fn straight_skeleton(poly : @core.Polygon) -> Array[@core.Segment] {
  let n = poly.size()
  let result : Array[@core.Segment] = []
  if n < 3 {
    return result
  }
  let pts = get_points(poly)
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let cur = pts[i]
    let next = pts[(i + 1) % n]
    let bisector = angle_bisector(prev, cur, next)
    let mut best_t = 1000000.0
    let mut best_hit : @core.Point2D? = None
    for j in 0..<n {
      if j == i || j == (i - 1 + n) % n {
        continue
      }
      let a = pts[j]
      let b = pts[(j + 1) % n]
      let hit = ray_segment_intersect(cur, bisector, a, b)
      match hit {
        Some(t) =>
          if t > 0.0000001 && t < best_t {
            best_t = t
            best_hit = Some(
              @core.Point2D::new(
                cur.x() + bisector.0 * t,
                cur.y() + bisector.1 * t,
              ),
            )
          }
        None => ()
      }
    }
    match best_hit {
      Some(p) => result.push(@core.Segment::new(cur, p))
      None => ()
    }
  }
  result
}

///|
/// |
/// Compute skeleton faces (cells) of the polygon.
/// 计算多边形的骨架面（单元）。
///
/// Each face corresponds to a polygon edge.
/// 每个面对应一条多边形边。
pub fn skeleton_faces(poly : @core.Polygon) -> Array[Array[@core.Point2D]] {
  let n = poly.size()
  let result : Array[Array[@core.Point2D]] = []
  if n < 3 {
    return result
  }
  let pts = get_points(poly)
  for i in 0..<n {
    let cur = pts[i]
    let next = pts[(i + 1) % n]
    let mid = @core.Point2D::new(
      (cur.x() + next.x()) / 2.0,
      (cur.y() + next.y()) / 2.0,
    )
    let face : Array[@core.Point2D] = [cur, next]
    let dx = next.x() - cur.x()
    let dy = next.y() - cur.y()
    let inward_x = -dy
    let inward_y = dx
    let mut best_t = 1000000.0
    let mut best_p : @core.Point2D? = None
    for j in 0..<n {
      if j == i {
        continue
      }
      let a = pts[j]
      let b = pts[(j + 1) % n]
      let hit = ray_segment_intersect(mid, (inward_x, inward_y), a, b)
      match hit {
        Some(t) =>
          if t > 0.0000001 && t < best_t {
            best_t = t
            best_p = Some(
              @core.Point2D::new(mid.x() + inward_x * t, mid.y() + inward_y * t),
            )
          }
        None => ()
      }
    }
    match best_p {
      Some(p) => {
        face.push(p)
        result.push(face)
      }
      None => result.push(face)
    }
  }
  result
}

///|
fn get_points(poly : @core.Polygon) -> Array[@core.Point2D] {
  let n = poly.size()
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  pts
}

///|
fn angle_bisector(
  prev : @core.Point2D,
  cur : @core.Point2D,
  next : @core.Point2D,
) -> (Double, Double) {
  let dx1 = prev.x() - cur.x()
  let dy1 = prev.y() - cur.y()
  let dx2 = next.x() - cur.x()
  let dy2 = next.y() - cur.y()
  let l1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let l2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if l1 < 0.0000001 || l2 < 0.0000001 {
    return (1.0, 0.0)
  }
  let nx1 = dx1 / l1
  let ny1 = dy1 / l1
  let nx2 = dx2 / l2
  let ny2 = dy2 / l2
  let bx = nx1 + nx2
  let by = ny1 + ny2
  let bl = (bx * bx + by * by).sqrt()
  if bl < 0.0000001 {
    let px = -ny1
    let py = nx1
    let pl = (px * px + py * py).sqrt()
    if pl < 0.0000001 {
      return (1.0, 0.0)
    }
    return (px / pl, py / pl)
  }
  (bx / bl, by / bl)
}

///|
fn ray_segment_intersect(
  origin : @core.Point2D,
  dir : (Double, Double),
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double? {
  let sx = b.x() - a.x()
  let sy = b.y() - a.y()
  let denom = dir.0 * sy - dir.1 * sx
  if denom.abs() < 0.000000001 {
    return None
  }
  let t = ((a.x() - origin.x()) * sy - (a.y() - origin.y()) * sx) / denom
  let u = ((a.x() - origin.x()) * dir.1 - (a.y() - origin.y()) * dir.0) / denom
  if t > 0.0 && u >= 0.0 && u <= 1.0 {
    Some(t)
  } else {
    None
  }
}
