///|
pub fn similarity_scaling(s : Double) -> Similarity {
  @similarity.Similarity::scaling(s)
}

///|
pub fn similarity_rotation(angle : Double) -> Similarity {
  @similarity.Similarity::rotation(angle)
}

///|
pub fn similarity_translation(tx : Double, ty : Double) -> Similarity {
  @similarity.Similarity::translation(tx, ty)
}

///|
pub fn similarity_apply(s : Similarity, p : Point2D) -> Point2D {
  @similarity.Similarity::apply(s, p)
}

///|
pub fn similarity_compose(s1 : Similarity, s2 : Similarity) -> Similarity {
  @similarity.Similarity::compose(s1, s2)
}

///|
pub fn similarity_inverse(s : Similarity) -> Similarity? {
  @similarity.Similarity::inverse(s)
}

///|
pub fn similarity_apply_batch(s : Similarity, pts : Array[Point2D]) -> Array[Point2D] {
  @similarity.Similarity::apply_batch(s, pts)
}