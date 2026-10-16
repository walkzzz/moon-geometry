///|
/// Project a 3D point to 2D using orthographic projection (drop z). / 正交投影：将三维点投影到二维（丢弃 z）。
pub fn orthographic(p : @core.Point3D) -> @core.Point2D {
  @core.Point2D::new(p.x, p.y)
}

///|
/// Project a 3D point to 2D using perspective projection with focal length f. / 透视投影：以焦距 f 将三维点投影到二维。
pub fn perspective_project(
  p : @core.Point3D,
  f : Double,
) -> @core.Point2D? {
  if @core.approx_eq(p.z, 0.0, 0.000000001) {
    return None
  }
  Some(@core.Point2D::new(f * p.x / p.z, f * p.y / p.z))
}

///|
/// Project an array of 3D points to 2D using orthographic projection. / 正交投影：将三维点数组投影到二维。
pub fn orthographic_batch(
  points : Array[@core.Point3D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    result.push(orthographic(p))
  }
  result
}

///|
/// Project an array of 3D points to 2D using perspective projection. / 透视投影：将三维点数组投影到二维。
pub fn perspective_batch(
  points : Array[@core.Point3D],
  f : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    match perspective_project(p, f) {
      Some(pt) => result.push(pt)
      None => continue
    }
  }
  result
}

///|
/// Project a 3D point onto a plane defined by normal and distance. / 将三维点投影到由法向量和距离定义的平面。
pub fn project_to_plane(
  p : @core.Point3D,
  normal : @core.Point3D,
  d : Double,
) -> @core.Point3D {
  let denom = normal.dot(normal)
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return p
  }
  let t = (normal.dot(p) + d) / denom
  @core.Point3D::new(p.x - t * normal.x, p.y - t * normal.y, p.z - t * normal.z)
}

///|
/// Isometric projection of a 3D point to 2D. / 三维点到二维的等距投影。
pub fn isometric(p : @core.Point3D) -> @core.Point2D {
  let s = 0.8660254037844387
  let h = 0.5
  @core.Point2D::new(s * (p.x - p.y), h * (p.x + p.y) - p.z)
}

///|
/// Oblique projection with angles alpha and beta. / 以角度 alpha 和 beta 的斜投影。
pub fn oblique(
  p : @core.Point3D,
  alpha : Double,
  beta : Double,
) -> @core.Point2D {
  @core.Point2D::new(p.x + p.z * @math.cos(alpha), p.y + p.z * @math.sin(beta))
}