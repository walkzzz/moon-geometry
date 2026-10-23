///|
/// Check if any edge of poly1 is a separating axis.
/// 检查 poly1 的任一边是否为分离轴。
fn has_separating_axis(poly1 : @core.Polygon, poly2 : @core.Polygon) -> Bool {
  let n1 = poly1.size()
  for i in 0..<n1 {
    let curr = poly1.get(i)
    let next = poly1.get((i + 1) % n1)
    let dx = next.x() - curr.x()
    let dy = next.y() - curr.y()
    let nx = -dy
    let ny = dx
    let proj1 = curr.x() * nx + curr.y() * ny
    let mut min2 = poly2.get(0).x() * nx + poly2.get(0).y() * ny
    let mut max2 = min2
    let n2 = poly2.size()
    for j in 1..<n2 {
      let val = poly2.get(j).x() * nx + poly2.get(j).y() * ny
      if val < min2 {
        min2 = val
      }
      if val > max2 {
        max2 = val
      }
    }
    let mut min1 = proj1
    let mut max1 = proj1
    for j in 1..<n1 {
      let val = poly1.get(j).x() * nx + poly1.get(j).y() * ny
      if val < min1 {
        min1 = val
      }
      if val > max1 {
        max1 = val
      }
    }
    if max1 < min2 || max2 < min1 {
      return true
    }
  }
  false
}
