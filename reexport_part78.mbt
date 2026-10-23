///|
pub fn similarity_from_correspondence(s1 : Point2D, d1 : Point2D, s2 : Point2D, d2 : Point2D) -> Similarity {
  @similarity.Similarity::from_correspondence(s1, d1, s2, d2)
}

// ---------------------------------------------------------------------------
// inversion: geometric inversion / 几何反演
// ---------------------------------------------------------------------------

///|
pub type Inversion = @inversion.Inversion

///|
pub fn inversion_new(center : Point2D, r : Double) -> Inversion {
  @inversion.Inversion::new(center, r)
}

///|
pub fn inversion_apply(inv : Inversion, p : Point2D) -> Point2D? {
  @inversion.Inversion::apply(inv, p)
}

///|
pub fn inversion_apply_batch(inv : Inversion, pts : Array[Point2D]) -> Array[Point2D] {
  @inversion.Inversion::apply_batch(inv, pts)
}

///|
pub fn inversion_power(inv : Inversion, p : Point2D) -> Double {
  @inversion.Inversion::power(inv, p)
}

///|
pub fn inversion_is_inside(inv : Inversion, p : Point2D) -> Bool {
  @inversion.Inversion::is_inside(inv, p)
}