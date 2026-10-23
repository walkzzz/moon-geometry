///|
pub fn perspective_fov(p : Perspective, w : Double) -> Double {
  @perspective.Perspective::fov(p, w)
}

///|
pub fn focal_from_fov(fov : Double, w : Double) -> Double {
  @perspective.focal_from_fov(fov, w)
}

// ---------------------------------------------------------------------------
// stereographic: stereographic projection / 球极投影
// ---------------------------------------------------------------------------

///|
pub fn stereographic_from_sphere(p : Point3D, r : Double) -> Point2D? {
  @stereographic.stereographic_from_sphere(p, r)
}

///|
pub fn stereographic_to_sphere(p : Point2D, r : Double) -> Point3D {
  @stereographic.stereographic_to_sphere(p, r)
}

///|
pub fn stereographic_from_south(p : Point3D, r : Double) -> Point2D? {
  @stereographic.stereographic_from_south(p, r)
}

///|
pub fn on_sphere(p : Point3D, r : Double) -> Bool {
  @stereographic.on_sphere(p, r)
}

///|
pub fn stereographic_scale(p : Point3D, r : Double) -> Double {
  @stereographic.stereographic_scale(p, r)
}

// ---------------------------------------------------------------------------
// affine2: 2D affine transform / 二维仿射变换
// ---------------------------------------------------------------------------