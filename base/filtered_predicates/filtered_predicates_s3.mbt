///|
pub fn perturbation_orientation(det : Double, eps : Double) -> Int32 {
  if det > eps {
    1
  } else if det < -eps {
    -1
  } else {
    0
  }
}
