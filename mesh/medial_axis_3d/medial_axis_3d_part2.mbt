///|
/// Circumcenter and circumradius of 3 points (in their plane).
/// 三点的外心和外半径（在其平面内）。
fn circumcircle(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
) -> MedialBall3D? {
  let a = p1.sub(p0)
  let b = p2.sub(p0)
  let aa = a.dot(a)
  let bb = b.dot(b)
  let ab = a.dot(b)
  let d = aa * bb - ab * ab
  if d.abs() < 0.000000000001 {
    return None
  }
  let s = bb * (aa - ab) / (2.0 * d)
  let t = aa * (bb - ab) / (2.0 * d)
  let center = p0.add(a.mul(s)).add(b.mul(t))
  let radius = center.dist(p0)
  Some(MedialBall3D::new(center, radius))
}

///|
/// Check if a ball is empty (no point strictly inside).
/// 检查球是否为空（无点严格在内部）。
fn is_empty_ball(
  ball : MedialBall3D,
  points : Array[@core.Point3D],
  eps : Double,
) -> Bool {
  for p in points {
    let d = ball.center.dist(p)
    if d < ball.radius - eps {
      return false
    }
  }
  true
}
