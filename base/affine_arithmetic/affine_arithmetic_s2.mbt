///|
pub fn affine_add(a : AffineForm, b : AffineForm) -> AffineForm {
  let n = if a.errors.length() >= b.errors.length() {
    a.errors.length()
  } else {
    b.errors.length()
  }
  let errors : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let ea = if i < a.errors.length() { a.errors[i] } else { 0.0 }
    let eb = if i < b.errors.length() { b.errors[i] } else { 0.0 }
    errors[i] = ea + eb
  }
  { center: a.center + b.center, errors, }
}
