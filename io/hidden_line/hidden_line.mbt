///|
/// 3D line segment for hidden line removal.
/// 隐藏线消除用的三维线段。
pub struct LineSeg3D {
  start : @core.Point3D
  end : @core.Point3D
}


///|
/// Construct a 3D line segment. / 构造三维线段。
pub fn LineSeg3D::new(start : @core.Point3D, end : @core.Point3D) -> LineSeg3D {
  { start, end }
}


///|
/// Orthographic projection of a 3D point to 2D (drops z).
/// 正交投影三维点到二维（忽略 z）。
pub fn project_to_2d(p : @core.Point3D) -> @core.Point2D {
  @core.Point2D::new(p.x, p.y)
}


///|
/// Project a 3D segment to 2D. / 投影三维线段到二维。
pub fn project_segment(s : LineSeg3D) -> (@core.Point2D, @core.Point2D) {
  (project_to_2d(s.start), project_to_2d(s.end))
}
