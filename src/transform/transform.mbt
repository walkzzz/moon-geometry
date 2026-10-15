///|
/// Translate a point by (dx, dy).
/// 平移点 (dx, dy)。
pub fn translate(p : @core.Point2D, dx : Double, dy : Double) -> @core.Point2D {
  @core.Point2D::new(p.x + dx, p.y + dy)
}

///|
/// Translate an array of points by (dx, dy).
/// 平移点数组 (dx, dy)。
pub fn translate_points(
  points : Array[@core.Point2D],
  dx : Double,
  dy : Double
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    result.push(translate(p, dx, dy))
  }
  result
}

///|
/// Rotate a point around the origin by angle (radians, CCW).
/// 绕原点旋转点，角度为弧度（逆时针）。
pub fn rotate(p : @core.Point2D, angle : Double) -> @core.Point2D {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  @core.Point2D::new(p.x * c - p.y * s, p.x * s + p.y * c)
}

///|
/// Rotate a point around a center by angle (radians, CCW).
/// 绕中心点旋转，角度为弧度（逆时针）。
pub fn rotate_around(
  p : @core.Point2D,
  center : @core.Point2D,
  angle : Double
) -> @core.Point2D {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  let dx = p.x - center.x
  let dy = p.y - center.y
  @core.Point2D::new(center.x + dx * c - dy * s, center.y + dx * s + dy * c)
}

///|
/// Rotate an array of points around a center by angle (radians, CCW).
/// 绕中心点旋转点数组，角度为弧度（逆时针）。
pub fn rotate_points(
  points : Array[@core.Point2D],
  center : @core.Point2D,
  angle : Double
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    result.push(rotate_around(p, center, angle))
  }
  result
}

///|
/// Scale a point by (sx, sy) relative to the origin.
/// 相对于原点按 (sx, sy) 缩放点。
pub fn scale(p : @core.Point2D, sx : Double, sy : Double) -> @core.Point2D {
  @core.Point2D::new(p.x * sx, p.y * sy)
}

///|
/// Scale a point by (sx, sy) relative to a center.
/// 相对于中心点按 (sx, sy) 缩放点。
pub fn scale_around(
  p : @core.Point2D,
  center : @core.Point2D,
  sx : Double,
  sy : Double
) -> @core.Point2D {
  @core.Point2D::new(center.x + (p.x - center.x) * sx, center.y + (p.y - center.y) * sy)
}

///|
/// Apply an affine transform: (x, y) -> (a*x + b*y + c, d*x + e*y + f).
/// 应用仿射变换：(x, y) -> (a*x + b*y + c, d*x + e*y + f)。
pub fn affine_transform(
  p : @core.Point2D,
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) -> @core.Point2D {
  @core.Point2D::new(a * p.x + b * p.y + c, d * p.x + e * p.y + f)
}

///|
/// Apply an affine transform to an array of points.
/// 对点数组应用仿射变换。
pub fn affine_transform_points(
  points : Array[@core.Point2D],
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    result.push(affine_transform(p, a, b, c, d, e, f))
  }
  result
}

///|
/// Mirror a point across the x-axis.
/// 关于 x 轴镜像点。
pub fn mirror_x(p : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(p.x, -p.y)
}

///|
/// Mirror a point across the y-axis.
/// 关于 y 轴镜像点。
pub fn mirror_y(p : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(-p.x, p.y)
}

///|
/// Mirror a point through the origin (180-degree rotation).
/// 关于原点镜像点（180度旋转）。
pub fn mirror_origin(p : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(-p.x, -p.y)
}

///|
/// Mirror a point across a line a*x + b*y + c = 0.
/// 关于直线 a*x + b*y + c = 0 镜像点。
pub fn mirror_line(p : @core.Point2D, line : @core.Line) -> @core.Point2D {
  let a = line.a
  let b = line.b
  let c = line.c
  let denom = a * a + b * b
  let t = 2.0 * (a * p.x + b * p.y + c) / denom
  @core.Point2D::new(p.x - t * a, p.y - t * b)
}

///|
/// Shear a point: (x, y) -> (x + kx * y, y + ky * x).
/// 剪切变换：(x, y) -> (x + kx * y, y + ky * x)。
pub fn shear(
  p : @core.Point2D,
  kx : Double,
  ky : Double
) -> @core.Point2D {
  @core.Point2D::new(p.x + kx * p.y, p.y + ky * p.x)
}