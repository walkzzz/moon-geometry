///|
pub type Affine2 = @affine2.Affine2

///|
pub fn affine2_identity() -> Affine2 {
  @affine2.Affine2::identity()
}

///|
pub fn affine2_translation(tx : Double, ty : Double) -> Affine2 {
  @affine2.Affine2::translation(tx, ty)
}

///|
pub fn affine2_scale(sx : Double, sy : Double) -> Affine2 {
  @affine2.Affine2::scale(sx, sy)
}

///|
pub fn affine2_shear(shx : Double, shy : Double) -> Affine2 {
  @affine2.Affine2::shear(shx, shy)
}

///|
pub fn affine2_apply(m : Affine2, p : Point2D) -> Point2D {
  @affine2.Affine2::apply(m, p)
}

///|
pub fn affine2_compose(m1 : Affine2, m2 : Affine2) -> Affine2 {
  @affine2.Affine2::compose(m1, m2)
}