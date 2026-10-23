///|
/// Hidden line removal via z-buffer test. Returns visible 2D segments.
/// 通过 z 缓冲测试的隐藏线消除。返回可见二维线段。
pub fn hidden_line_remove(
  segments : Array[LineSeg3D],
  triangles : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
) -> Array[(@core.Point2D, @core.Point2D)] {
  let result : Array[(@core.Point2D, @core.Point2D)] = []
  let eps = 0.0001
  for seg in segments {
    let mid = @core.Point3D::new(
      (seg.start.x + seg.end.x) / 2.0,
      (seg.start.y + seg.end.y) / 2.0,
      (seg.start.z + seg.end.z) / 2.0,
    )
    let mut occluded = false
    for tri in triangles {
      let p2 = @core.Point2D::new(mid.x, mid.y)
      let a2 = @core.Point2D::new(tri.0.x, tri.0.y)
      let b2 = @core.Point2D::new(tri.1.x, tri.1.y)
      let c2 = @core.Point2D::new(tri.2.x, tri.2.y)
      if point_in_triangle_2d(p2, a2, b2, c2) {
        match triangle_z_at(tri, mid.x, mid.y) {
          Some(tz) => if tz > mid.z + eps { occluded = true }
          None => ()
        }
      }
      if occluded {
        break
      }
    }
    if !occluded {
      result.push((project_to_2d(seg.start), project_to_2d(seg.end)))
    }
  }
  result
}
