///|
/// Compute the number of faces using Euler's formula (F = E - V + 2 for connected planar graphs). / 用欧拉公式计算面数（连通平面图 F = E - V + 2）。
pub impl @core.FaceCountable for PlanarGraph with fn face_count(self) {
  if self.is_connected() {
    self.edges.length() - self.vertices.length() + 2
  } else {
    0
  }
}
