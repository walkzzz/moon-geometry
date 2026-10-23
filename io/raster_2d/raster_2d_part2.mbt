///|
pub fn bresenham_line(x0 : Int, y0 : Int, x1 : Int, y1 : Int) -> Array[(Int, Int)] {
  let result = []
  let dx = if x1 > x0 { x1 - x0 } else { x0 - x1 }
  let dy = if y1 > y0 { y1 - y0 } else { y0 - y1 }
  let sx = if x0 < x1 { 1 } else { -1 }
  let sy = if y0 < y1 { 1 } else { -1 }
  let mut err = dx - dy
  let mut x = x0; let mut y = y0
  while true {
    result.push((x, y))
    if x == x1 && y == y1 { break }
    let e2 = 2 * err
    if e2 > -dy { err -= dy; x += sx }
    if e2 < dx { err += dx; y += sy }
  }
  result
}