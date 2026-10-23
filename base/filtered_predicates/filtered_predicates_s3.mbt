///|
pub fn perturbation_orientation(det : Double, eps : Double) -> Int {
  if det > eps { 1 } else if det < -eps { -1 } else { 0 }
}
