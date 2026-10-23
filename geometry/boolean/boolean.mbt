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
