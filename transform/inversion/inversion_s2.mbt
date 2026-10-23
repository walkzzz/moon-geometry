///|
/// Apply inversion to an array of points. / 将反演应用于点数组。
pub fn Inversion::apply_batch(
  inv : Inversion,
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    match inv.apply(p) {
      Some(pt) => result.push(pt)
      None => continue
    }
  }
  result
}


///|
/// Inversion preserves the inversion circle. / 反演保持反演圆不变。
pub fn Inversion::preserves_circle(inv : Inversion) -> Bool {
  ignore(inv)
  true
}
