///|
pub fn affine2_determinant(m : Affine2) -> Double {
  @affine2.Affine2::determinant(m)
}

///|
pub fn affine2_inverse(m : Affine2) -> Affine2? {
  @affine2.Affine2::inverse(m)
}

///|
pub fn affine2_apply_batch(m : Affine2, pts : Array[Point2D]) -> Array[Point2D] {
  @affine2.Affine2::apply_batch(m, pts)
}

// ---------------------------------------------------------------------------
// rigid: rigid transform / 刚体变换
// ---------------------------------------------------------------------------

///|
pub type Rigid = @rigid.Rigid

///|
pub fn rigid_identity() -> Rigid {
  @rigid.Rigid::identity()
}

///|
pub fn rigid_translation(tx : Double, ty : Double) -> Rigid {
  @rigid.Rigid::translation(tx, ty)
}

///|
pub fn rigid_rotation(angle : Double) -> Rigid {
  @rigid.Rigid::rotation(angle)
}