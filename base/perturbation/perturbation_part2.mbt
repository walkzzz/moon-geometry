///|
pub fn sos_sign(det : Double, perturbation_order : Int) -> Int {
  if det != 0.0 {
    if det > 0.0 { 1 } else { -1 }
  } else {
    if perturbation_order % 2 == 0 { 1 } else { -1 }
  }
}
