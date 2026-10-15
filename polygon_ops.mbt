///|
/// Signed area of a polygon using the Shoelace formula.
/// Positive for counter-clockwise, negative for clockwise.
pub fn polygon_signed_area(poly : Polygon) -> Double {
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
pub fn polygon_area(poly : Polygon) -> Double {
  polygon_signed_area(poly).abs()
}

///|
/// Perimeter of a polygon.
pub fn polygon_perimeter(poly : Polygon) -> Double {
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
pub fn polygon_centroid(poly : Polygon) -> Point2D {
  let verts = poly.vertices
  let n = verts.length()
  if n == 0 {
    return Point2D::new(0.0, 0.0)
  }
  if n == 1 {
    return verts[0]
  }
  if n == 2 {
    return Point2D::new(
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
    return Point2D::new(sx / n.to_double(), sy / n.to_double())
  }
  Point2D::new(cx / (3.0 * area2), cy / (3.0 * area2))
}

///|
/// Orientation of a polygon (CW / CCW / Collinear) based on signed area.
pub fn polygon_orientation(poly : Polygon) -> Orientation {
  let a = polygon_signed_area(poly)
  if a > 0.0 {
    CounterClockwise
  } else if a < 0.0 {
    Clockwise
  } else {
    Collinear
  }
}

///|
/// Whether a polygon is convex.
pub fn is_convex(poly : Polygon) -> Bool {
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
pub fn point_in_polygon(p : Point2D, poly : Polygon) -> Bool {
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
fn point_segment_dist(p : Point2D, a : Point2D, b : Point2D) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  let len_sq = dx * dx + dy * dy
  if len_sq == 0.0 {
    return p.dist(a)
  }
  let t = ((p.x - a.x) * dx + (p.y - a.y) * dy) / len_sq
  let tc = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let proj = Point2D::new(a.x + tc * dx, a.y + tc * dy)
  p.dist(proj)
}

///|
/// Douglas-Peucker polygon simplification.
/// Returns a simplified vertex array preserving shape within `epsilon`.
pub fn simplify_polygon(poly : Polygon, epsilon : Double) -> Array[Point2D] {
  let verts = poly.vertices
  let n = verts.length()
  if n <= 2 {
    return verts.copy()
  }
  let keep = Array::make(n, false)
  keep[0] = true
  keep[n - 1] = true
  dp_recursive(verts, 0, n - 1, epsilon, keep)
  let result : Array[Point2D] = []
  for i in 0..<n {
    if keep[i] {
      result.push(verts[i])
    }
  }
  result
}

///|
/// Recursive core of Douglas-Peucker.
fn dp_recursive(
  pts : Array[Point2D],
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
