///|
/// Compute total perimeter (outer + holes). / 计算总周长（外边界加孔边界）。
pub fn polygon_with_holes_perimeter(p : PolygonWithHoles) -> Double {
  let mut perim = 0.0
  let n = p.outer.length()
  for i in 0..<n {
    let j = (i + 1) % n
    perim += p.outer[i].dist(p.outer[j])
  }
  for hole in p.holes {
    let hn = hole.length()
    for i in 0..<hn {
      let j = (i + 1) % hn
      perim += hole[i].dist(hole[j])
    }
  }
  perim
}
