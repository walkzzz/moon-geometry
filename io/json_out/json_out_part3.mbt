///|
/// Export a complete geometry scene as JSON. / 将完整几何场景导出为 JSON。
pub fn scene_to_json(
  points : Array[@core.Point2D],
  segments : Array[@core.Segment],
  circles : Array[@core.Circle],
) -> String {
  let mut pts = "["
  for i in 0..<points.length() {
    pts += point2d_to_json(points[i])
    if i < points.length() - 1 {
      pts += ","
    }
  }
  pts += "]"
  let mut segs = "["
  for i in 0..<segments.length() {
    segs += segment_to_json(segments[i])
    if i < segments.length() - 1 {
      segs += ","
    }
  }
  segs += "]"
  let mut circs = "["
  for i in 0..<circles.length() {
    circs += circle_to_json(circles[i])
    if i < circles.length() - 1 {
      circs += ","
    }
  }
  circs += "]"
  "{\"points\":" + pts + ",\"segments\":" + segs + ",\"circles\":" + circs + "}"
}
