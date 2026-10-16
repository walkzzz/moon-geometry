///|
/// # Affine Arithmetic
/// # 仿射算术
///
/// Affine arithmetic for tracking correlation in interval computation.
/// 仿射算术，用于追踪区间计算中的相关性。

///|
pub struct AffineForm {
  center : Double
  errors : Array[Double]
}

///|
pub fn AffineForm::new(center : Double, errors : Array[Double]) -> AffineForm {
  { center, errors }
}

///|
pub fn affine_add(a : AffineForm, b : AffineForm) -> AffineForm {
  let n = if a.errors.length() >= b.errors.length() { a.errors.length() } else { b.errors.length() }
  let errors : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let ea = if i < a.errors.length() { a.errors[i] } else { 0.0 }
    let eb = if i < b.errors.length() { b.errors[i] } else { 0.0 }
    errors[i] = ea + eb
  }
  { center: a.center + b.center, errors }
}

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
  { center: a.center * s, errors }
}
