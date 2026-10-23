///|
/// Find a separating axis between two convex polygons. Returns the axis line or None. / 寻找分离轴。
pub fn find_separating_axis(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> @core.Line? {
  let axes1 = edge_normals(poly1)
  let axes2 = edge_normals(poly2)
  for i in 0..<axes1.length() {
    let (a, b) = axes1[i]
    if separates(poly1, poly2, a, b) {
      let (c1, c2) = projection_range(poly1, a, b)
      let (d1, d2) = projection_range(poly2, a, b)
      let c = if c2 < d1 {
        -a * 0.0 - b * 0.0 - (c2 + d1) / 2.0
      } else {
        -a * 0.0 - b * 0.0 - (d2 + c1) / 2.0
      }
      return Some(@core.Line::new(a, b, c))
    }
  }
  for i in 0..<axes2.length() {
    let (a, b) = axes2[i]
    if separates(poly1, poly2, a, b) {
      let (c1, c2) = projection_range(poly1, a, b)
      let (d1, d2) = projection_range(poly2, a, b)
      let c = if c2 < d1 {
        -a * 0.0 - b * 0.0 - (c2 + d1) / 2.0
      } else {
        -a * 0.0 - b * 0.0 - (d2 + c1) / 2.0
      }
      return Some(@core.Line::new(a, b, c))
    }
  }
  None
}

fn edge_normals(poly : @core.Polygon) -> Array[(Double, Double)] {
  let result : Array[(Double, Double)] = []
  let n = poly.vertices.length()
  for i in 0..<n {
    let cur = poly.vertices[i]
    let nxt = poly.vertices[(i + 1) % n]
    let dx = nxt.x() - cur.x()
    let dy = nxt.y() - cur.y()
    let len = (dx * dx + dy * dy).sqrt()
    if len > 0.000000000001 {
      result.push((dy / len, -dx / len))
    }
  }
  result
}

fn projection_range(
  poly : @core.Polygon,
  a : Double,
  b : Double,
) -> (Double, Double) {
  let mut min_val = a * poly.vertices[0].x() + b * poly.vertices[0].y()
  let mut max_val = min_val
  for i in 1..<poly.vertices.length() {
    let val = a * poly.vertices[i].x() + b * poly.vertices[i].y()
    if val < min_val {
      min_val = val
    }
    if val > max_val {
      max_val = val
    }
  }
  (min_val, max_val)
}

fn separates(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
  a : Double,
  b : Double,
) -> Bool {
  let (min1, max1) = projection_range(poly1, a, b)
  let (min2, max2) = projection_range(poly2, a, b)
  max1 < min2 || max2 < min1
}
