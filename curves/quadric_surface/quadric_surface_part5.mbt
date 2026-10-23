///|
/// Translate the quadric so its center is at the origin. / 平移二次曲面使中心位于原点。
pub fn Quadric::centered(q : Quadric) -> Quadric {
  let center = match Quadric::center(q) {
    Some(c) => c
    None => return q
  }
  let nf = Quadric::eval(q, center)
  { ..q, g: 0.0, h: 0.0, i: 0.0, j: nf }
}