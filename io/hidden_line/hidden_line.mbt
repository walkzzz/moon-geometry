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
  { start, end, }
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

///|
/// Check if a 2D point lies inside a 2D triangle.
/// 检查二维点是否在二维三角形内。
pub fn point_in_triangle_2d(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let eps = 0.0000001
  let d1 = sign2(p, a, b)
  let d2 = sign2(p, b, c)
  let d3 = sign2(p, c, a)
  let has_neg = d1 < -eps || d2 < -eps || d3 < -eps
  let has_pos = d1 > eps || d2 > eps || d3 > eps
  !(has_neg && has_pos)
}

///|
fn sign2(p : @core.Point2D, a : @core.Point2D, b : @core.Point2D) -> Double {
  (p.x() - b.x()) * (a.y() - b.y()) - (a.x() - b.x()) * (p.y() - b.y())
}

///|
/// Interpolate z on a triangle at (x, y) using barycentric coordinates.
/// 用重心坐标在三角形上插值 (x, y) 处的 z。
pub fn triangle_z_at(
  tri : (@core.Point3D, @core.Point3D, @core.Point3D),
  x : Double,
  y : Double,
) -> Double? {
  let eps = 0.0000001
  let (a, b, c) = tri
  let det = (b.y - a.y) * (c.x - a.x) - (b.x - a.x) * (c.y - a.y)
  if det > -eps && det < eps {
    return None
  }
  let l1 = ((b.y - a.y) * (x - a.x) - (b.x - a.x) * (y - a.y)) / det
  let l2 = ((a.y - c.y) * (x - a.x) - (a.x - c.x) * (y - a.y)) / det
  let l3 = 1.0 - l1 - l2
  if l1 < -eps || l2 < -eps || l3 < -eps {
    return None
  }
  Some(l1 * a.z + l2 * b.z + l3 * c.z)
}

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
