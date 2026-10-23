///|
/// Centroid of 3D point cloud. / 三维点云质心。
fn centroid3d(points : Array[@core.Point3D]) -> @core.Point3D {
  let n = points.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sz = 0.0
  for p in points {
    sx += p.x
    sy += p.y
    sz += p.z
  }
  let nd = n.to_double()
  @core.Point3D::new(sx / nd, sy / nd, sz / nd)
}


///|
/// Find closest point index in target. / 在目标中找最近点索引。
fn closest_idx(
  target : Array[@core.Point3D],
  p : @core.Point3D,
) -> Int {
  let mut best = 0
  let mut best_d = 1.7976931348623157e+308
  for j in 0..<target.length() {
    let d = p.dist_sq(target[j])
    if d < best_d {
      best_d = d
      best = j
    }
  }
  best
}


///|
/// Apply rotation and translation to a point. / 对点应用旋转和平移。
fn transform_point(
  rot : Array[Double],
  trans : @core.Point3D,
  p : @core.Point3D,
) -> @core.Point3D {
  mat3_vec(rot, p).add(trans)
}
