///|
/// A simplex in the alpha complex. / Alpha 复形中的单纯形。
pub struct AlphaSimplex {
  vertices : Array[Int32]
  dimension : Int32
  circumradius : Double
}

///|
/// Alpha complex: subcomplex of Delaunay filtered by circumradius. / Alpha 复形：按外接圆半径过滤的 Delaunay 子复形。
pub struct AlphaComplex {
  simplices : Array[AlphaSimplex]
  alpha : Double
}

///|
/// Construct an empty alpha complex. / 构造空的 Alpha 复形。
pub fn AlphaComplex::new() -> AlphaComplex {
  { simplices: [], alpha: 0.0, }
}

///|
/// Get the number of simplices. / 获取单纯形数量。
pub fn AlphaComplex::simplex_count(ac : AlphaComplex) -> Int32 {
  ac.simplices.length()
}

///|
/// Compute circumcenter of a 2D triangle. / 计算二维三角形的外心。
fn circumcenter(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.0000000001 {
    return @core.Point2D::new((ax + bx + cx) / 3.0, (ay + by + cy) / 3.0)
  }
  let ux = (
      (ax * ax + ay * ay) * (by - cy) +
      (bx * bx + by * by) * (cy - ay) +
      (cx * cx + cy * cy) * (ay - by)
    ) /
    d
  let uy = (
      (ax * ax + ay * ay) * (cx - bx) +
      (bx * bx + by * by) * (ax - cx) +
      (cx * cx + cy * cy) * (bx - ax)
    ) /
    d
  @core.Point2D::new(ux, uy)
}
