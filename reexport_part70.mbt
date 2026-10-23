///|
pub fn zone_complexity(z : Zone) -> Int {
  @zone.zone_complexity(z)
}

///|
pub fn zone_complexity_bound(n : Int) -> Int {
  @zone.zone_complexity_bound(n)
}

// ---------------------------------------------------------------------------
// project3d: 3D projection / 三维投影
// ---------------------------------------------------------------------------

///|
pub fn orthographic(p : Point3D) -> Point2D {
  @project3d.orthographic(p)
}

///|
pub fn perspective_project(p : Point3D, f : Double) -> Point2D? {
  @project3d.perspective_project(p, f)
}

///|
pub fn orthographic_batch(pts : Array[Point3D]) -> Array[Point2D] {
  @project3d.orthographic_batch(pts)
}

///|
pub fn perspective_batch(pts : Array[Point3D], f : Double) -> Array[Point2D] {
  @project3d.perspective_batch(pts, f)
}

///|
pub fn project_to_plane(p : Point3D, normal : Point3D, d : Double) -> Point3D {
  @project3d.project_to_plane(p, normal, d)
}