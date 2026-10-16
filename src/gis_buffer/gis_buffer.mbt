///|
/// Buffer a point into a circular polygon (n segments). / 将点缓冲为圆形多边形（n 段）。
pub fn point_buffer(
  center : @core.Point2D,
  radius : Double,
  n : Int,
) -> @core.Polygon {
  let verts : Array[@core.Point2D] = []
  let segs = if n < 3 { 3 } else { n }
  for i in 0..<segs {
    let angle = 2.0 * @math.PI * i.to_double() / segs.to_double()
    let px = center.x + radius * @math.cos(angle)
    let py = center.y + radius * @math.sin(angle)
    verts.push(@core.Point2D::new(px, py))
  }
  @core.Polygon::new(verts)
}

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

///|
/// Buffer a polyline (array of points) by union of segment buffers. / 缓冲折线（点数组），取各段缓冲的并集顶点。
pub fn polyline_buffer(
  points : Array[@core.Point2D],
  radius : Double,
  cap_segments : Int,
) -> @core.Polygon {
  let n = points.length()
  if n == 0 {
    return @core.Polygon::new([])
  }
  if n == 1 {
    return point_buffer(points[0], radius, cap_segments * 2)
  }
  let all_verts : Array[@core.Point2D] = []
  for i in 0..<(n - 1) {
    let buf = segment_buffer(points[i], points[i + 1], radius, cap_segments)
    for j in 0..<buf.size() {
      all_verts.push(buf.get(j))
    }
  }
  @core.Polygon::new(all_verts)
}

///|
/// Minkowski sum of two convex polygons (both CCW). / 两个凸多边形（均为逆时针）的 Minkowski 和。
pub fn minkowski_sum_convex(
  poly_a : @core.Polygon,
  poly_b : @core.Polygon,
) -> @core.Polygon {
  let na = poly_a.size()
  let nb = poly_b.size()
  if na == 0 || nb == 0 {
    return @core.Polygon::new([])
  }
  let result : Array[@core.Point2D] = []
  let mut ia = 0
  let mut ib = 0
  let mut count = 0
  let total = na + nb
  while count < total {
    let pa = poly_a.get(ia)
    let pb = poly_b.get(ib)
    result.push(@core.Point2D::new(pa.x + pb.x, pa.y + pb.y))
    let ea = poly_a.get(ia + 1).sub(poly_a.get(ia))
    let eb = poly_b.get(ib + 1).sub(poly_b.get(ib))
    let cross = ea.x * eb.y - ea.y * eb.x
    if cross > 0.0 {
      ia = (ia + 1) % na
    } else if cross < 0.0 {
      ib = (ib + 1) % nb
    } else {
      ia = (ia + 1) % na
      ib = (ib + 1) % nb
    }
    count += 1
  }
  @core.Polygon::new(result)
}

///|
/// Buffer a convex polygon by Minkowski sum with a disk (approximated by n-gon). / 通过与圆盘（n 边形近似）的 Minkowski 和缓冲凸多边形。
pub fn convex_polygon_buffer(
  poly : @core.Polygon,
  radius : Double,
  n : Int,
) -> @core.Polygon {
  let disk = point_buffer(@core.Point2D::new(0.0, 0.0), radius, n)
  minkowski_sum_convex(poly, disk)
}

///|
/// Buffer area (polygon) by offsetting all edges outward by radius. / 面缓冲：将所有边向外偏移 radius。
/// Returns offset vertices (simple offset, not self-intersection safe). / 返回偏移顶点（简单偏移，不处理自交）。
pub fn polygon_offset_buffer(
  poly : @core.Polygon,
  radius : Double,
) -> @core.Polygon {
  let n = poly.size()
  if n == 0 {
    return @core.Polygon::new([])
  }
  let verts : Array[@core.Point2D] = []
  for i in 0..<n {
    let prev = poly.get(i - 1)
    let curr = poly.get(i)
    let next = poly.get(i + 1)
    let e1 = curr.sub(prev)
    let e2 = next.sub(curr)
    let l1 = (e1.x * e1.x + e1.y * e1.y).sqrt()
    let l2 = (e2.x * e2.x + e2.y * e2.y).sqrt()
    if l1 < 0.0000000001 || l2 < 0.0000000001 {
      verts.push(curr)
      continue
    }
    let n1x = -e1.y / l1
    let n1y = e1.x / l1
    let n2x = -e2.y / l2
    let n2y = e2.x / l2
    let nx = n1x + n2x
    let ny = n1y + n2y
    let nlen = (nx * nx + ny * ny).sqrt()
    if nlen < 0.0000000001 {
      verts.push(@core.Point2D::new(curr.x + radius * n1x, curr.y + radius * n1y))
    } else {
      let scale = radius / nlen
      verts.push(@core.Point2D::new(curr.x + scale * nx, curr.y + scale * ny))
    }
  }
  @core.Polygon::new(verts)
}