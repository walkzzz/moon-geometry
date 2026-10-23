///|
/// Add a point and recompute hull. / 添加点并重新计算凸包。
pub fn DynamicHull3D::insert(h : DynamicHull3D, p : @core.Point3D) -> Unit {
  h.points.push(p)
  h.hull_faces = compute_hull_3d(h.points)
}


///|
/// Get vertices of the hull. / 获取凸包顶点。
pub fn DynamicHull3D::vertices(h : DynamicHull3D) -> Array[@core.Point3D] {
  h.points
}
