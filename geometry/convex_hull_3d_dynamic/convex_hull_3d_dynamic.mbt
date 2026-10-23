///|
/// Dynamic 3D convex hull supporting incremental insertion. / 动态3D凸包，支持增量插入。
pub struct DynamicHull3D {
  points : Array[@core.Point3D]
  mut hull_faces : Array[(Int, Int, Int)]
}


///|
pub extend DynamicHull3D with @core.FaceCountable::{face_count}


///|
/// Construct empty dynamic hull. / 构造空动态凸包。
pub fn DynamicHull3D::new() -> DynamicHull3D {
  { points: [], hull_faces: [] }
}


///|
/// Number of points. / 点数。
pub fn DynamicHull3D::size(h : DynamicHull3D) -> Int {
  h.points.length()
}


///|
/// Number of hull faces. / 凸包面数。
pub impl @core.FaceCountable for DynamicHull3D with face_count(self) {
  self.hull_faces.length()
}


///|
/// Get hull faces. / 获取凸包面。
pub fn DynamicHull3D::faces(h : DynamicHull3D) -> Array[(Int, Int, Int)] {
  h.hull_faces
}
