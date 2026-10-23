///|
pub fn rng_new(seed : UInt) -> Rng {
  @random_gen.Rng::new(seed)
}

///|
pub fn rng_next_uint(r : Rng) -> UInt {
  @random_gen.Rng::next_uint(r)
}

///|
pub fn rng_next_double(r : Rng) -> Double {
  @random_gen.Rng::next_double(r)
}

///|
pub fn rng_point2d(r : Rng, xlo : Double, xhi : Double, ylo : Double, yhi : Double) -> Point2D {
  @random_gen.Rng::point2d(r, xlo, xhi, ylo, yhi)
}

///|
pub fn rng_random_points(r : Rng, n : Int, xlo : Double, xhi : Double, ylo : Double, yhi : Double) -> Array[Point2D] {
  @random_gen.Rng::random_points(r, n, xlo, xhi, ylo, yhi)
}

///|
pub fn rng_random_convex_polygon(r : Rng, n : Int, radius : Double) -> Array[Point2D] {
  @random_gen.Rng::random_convex_polygon(r, n, radius)
}

// ---------------------------------------------------------------------------
// sampling: geometric sampling / 几何采样
// ---------------------------------------------------------------------------

///|
pub fn grid_sample(xlo : Double, xhi : Double, ylo : Double, yhi : Double, nx : Int, ny : Int) -> Array[Point2D] {
  @sampling.grid_sample(xlo, xhi, ylo, yhi, nx, ny)
}