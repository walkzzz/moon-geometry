///|
/// Buffer a polyline (array of points) by union of segment buffers. / 缓冲折线（点数组），取各段缓冲的并集顶点。
pub fn polyline_buffer(
  points : Array[@core.Point2D],
  radius : Double,
  cap_segments : Int32,
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
