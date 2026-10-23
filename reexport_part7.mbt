///|
/// Rotate a point around the origin. / 绕原点旋转点。
pub fn rotate(p : Point2D, angle : Double) -> Point2D {
  @transform.rotate(p, angle)
}


///|
/// Rotate a point around a center. / 绕中心点旋转。
pub fn rotate_around(p : Point2D, center : Point2D, angle : Double) -> Point2D {
  @transform.rotate_around(p, center, angle)
}


///|
/// Rotate an array of points around a center. / 绕中心点旋转点数组。
pub fn rotate_points(
  points : Array[Point2D],
  center : Point2D,
  angle : Double,
) -> Array[Point2D] {
  @transform.rotate_points(points, center, angle)
}


///|
/// Scale a point. / 缩放点。
pub fn scale(p : Point2D, sx : Double, sy : Double) -> Point2D {
  @transform.scale(p, sx, sy)
}


///|
/// Scale a point relative to a center. / 相对中心点缩放。
pub fn scale_around(
  p : Point2D,
  center : Point2D,
  sx : Double,
  sy : Double,
) -> Point2D {
  @transform.scale_around(p, center, sx, sy)
}


///|
/// Affine transform: (x,y) -> (a*x+b*y+c, d*x+e*y+f). / 仿射变换。
pub fn affine_transform(
  p : Point2D,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
) -> Point2D {
  @transform.affine_transform(p, a, b, c, d, e, f)
}


///|
/// Affine transform on an array of points. / 对点数组应用仿射变换。
pub fn affine_transform_points(
  points : Array[Point2D],
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
) -> Array[Point2D] {
  @transform.affine_transform_points(points, a, b, c, d, e, f)
}
