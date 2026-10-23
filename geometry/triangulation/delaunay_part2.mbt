///|
/// In-circumcircle test via determinant. Assumes triangle (a,b,c) is CCW.
/// 通过行列式进行外接圆判定。假设三角形 (a,b,c) 为逆时针。
/// Returns true if point d lies strictly inside the circumcircle of a,b,c.
/// 当点 d 严格在 a,b,c 外接圆内时返回 true。
fn in_circumcircle(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  d : @core.Point2D,
) -> Bool {
  let ax = a.x - d.x
  let ay = a.y - d.y
  let bx = b.x - d.x
  let by = b.y - d.y
  let cx = c.x - d.x
  let cy = c.y - d.y
  let aa = ax * ax + ay * ay
  let bb = bx * bx + by * by
  let cc = cx * cx + cy * cy
  let det = ax * (by * cc - cy * bb) -
    ay * (bx * cc - cx * bb) +
    aa * (bx * cy - by * cx)
  det > 0.0
}


///|
/// Build a triangle from indices, ensuring CCW orientation.
/// 从索引构造三角形，确保逆时针方向。
fn make_tri_ccw(
  i : Int,
  j : Int,
  k : Int,
  pts : Array[@core.Point2D],
) -> TriangleIdx {
  if @core.turn(pts[i], pts[j], pts[k]) < 0.0 {
    { a: i, b: k, c: j, }
  } else {
    { a: i, b: j, c: k, }
  }
}
