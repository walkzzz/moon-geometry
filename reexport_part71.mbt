///|
pub fn isometric(p : Point3D) -> Point2D {
  @project3d.isometric(p)
}

///|
pub fn oblique(p : Point3D, alpha : Double, beta : Double) -> Point2D {
  @project3d.oblique(p, alpha, beta)
}

// ---------------------------------------------------------------------------
// homography: 3x3 projective transform / 单应变换
// ---------------------------------------------------------------------------

///|
pub type Homography = @homography.Homography

///|
pub fn homography_identity() -> Homography {
  @homography.Homography::identity()
}

///|
pub fn homography_from_array(h : Array[Double]) -> Homography {
  @homography.Homography::from_array(h)
}

///|
pub fn homography_apply(m : Homography, p : Point2D) -> Point2D? {
  @homography.Homography::apply(m, p)
}

///|
pub fn homography_compose(m1 : Homography, m2 : Homography) -> Homography {
  @homography.Homography::compose(m1, m2)
}