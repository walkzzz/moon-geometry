///|
/// Sutherland-Hodgman polygon clipping by a convex clip polygon.
/// `subject` may be any simple polygon; `clip` must be convex (CCW).
/// Sutherland-Hodgman 凸裁剪多边形裁剪。
/// `subject` 可为任意简单多边形；`clip` 必须为凸（逆时针）。
fn sutherland_hodgman(
  subject : Array[@core.Point2D],
  clip : Array[@core.Point2D],
) -> Array[@core.Point2D] {
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
    let next : Array[@core.Point2D] = []
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
/// 点 p 是否在 CCW 边 a->b 的内侧（左侧）。
fn is_inside_edge(p : @core.Point2D, a : @core.Point2D, b : @core.Point2D) -> Bool {
  @core.turn(a, b, p) >= 0.0
}

///|
/// Intersection point of segment (p1,p2) with line through (p3,p4).
/// 线段 (p1,p2) 与过 (p3,p4) 直线的交点。
fn line_intersect_pt(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> @core.Point2D? {
  let r = p2.sub(p1)
  let s = p4.sub(p3)
  let rxs = r.cross(s)
  if rxs == 0.0 {
    return None
  }
  let t = p3.sub(p1).cross(s) / rxs
  Some(@core.Point2D::new(p1.x + t * r.x, p1.y + t * r.y))
}

///|
/// Clip a polygon by an axis-aligned rectangle (Sutherland-Hodgman).
/// Returns the clipped polygon vertices (possibly empty).
/// 返回裁剪后的多边形顶点（可能为空）。
pub fn clip_polygon(poly : @core.Polygon, clip_rect : @core.Rectangle) -> Array[@core.Point2D] {
  let clip = [
    @core.Point2D::new(clip_rect.min_x, clip_rect.min_y),
    @core.Point2D::new(clip_rect.max_x, clip_rect.min_y),
    @core.Point2D::new(clip_rect.max_x, clip_rect.max_y),
    @core.Point2D::new(clip_rect.min_x, clip_rect.max_y),
  ]
  sutherland_hodgman(poly.vertices, clip)
}

///|
/// Intersection of two polygons. Uses Sutherland-Hodgman; requires `clip`
/// (the second polygon) to be convex. Returns None if no overlap.
/// 两多边形交集。使用 Sutherland-Hodgman 算法；要求 `clip`
/// （第二个多边形）为凸。无重叠时返回 None。
pub fn polygon_intersection(subject : @core.Polygon, clip : @core.Polygon) -> @core.Polygon? {
  let result = sutherland_hodgman(subject.vertices, clip.vertices)
  if result.length() < 3 {
    None
  } else {
    Some(@core.Polygon::new(result))
  }
}

///|
/// Union area of two polygons (via inclusion-exclusion).
/// Returns the combined area; for the union polygon shape use Greiner-Hormann.
/// 返回合并面积；如需并集多边形形状请用 Greiner-Hormann。
pub fn polygon_union_area(p1 : @core.Polygon, p2 : @core.Polygon) -> Double {
  let a1 = @polygon.polygon_area(p1)
  let a2 = @polygon.polygon_area(p2)
  let inter = match polygon_intersection(p1, p2) {
    Some(p) => @polygon.polygon_area(p)
    None => 0.0
  }
  a1 + a2 - inter
}

///|
/// Difference area (p1 minus p2).
/// 差集面积（p1 减 p2）。
pub fn polygon_difference_area(p1 : @core.Polygon, p2 : @core.Polygon) -> Double {
  let a1 = @polygon.polygon_area(p1)
  let inter = match polygon_intersection(p1, p2) {
    Some(p) => @polygon.polygon_area(p)
    None => 0.0
  }
  a1 - inter
}
