///|
pub fn catmull_clark_subdivide(m : Mesh) -> Mesh {
  @mesh_subdiv.catmull_clark_subdivide(m)
}

///|
pub fn subdivided_face_count(m : Mesh) -> Int {
  @mesh_subdiv.subdivided_face_count(m)
}

// ---------------------------------------------------------------------------
// euler_char: Euler characteristic / 欧拉示性数
// ---------------------------------------------------------------------------

///|
pub fn euler_characteristic(m : Mesh) -> Int {
  @euler_char.euler_characteristic(m)
}

///|
pub fn surface_genus(m : Mesh) -> Int {
  @euler_char.surface_genus(m)
}

///|
pub fn is_sphere(m : Mesh) -> Bool {
  @euler_char.is_sphere(m)
}

///|
pub fn is_torus(m : Mesh) -> Bool {
  @euler_char.is_torus(m)
}

///|
pub fn euler_from_counts(v : Int, e : Int, f : Int) -> Int {
  @euler_char.euler_from_counts(v, e, f)
}