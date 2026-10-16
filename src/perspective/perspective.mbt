///|
/// Perspective transformation parameters. / 透视变换参数。
pub struct Perspective {
  focal : Double
  cx : Double
  cy : Double
  near : Double
  far : Double
}

///|
/// Create a perspective transformation. / 创建透视变换。
pub fn Perspective::new(
  focal : Double,
  cx : Double,
  cy : Double,
  near : Double,
  far : Double,
) -> Perspective {
  { focal, cx, cy, near, far }
}

///|
/// Project a 3D point through perspective transformation. / 通过透视变换投影三维点。
pub fn Perspective::project(
  persp : Perspective,
  p : @core.Point3D,
) -> @core.Point2D? {
  if p.z <= persp.near || p.z >= persp.far {
    return None
  }
  let x = persp.focal * p.x / p.z + persp.cx
  let y = persp.focal * p.y / p.z + persp.cy
  Some(@core.Point2D::new(x, y))
}

///|
/// Unproject a 2D point to a 3D ray direction. / 将二维点反投影为三维射线方向。
pub fn Perspective::unproject(
  persp : Perspective,
  p : @core.Point2D,
) -> @core.Point3D {
  let x = (p.x() - persp.cx) / persp.focal
  let y = (p.y() - persp.cy) / persp.focal
  @core.Point3D::new(x, y, 1.0)
}

///|
/// Compute depth value for a 3D point. / 计算三维点的深度值。
pub fn Perspective::depth(
  persp : Perspective,
  p : @core.Point3D,
) -> Double {
  let z = p.z
  (persp.far + persp.near) / (persp.far - persp.near) -
  2.0 * persp.far * persp.near / ((persp.far - persp.near) * z)
}

///|
/// Field of view from focal length and image width. / 由焦距和图像宽度计算视场角。
pub fn Perspective::fov(
  persp : Perspective,
  width : Double,
) -> Double {
  2.0 * @math.atan(width / (2.0 * persp.focal))
}

///|
/// Focal length from field of view and image width. / 由视场角和图像宽度计算焦距。
pub fn focal_from_fov(fov : Double, width : Double) -> Double {
  width / (2.0 * @math.tan(fov / 2.0))
}