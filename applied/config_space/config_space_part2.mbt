///|
/// Get the i-th vertex. / 获取第 i 个顶点。
pub fn CSpaceObstacle::get(self : CSpaceObstacle, i : Int) -> @core.Point2D {
  self.vertices[i]
}
