///|
/// Signed area of a polygon using the Shoelace formula.
/// Positive for counter-clockwise, negative for clockwise.
/// 使用 Shoelace 公式计算多边形有符号面积。
/// 逆时针为正，顺时针为负。
pub fn polygon_signed_area(poly : @core.Polygon) -> Double {
  let verts = poly.vertices
  let n = verts.length()
  if n < 3 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += verts[i].x * verts[j].y - verts[j].x * verts[i].y
  }
  sum / 2.0
}

///|
/// Absolute area of a polygon (Shoelace formula).
/// 多边形绝对面积（Shoelace 公式）。
pub fn polygon_area(poly : @core.Polygon) -> Double {
  polygon_signed_area(poly).abs()
}

///|
/// Perimeter of a polygon.
/// 多边形周长。
pub fn polygon_perimeter(poly : @core.Polygon) -> Double {
  let verts = poly.vertices
  let n = verts.length()
  if n < 2 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += verts[i].dist(verts[j])
  }
  sum
}

///|
/// Centroid of a polygon using the weighted-area method.
/// Returns the origin for degenerate polygons.
/// 退化多边形返回原点。
pub fn polygon_centroid(poly : @core.Polygon) -> @core.Point2D {
  let verts = poly.vertices
  let n = verts.length()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  if n == 1 {
    return verts[0]
  }
  if n == 2 {
    return @core.Point2D::new(
      (verts[0].x + verts[1].x) / 2.0,
      (verts[0].y + verts[1].y) / 2.0,
    )
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut area2 = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let cross = verts[i].x * verts[j].y - verts[j].x * verts[i].y
    area2 += cross
    cx += (verts[i].x + verts[j].x) * cross
    cy += (verts[i].y + verts[j].y) * cross
  }
  if area2 == 0.0 {
    // Degenerate: fall back to vertex average
    let mut sx = 0.0
    let mut sy = 0.0
    for v in verts {
      sx += v.x
      sy += v.y
    }
    return @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
  }
  @core.Point2D::new(cx / (3.0 * area2), cy / (3.0 * area2))
}

///|
/// @core.Orientation of a polygon (CW / CCW / @core.Collinear) based on signed area.
/// 基于有符号面积的多边形方向（CW / CCW / Collinear）。
pub fn polygon_orientation(poly : @core.Polygon) -> @core.Orientation {
  let a = polygon_signed_area(poly)
  if a > 0.0 {
    @core.CounterClockwise
  } else if a < 0.0 {
    @core.Clockwise
  } else {
    @core.Collinear
  }
}

///|
/// Whether a polygon is convex.
/// 多边形是否为凸。
pub fn is_convex(poly : @core.Polygon) -> Bool {
  let verts = poly.vertices
  let n = verts.length()
  if n < 3 {
    return false
  }
  let mut sign = 0
  for i in 0..<n {
    let a = verts[i]
    let b = verts[(i + 1) % n]
    let c = verts[(i + 2) % n]
    let cr = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
    if cr == 0.0 {
      // collinear: skip
    } else if cr > 0.0 {
      if sign == 0 {
        sign = 1
      } else if sign != 1 {
        return false
      }
    } else if sign == 0 {
      sign = -1
    } else if sign != -1 {
      return false
    }
  }
  true
}

///|
/// Ray-casting point-in-polygon test.
/// Returns true if the point lies inside or on the boundary.
/// 射线法点在多边形内测试。
/// 点在内部或边界上时返回 true。
pub fn point_in_polygon(p : @core.Point2D, poly : @core.Polygon) -> Bool {
  let verts = poly.vertices
  let n = verts.length()
  if n == 0 {
    return false
  }
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let vi = verts[i]
    let vj = verts[j]
    if (vi.y > p.y) != (vj.y > p.y) {
      let x_intersect = (vj.x - vi.x) * (p.y - vi.y) / (vj.y - vi.y) + vi.x
      if p.x < x_intersect {
        inside = !inside
      }
    }
    j = i
  }
  inside
}

///|
/// Perpendicular distance from point p to line segment (a, b).
/// 点 p 到线段 (a, b) 的垂直距离。
fn point_segment_dist(p : @core.Point2D, a : @core.Point2D, b : @core.Point2D) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  let len_sq = dx * dx + dy * dy
  if len_sq == 0.0 {
    return p.dist(a)
  }
  let t = ((p.x - a.x) * dx + (p.y - a.y) * dy) / len_sq
  let tc = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let proj = @core.Point2D::new(a.x + tc * dx, a.y + tc * dy)
  p.dist(proj)
}

///|
/// Douglas-Peucker polygon simplification.
/// Returns a simplified vertex array preserving shape within `epsilon`.
/// 返回在 `epsilon` 精度内保持形状的简化顶点数组。
pub fn simplify_polygon(poly : @core.Polygon, epsilon : Double) -> Array[@core.Point2D] {
  let verts = poly.vertices
  let n = verts.length()
  if n <= 2 {
    return verts.copy()
  }
  let keep = Array::make(n, false)
  keep[0] = true
  keep[n - 1] = true
  dp_recursive(verts, 0, n - 1, epsilon, keep)
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    if keep[i] {
      result.push(verts[i])
    }
  }
  result
}

///|
/// Recursive core of Douglas-Peucker.
/// Douglas-Peucker 递归核心。
fn dp_recursive(
  pts : Array[@core.Point2D],
  start : Int,
  end : Int,
  epsilon : Double,
  keep : Array[Bool],
) -> Unit {
  if end <= start + 1 {
    return
  }
  let mut max_dist = 0.0
  let mut max_idx = start
  for i in (start + 1)..<end {
    let d = point_segment_dist(pts[i], pts[start], pts[end])
    if d > max_dist {
      max_dist = d
      max_idx = i
    }
  }
  if max_dist > epsilon {
    keep[max_idx] = true
    dp_recursive(pts, start, max_idx, epsilon, keep)
    dp_recursive(pts, max_idx, end, epsilon, keep)
  }
}
