///|
/// Solve 2D LP: maximize cx*x + cy*y subject to a_i*x + b_i*y <= c_i. / 求解二维线性规划。
pub fn linear_program_2d(
  constraints : Array[(Double, Double, Double)],
  cx : Double,
  cy : Double,
) -> LPResult? {
  let big = 100000.0
  let vertices : Array[@core.Point2D] = [
    @core.Point2D::new(-big, -big),
    @core.Point2D::new(big, -big),
    @core.Point2D::new(big, big),
    @core.Point2D::new(-big, big),
  ]
  let mut feasible = vertices
  for i in 0..<constraints.length() {
    let (a, b, c) = constraints[i]
    feasible = lp_clip(feasible, a, b, c)
    if feasible.length() == 0 {
      return None
    }
  }
  let mut best_val = -999999999.0
  let mut best_pt : @core.Point2D? = None
  for i in 0..<feasible.length() {
    let v = cx * feasible[i].x() + cy * feasible[i].y()
    if v > best_val {
      best_val = v
      best_pt = Some(feasible[i])
    }
  }
  match best_pt {
    Some(p) => Some({ point: p, value: best_val, })
    None => None
  }
}

///|
fn lp_clip(
  poly : Array[@core.Point2D],
  a : Double,
  b : Double,
  c : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let cur = poly[i]
    let nxt = poly[(i + 1) % n]
    let cur_val = a * cur.x() + b * cur.y() - c
    let nxt_val = a * nxt.x() + b * nxt.y() - c
    let cur_in = cur_val <= 0.0
    let nxt_in = nxt_val <= 0.0
    if cur_in {
      result.push(cur)
    }
    if cur_in != nxt_in {
      let t = cur_val / (cur_val - nxt_val)
      result.push(
        @core.Point2D::new(
          cur.x() + (nxt.x() - cur.x()) * t,
          cur.y() + (nxt.y() - cur.y()) * t,
        ),
      )
    }
  }
  result
}
