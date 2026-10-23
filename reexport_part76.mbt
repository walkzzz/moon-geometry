///|
pub fn rigid_apply(r : Rigid, p : Point2D) -> Point2D {
  @rigid.Rigid::apply(r, p)
}

///|
pub fn rigid_compose(r1 : Rigid, r2 : Rigid) -> Rigid {
  @rigid.Rigid::compose(r1, r2)
}

///|
pub fn rigid_inverse(r : Rigid) -> Rigid {
  @rigid.Rigid::inverse(r)
}

///|
pub fn rigid_apply_batch(r : Rigid, pts : Array[Point2D]) -> Array[Point2D] {
  @rigid.Rigid::apply_batch(r, pts)
}

///|
pub fn rigid_from_correspondence(s1 : Point2D, d1 : Point2D, s2 : Point2D, d2 : Point2D) -> Rigid {
  @rigid.Rigid::from_correspondence(s1, d1, s2, d2)
}

// ---------------------------------------------------------------------------
// similarity: similarity transform / 相似变换
// ---------------------------------------------------------------------------

///|
pub type Similarity = @similarity.Similarity

///|
pub fn similarity_identity() -> Similarity {
  @similarity.Similarity::identity()
}