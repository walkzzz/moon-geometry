///|
/// Buffer a line segment into a rectangle with rounded ends. / 将线段缓冲为带圆端的矩形。
/// cap_segments: number of segments per rounded end. / cap_segments: 每个圆端的段数。
pub fn segment_buffer(
  a : @core.Point2D,
  b : @core.Point2D,
  radius : Double,
  cap_segments : Int,
) -> @core.Polygon {
  let dx = b.x - a.x
  let dy = b.y - a.y
  let len = (dx * dx + dy * dy).sqrt()
  if len < 0.0000000001 {
    return point_buffer(a, radius, cap_segments * 2)
  }
  let nx = -dy / len
  let ny = dx / len
  let segs = if cap_segments < 1 { 4 } else { cap_segments }
  let verts : Array[@core.Point2D] = []
  // right side: from a+radius*n to b+radius*n, then arc at b
  let p1 = @core.Point2D::new(a.x + radius * nx, a.y + radius * ny)
  let p2 = @core.Point2D::new(b.x + radius * nx, b.y + radius * ny)
  verts.push(p1)
  verts.push(p2)
  // arc at b end (from angle of n to angle of -n)
  let base_angle_b = @math.atan2(ny, nx)
  for i in 1..<segs {
    let t = i.to_double() / segs.to_double()
    let angle = base_angle_b + t * @math.PI
    verts.push(@core.Point2D::new(b.x + radius * @math.cos(angle), b.y + radius * @math.sin(angle)))
  }
  // left side
  let p3 = @core.Point2D::new(b.x - radius * nx, b.y - radius * ny)
  let p4 = @core.Point2D::new(a.x - radius * nx, a.y - radius * ny)
  verts.push(p3)
  verts.push(p4)
  // arc at a end
  let base_angle_a = @math.atan2(-ny, -nx)
  for i in 1..<segs {
    let t = i.to_double() / segs.to_double()
    let angle = base_angle_a + t * @math.PI
    verts.push(@core.Point2D::new(a.x + radius * @math.cos(angle), a.y + radius * @math.sin(angle)))
  }
  @core.Polygon::new(verts)
}
