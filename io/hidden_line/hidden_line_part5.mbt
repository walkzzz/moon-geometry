///|
/// Count visible segments. / 统计可见线段数。
pub fn count_visible(
  segments : Array[LineSeg3D],
  triangles : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
) -> Int32 {
  hidden_line_remove(segments, triangles).length()
}

///|
/// Roberts-style back-face cull: remove faces pointing away from viewer.
/// Roberts 风格背面剔除：移除背向观察者的面。
pub fn back_face_cull(
  triangles : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
  view_dir : @core.Point3D,
) -> Array[(@core.Point3D, @core.Point3D, @core.Point3D)] {
  let result : Array[(@core.Point3D, @core.Point3D, @core.Point3D)] = []
  for tri in triangles {
    let edge1 = tri.1.sub(tri.0)
    let edge2 = tri.2.sub(tri.0)
    let normal = edge1.cross(edge2)
    if normal.dot(view_dir) < 0.0 {
      result.push(tri)
    }
  }
  result
}
