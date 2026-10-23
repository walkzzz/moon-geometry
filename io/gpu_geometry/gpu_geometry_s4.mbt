///|
pub fn meshlet_bounds(
  verts : Array[(Double, Double, Double)],
) -> ((Double, Double, Double), Double) {
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  let n = verts.length().to_double()
  for i in 0..<verts.length() {
    cx += verts[i].0
    cy += verts[i].1
    cz += verts[i].2
  }
  if n > 0.0 {
    cx /= n
    cy /= n
    cz /= n
  }
  let mut max_r = 0.0
  for i in 0..<verts.length() {
    let dx = verts[i].0 - cx
    let dy = verts[i].1 - cy
    let dz = verts[i].2 - cz
    let d = (dx * dx + dy * dy + dz * dz).sqrt()
    if d > max_r {
      max_r = d
    }
  }
  ((cx, cy, cz), max_r)
}
