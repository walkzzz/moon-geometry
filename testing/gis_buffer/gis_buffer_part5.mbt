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