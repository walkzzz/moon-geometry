/// |
/// # Medial Axis Approximation
/// # 中轴线近似
///
/// Approximate the medial axis of a simple polygon by sampling
/// interior points and finding those equidistant from two or more edges.
/// 通过采样内部点并找到与两条或多条边等距的点来近似简单多边形的中轴线。
///
/// ## Complexity: O(n × s²) where s = sample count
/// ## 复杂度: O(n × s²)，s = 采样数

///|
/// |
/// Compute approximate medial axis as segments.
/// 计算近似中轴线，返回线段数组。
///
/// # Arguments / 参数
/// - `poly`: input polygon / 输入多边形
/// - `resolution`: grid resolution for sampling / 采样网格分辨率
pub fn medial_axis(
  poly : @core.Polygon,
  resolution : Int32,
) -> Array[@core.Segment] {
  let n = poly.size()
  let result : Array[@core.Segment] = []
  if n < 3 || resolution < 2 {
    return result
  }
  let pts = get_points(poly)
  let mut min_x = 1000000.0
  let mut max_x = -1000000.0
  let mut min_y = 1000000.0
  let mut max_y = -1000000.0
  for i in 0..<n {
    let p = pts[i]
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  let dx = (max_x - min_x) / resolution.to_double()
  let dy = (max_y - min_y) / resolution.to_double()
  let step = if dx < dy { dx } else { dy }
  let medial_pts : Array[@core.Point2D] = []
  let mut i = 0
  while i < resolution {
    let mut j = 0
    while j < resolution {
      let px = min_x + i.to_double() * step
      let py = min_y + j.to_double() * step
      let p = @core.Point2D::new(px, py)
      if is_interior(p, pts) {
        let (d1, d2) = two_nearest_edge_dist(p, pts)
        if (d2 - d1).abs() < step * 0.5 {
          medial_pts.push(p)
        }
      }
      j += 1
    }
    i += 1
  }
  let m = medial_pts.length()
  for a in 0..<m {
    for b in (a + 1)..<m {
      let pa = medial_pts[a]
      let pb = medial_pts[b]
      let dist = ((pa.x() - pb.x()) * (pa.x() - pb.x()) +
      (pa.y() - pb.y()) * (pa.y() - pb.y())).sqrt()
      if dist < step * 1.8 {
        result.push(@core.Segment::new(pa, pb))
      }
    }
  }
  result
}

///|
/// |
/// Sample points on the medial axis.
/// 在中轴线上采样点。
///
/// # Arguments / 参数
/// - `poly`: input polygon / 输入多边形
/// - `n_samples`: number of sample points / 采样点数
pub fn medial_axis_points(
  poly : @core.Polygon,
  n_samples : Int32,
) -> Array[@core.Point2D] {
  let n = poly.size()
  let result : Array[@core.Point2D] = []
  if n < 3 || n_samples < 1 {
    return result
  }
  let pts = get_points(poly)
  let mut min_x = 1000000.0
  let mut max_x = -1000000.0
  let mut min_y = 1000000.0
  let mut max_y = -1000000.0
  for i in 0..<n {
    let p = pts[i]
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  let res = (n_samples * 2).to_double().sqrt().to_int() + 1
  let dx = (max_x - min_x) / res.to_double()
  let dy = (max_y - min_y) / res.to_double()
  let step = if dx < dy { dx } else { dy }
  let candidates : Array[(@core.Point2D, Double)] = []
  let mut i = 0
  while i < res {
    let mut j = 0
    while j < res {
      let px = min_x + i.to_double() * step
      let py = min_y + j.to_double() * step
      let p = @core.Point2D::new(px, py)
      if is_interior(p, pts) {
        let (d1, _) = two_nearest_edge_dist(p, pts)
        candidates.push((p, d1))
      }
      j += 1
    }
    i += 1
  }
  candidates.sort_by(fn(a, b) {
    if a.1 > b.1 {
      -1
    } else if a.1 < b.1 {
      1
    } else {
      0
    }
  })
  let count = if candidates.length() < n_samples {
    candidates.length()
  } else {
    n_samples
  }
  for k in 0..<count {
    result.push(candidates[k].0)
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
fn is_interior(p : @core.Point2D, pts : Array[@core.Point2D]) -> Bool {
  let n = pts.length()
  let mut count = 0
  for i in 0..<n {
    let a = pts[i]
    let b = pts[(i + 1) % n]
    if a.y() <= p.y() {
      if b.y() > p.y() {
        if @core.turn(a, b, p) > 0.0 {
          count += 1
        }
      }
    } else if b.y() <= p.y() {
      if @core.turn(a, b, p) < 0.0 {
        count -= 1
      }
    }
  }
  count != 0
}

///|
fn point_seg_dist(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len_sq = dx * dx + dy * dy
  if len_sq < 0.0000000001 {
    return ((p.x() - a.x()) * (p.x() - a.x()) +
    (p.y() - a.y()) * (p.y() - a.y())).sqrt()
  }
  let t = ((p.x() - a.x()) * dx + (p.y() - a.y()) * dy) / len_sq
  let tc = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let cx = a.x() + tc * dx
  let cy = a.y() + tc * dy
  ((p.x() - cx) * (p.x() - cx) + (p.y() - cy) * (p.y() - cy)).sqrt()
}

///|
fn two_nearest_edge_dist(
  p : @core.Point2D,
  pts : Array[@core.Point2D],
) -> (Double, Double) {
  let n = pts.length()
  let mut d1 = 1000000.0
  let mut d2 = 1000000.0
  for i in 0..<n {
    let d = point_seg_dist(p, pts[i], pts[(i + 1) % n])
    if d < d1 {
      d2 = d1
      d1 = d
    } else if d < d2 {
      d2 = d
    }
  }
  (d1, d2)
}
