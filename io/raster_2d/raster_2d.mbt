///|
/// # Raster 2D | 二维光栅化
/// 2D rasterization algorithms. / 二维光栅化算法。

///|
pub fn bresenham_line(
  x0 : Int32,
  y0 : Int32,
  x1 : Int32,
  y1 : Int32,
) -> Array[(Int32, Int32)] {
  let result = []
  let dx = if x1 > x0 { x1 - x0 } else { x0 - x1 }
  let dy = if y1 > y0 { y1 - y0 } else { y0 - y1 }
  let sx = if x0 < x1 { 1 } else { -1 }
  let sy = if y0 < y1 { 1 } else { -1 }
  let mut err = dx - dy
  let mut x = x0
  let mut y = y0
  while true {
    result.push((x, y))
    if x == x1 && y == y1 {
      break
    }
    let e2 = 2 * err
    if e2 > -dy {
      err -= dy
      x += sx
    }
    if e2 < dx {
      err += dx
      y += sy
    }
  }
  result
}

///|
pub fn edge_function(
  a : (Double, Double),
  b : (Double, Double),
  c : (Double, Double),
) -> Double {
  (c.0 - a.0) * (b.1 - a.1) - (c.1 - a.1) * (b.0 - a.0)
}

///|
pub fn barycentric_coord(
  p : (Double, Double),
  a : (Double, Double),
  b : (Double, Double),
  c : (Double, Double),
) -> (Double, Double, Double) {
  let area = edge_function(a, b, c)
  if area.abs() < 0.000000000001 {
    (0.0, 0.0, 0.0)
  } else {
    let u = edge_function(b, c, p) / area
    let v = edge_function(c, a, p) / area
    let w = 1.0 - u - v
    (u, v, w)
  }
}

///|
pub fn point_in_triangle(
  p : (Double, Double),
  a : (Double, Double),
  b : (Double, Double),
  c : (Double, Double),
) -> Bool {
  let (u, v, w) = barycentric_coord(p, a, b, c)
  u >= 0.0 && v >= 0.0 && w >= 0.0
}
