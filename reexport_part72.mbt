///|
pub fn homography_apply_batch(m : Homography, pts : Array[Point2D]) -> Array[Point2D] {
  @homography.Homography::apply_batch(m, pts)
}

///|
pub fn homography_determinant(m : Homography) -> Double {
  @homography.Homography::determinant(m)
}

// ---------------------------------------------------------------------------
// perspective: perspective transform / 透视变换
// ---------------------------------------------------------------------------

///|
pub type Perspective = @perspective.Perspective

///|
pub fn perspective_new(f : Double, cx : Double, cy : Double, n : Double, fr : Double) -> Perspective {
  @perspective.Perspective::new(f, cx, cy, n, fr)
}

///|
pub fn perspective_project_3d(p : Perspective, pt : Point3D) -> Point2D? {
  @perspective.Perspective::project(p, pt)
}

///|
pub fn perspective_unproject(p : Perspective, pt : Point2D) -> Point3D {
  @perspective.Perspective::unproject(p, pt)
}

///|
pub fn perspective_depth(p : Perspective, pt : Point3D) -> Double {
  @perspective.Perspective::depth(p, pt)
}