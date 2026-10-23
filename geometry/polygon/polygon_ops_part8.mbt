///|
/// Douglas-Peucker polygon simplification.
/// Returns a simplified vertex array preserving shape within `epsilon`.
/// 返回在 `epsilon` 精度内保持形状的简化顶点数组。
pub fn simplify_polygon(
  poly : @core.Polygon,
  epsilon : Double,
) -> Array[@core.Point2D] {
  let verts = poly.vertices
  let n = verts.length()
  if n <= 2 {
    return verts.copy()
  }
  let keep = Array::make(n, false)
  keep[0] = true
  keep[n - 1] = true
  dp_recursive(verts, 0, n - 1, epsilon, keep)
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    if keep[i] {
      result.push(verts[i])
    }
  }
  result
}
