///|
pub fn edge_function(a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Double {
  (c.0 - a.0) * (b.1 - a.1) - (c.1 - a.1) * (b.0 - a.0)
}

///|
pub fn barycentric_coord(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> (Double, Double, Double) {
  let area = edge_function(a, b, c)
  if area.abs() < 0.000000000001 { (0.0, 0.0, 0.0) } else {
    let u = edge_function(b, c, p) / area
    let v = edge_function(c, a, p) / area
    let w = 1.0 - u - v
    (u, v, w)
  }
}

///|
pub fn point_in_triangle(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Bool {
  let (u, v, w) = barycentric_coord(p, a, b, c)
  u >= 0.0 && v >= 0.0 && w >= 0.0
}
