///|
/// Rodrigues' rotation formula: rotation matrix from axis-angle.
/// Rodrigues 旋转公式：由轴角构造旋转矩阵。
fn rodrigues(w : @core.Point3D) -> Array[Double] {
  let angle = (w.x * w.x + w.y * w.y + w.z * w.z).sqrt()
  if angle < 0.000000000001 {
    return mat3_identity()
  }
  let ax = w.x / angle
  let ay = w.y / angle
  let az = w.z / angle
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  let omc = 1.0 - c
  [
    c + ax * ax * omc,
    ax * ay * omc - az * s,
    ax * az * omc + ay * s,
    ay * ax * omc + az * s,
    c + ay * ay * omc,
    ay * az * omc - ax * s,
    az * ax * omc - ay * s,
    az * ay * omc + ax * s,
    c + az * az * omc,
  ]
}
