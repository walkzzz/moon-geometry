///|
pub fn betti_0(m : Mesh) -> Int {
  @euler_char.betti_0(m)
}

///|
pub fn is_manifold(m : Mesh) -> Bool {
  @euler_char.is_manifold(m)
}

// ---------------------------------------------------------------------------
// optim: geometric optimization / 几何优化
// ---------------------------------------------------------------------------

///|
pub fn smallest_enclosing_circle(pts : Array[Point2D]) -> Circle {
  @optim.smallest_enclosing_circle(pts)
}

///|
pub fn min_area_rect(pts : Array[Point2D]) -> Rectangle {
  @optim.min_area_rect(pts)
}

///|
pub fn optim_centroid(pts : Array[Point2D]) -> Point2D {
  @optim.centroid(pts)
}

///|
pub fn closest_to_centroid(pts : Array[Point2D]) -> Point2D? {
  @optim.closest_to_centroid(pts)
}

// ---------------------------------------------------------------------------
// random_gen: random generation / 随机生成
// ---------------------------------------------------------------------------

///|
pub type Rng = @random_gen.Rng