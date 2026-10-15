///|
/// Sutherland-Hodgman polygon clipping by a convex clip polygon.
/// `subject` may be any simple polygon; `clip` must be convex (CCW).
fn sutherland_hodgman(
  subject : Array[Point2D],
  clip : Array[Point2D],
) -> Array[Point2D] {
  let cn = clip.length()
  if cn < 3 {
    return subject.copy()
  }
  let mut output = subject.copy()
  for i in 0..<cn {
    if output.length() == 0 {
      return output
    }
    let edge_a = clip[i]
    let edge_b = clip[(i + 1) % cn]
    let input = output
    let next : Array[Point2D] = []
    let sn = input.length()
    for j in 0..<sn {
      let cur = input[j]
      let prev = input[(j - 1 + sn) % sn]
      let cur_in = is_inside_edge(cur, edge_a, edge_b)
      let prev_in = is_inside_edge(prev, edge_a, edge_b)
      if cur_in {
        if !prev_in {
          match line_intersect_pt(prev, cur, edge_a, edge_b) {
            Some(p) => next.push(p)
            None => ()
          }
        }
        next.push(cur)
      } else if prev_in {
        match line_intersect_pt(prev, cur, edge_a, edge_b) {
          Some(p) => next.push(p)
          None => ()
        }
      }
    }
    output = next
  }
  output
}

///|
/// Whether point p is on the inside (left side) of CCW edge a->b.
fn is_inside_edge(p : Point2D, a : Point2D, b : Point2D) -> Bool {
  turn(a, b, p) >= 0.0
}

///|
/// Intersection point of segment (p1,p2) with line through (p3,p4).
fn line_intersect_pt(
  p1 : Point2D,
  p2 : Point2D,
  p3 : Point2D,
  p4 : Point2D,
) -> Point2D? {
  let r = p2.sub(p1)
  let s = p4.sub(p3)
  let rxs = r.cross(s)
  if rxs == 0.0 {
    return None
  }
  let t = p3.sub(p1).cross(s) / rxs
  Some(Point2D::new(p1.x + t * r.x, p1.y + t * r.y))
}

///|
/// Clip a polygon by an axis-aligned rectangle (Sutherland-Hodgman).
/// Returns the clipped polygon vertices (possibly empty).
pub fn clip_polygon(poly : Polygon, clip_rect : Rectangle) -> Array[Point2D] {
  let clip = [
    Point2D::new(clip_rect.min_x, clip_rect.min_y),
    Point2D::new(clip_rect.max_x, clip_rect.min_y),
    Point2D::new(clip_rect.max_x, clip_rect.max_y),
    Point2D::new(clip_rect.min_x, clip_rect.max_y),
  ]
  sutherland_hodgman(poly.vertices, clip)
}

///|
/// Intersection of two polygons. Uses Sutherland-Hodgman; requires `clip`
/// (the second polygon) to be convex. Returns None if no overlap.
pub fn polygon_intersection(subject : Polygon, clip : Polygon) -> Polygon? {
  let result = sutherland_hodgman(subject.vertices, clip.vertices)
  if result.length() < 3 {
    None
  } else {
    Some(Polygon::new(result))
  }
}

///|
/// Union area of two polygons (via inclusion-exclusion).
/// Returns the combined area; for the union polygon shape use Greiner-Hormann.
pub fn polygon_union_area(p1 : Polygon, p2 : Polygon) -> Double {
  let a1 = polygon_area(p1)
  let a2 = polygon_area(p2)
  let inter = match polygon_intersection(p1, p2) {
    Some(p) => polygon_area(p)
    None => 0.0
  }
  a1 + a2 - inter
}

///|
/// Difference area (p1 minus p2).
pub fn polygon_difference_area(p1 : Polygon, p2 : Polygon) -> Double {
  let a1 = polygon_area(p1)
  let inter = match polygon_intersection(p1, p2) {
    Some(p) => polygon_area(p)
    None => 0.0
  }
  a1 - inter
}
