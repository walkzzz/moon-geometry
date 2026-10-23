///|
pub fn affine_to_interval(a : AffineForm) -> (Double, Double) {
  let mut radius = 0.0
  for i in 0..<a.errors.length() {
    radius += a.errors[i].abs()
  }
  (a.center - radius, a.center + radius)
}

///|
pub fn affine_scale(a : AffineForm, s : Double) -> AffineForm {
  let errors : Array[Double] = []
  for i in 0..<a.errors.length() {
    errors.push(a.errors[i] * s)
  }
  { center: a.center * s, errors, }
}
