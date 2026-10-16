///|
/// # Bezier Clipping
/// # 贝塞尔裁剪
///
/// Exact curve intersection via recursive Bezier clipping.
/// 通过递归贝塞尔裁剪精确求曲线交点。

///|
/// Cubic Bezier curve control points. / 三次贝塞尔曲线控制点。
pub struct BezierClip {
  p0 : @core.Point2D
  p1 : @core.Point2D
  p2 : @core.Point2D
  p3 : @core.Point2D
}

///|
/// Construct a cubic Bezier curve. / 构造三次贝塞尔曲线。
pub fn BezierClip::new(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> BezierClip {
  { p0, p1, p2, p3 }
}

///|
/// Evaluate the Bezier curve at parameter t (de Casteljau). / 用 de Casteljau 算法求值。
pub fn BezierClip::eval(b : BezierClip, t : Double) -> @core.Point2D {
  let mt = 1.0 - t
  let x = mt * mt * mt * b.p0.x() +
    3.0 * mt * mt * t * b.p1.x() +
    3.0 * mt * t * t * b.p2.x() +
    t * t * t * b.p3.x()
  let y = mt * mt * mt * b.p0.y() +
    3.0 * mt * mt * t * b.p1.y() +
    3.0 * mt * t * t * b.p2.y() +
    t * t * t * b.p3.y()
  @core.Point2D::new(x, y)
}

///|
/// Derivative at parameter t. / 参数 t 处的导数。
pub fn BezierClip::derivative(b : BezierClip, t : Double) -> @core.Point2D {
  let mt = 1.0 - t
  let q0x = 3.0 * (b.p1.x() - b.p0.x())
  let q1x = 3.0 * (b.p2.x() - b.p1.x())
  let q2x = 3.0 * (b.p3.x() - b.p2.x())
  let q0y = 3.0 * (b.p1.y() - b.p0.y())
  let q1y = 3.0 * (b.p2.y() - b.p1.y())
  let q2y = 3.0 * (b.p3.y() - b.p2.y())
  let dx = mt * mt * q0x + 2.0 * mt * t * q1x + t * t * q2x
  let dy = mt * mt * q0y + 2.0 * mt * t * q1y + t * t * q2y
  @core.Point2D::new(dx, dy)
}

///|
/// Bounding box of the control polygon. / 控制多边形包围盒。
pub fn BezierClip::bbox(b : BezierClip) -> (Double, Double, Double, Double) {
  let xs = [b.p0.x(), b.p1.x(), b.p2.x(), b.p3.x()]
  let ys = [b.p0.y(), b.p1.y(), b.p2.y(), b.p3.y()]
  let mut min_x = xs[0]
  let mut max_x = xs[0]
  let mut min_y = ys[0]
  let mut max_y = ys[0]
  for x in xs {
    if x < min_x {
      min_x = x
    }
    if x > max_x {
      max_x = x
    }
  }
  for y in ys {
    if y < min_y {
      min_y = y
    }
    if y > max_y {
      max_y = y
    }
  }
  (min_x, min_y, max_x, max_y)
}

///|
/// Subdivide the curve at t into two cubic Bezier curves (de Casteljau).
/// 在 t 处细分为两条三次贝塞尔曲线。
pub fn BezierClip::subdivide(
  b : BezierClip,
  t : Double,
) -> (BezierClip, BezierClip) {
  let mt = 1.0 - t
  let q0 = @core.Point2D::new(
    mt * b.p0.x() + t * b.p1.x(),
    mt * b.p0.y() + t * b.p1.y(),
  )
  let q1 = @core.Point2D::new(
    mt * b.p1.x() + t * b.p2.x(),
    mt * b.p1.y() + t * b.p2.y(),
  )
  let q2 = @core.Point2D::new(
    mt * b.p2.x() + t * b.p3.x(),
    mt * b.p2.y() + t * b.p3.y(),
  )
  let r0 = @core.Point2D::new(
    mt * q0.x() + t * q1.x(),
    mt * q0.y() + t * q1.y(),
  )
  let r1 = @core.Point2D::new(
    mt * q1.x() + t * q2.x(),
    mt * q1.y() + t * q2.y(),
  )
  let s0 = @core.Point2D::new(
    mt * r0.x() + t * r1.x(),
    mt * r0.y() + t * r1.y(),
  )
  (
    { p0: b.p0, p1: q0, p2: r0, p3: s0 },
    { p0: s0, p1: r1, p2: q2, p3: b.p3 },
  )
}

///|
/// Check if two bounding boxes overlap. / 检查两个包围盒是否重叠。
fn bbox_overlap(
  a : (Double, Double, Double, Double),
  b : (Double, Double, Double, Double),
  eps : Double,
) -> Bool {
  !(
    a.0 > b.2 + eps ||
    a.2 < b.0 - eps ||
    a.1 > b.3 + eps ||
    a.3 < b.1 - eps
  )
}

///|
/// Find intersection parameters between two cubic Bezier curves via recursive subdivision.
/// Returns array of (t1, t2, point) triples. / 通过递归细分求两条三次贝塞尔曲线的交点。
pub fn bezier_clip_intersect(
  b1 : BezierClip,
  b2 : BezierClip,
  eps : Double,
  max_depth : Int,
) -> Array[(Double, Double, @core.Point2D)] {
  let results : Array[(Double, Double, @core.Point2D)] = []
  clip_recursive(
    b1,
    b2,
    0.0,
    1.0,
    0.0,
    1.0,
    0,
    max_depth,
    eps,
    results,
  )
  results
}

fn clip_recursive(
  b1 : BezierClip,
  b2 : BezierClip,
  lo1 : Double,
  hi1 : Double,
  lo2 : Double,
  hi2 : Double,
  depth : Int,
  max_depth : Int,
  eps : Double,
  results : Array[(Double, Double, @core.Point2D)],
) -> Unit {
  let bb1 = BezierClip::bbox(b1)
  let bb2 = BezierClip::bbox(b2)
  if !bbox_overlap(bb1, bb2, eps) {
    return
  }
  let dx = bb1.2 - bb1.0
  let dy = bb1.3 - bb1.1
  let dx2 = bb2.2 - bb2.0
  let dy2 = bb2.3 - bb2.1
  if (dx < eps && dy < eps) || (dx2 < eps && dy2 < eps) {
    let t1 = (lo1 + hi1) / 2.0
    let t2 = (lo2 + hi2) / 2.0
    let p = BezierClip::eval(b1, 0.5)
    results.push((t1, t2, p))
    return
  }
  if depth >= max_depth {
    let t1 = (lo1 + hi1) / 2.0
    let t2 = (lo2 + hi2) / 2.0
    let p = BezierClip::eval(b1, 0.5)
    results.push((t1, t2, p))
    return
  }
  let (left1, right1) = BezierClip::subdivide(b1, 0.5)
  let mid1 = (lo1 + hi1) / 2.0
  let (left2, right2) = BezierClip::subdivide(b2, 0.5)
  let mid2 = (lo2 + hi2) / 2.0
  clip_recursive(left1, left2, lo1, mid1, lo2, mid2, depth + 1, max_depth, eps, results)
  clip_recursive(left1, right2, lo1, mid1, mid2, hi2, depth + 1, max_depth, eps, results)
  clip_recursive(right1, left2, mid1, hi1, lo2, mid2, depth + 1, max_depth, eps, results)
  clip_recursive(right1, right2, mid1, hi1, mid2, hi2, depth + 1, max_depth, eps, results)
}

///|
/// Self-intersection points of a cubic Bezier curve. / 三次贝塞尔曲线自交点。
pub fn bezier_self_intersect(
  b : BezierClip,
  eps : Double,
  max_depth : Int,
) -> Array[@core.Point2D] {
  let results : Array[@core.Point2D] = []
  let (left, right) = BezierClip::subdivide(b, 0.5)
  let tmp = bezier_clip_intersect(left, right, eps, max_depth)
  for r in tmp {
    results.push(r.2)
  }
  results
}

///|
/// Approximate arc length via Gaussian quadrature. / 高斯求积近似弧长。
pub fn BezierClip::length(b : BezierClip) -> Double {
  let nodes = [
    -0.7745966692414834,
    0.0,
    0.7745966692414834,
  ]
  let weights = [0.5555555555555556, 0.8888888888888888, 0.5555555555555556]
  let mut sum = 0.0
  for i in 0..<3 {
    let t = (nodes[i] + 1.0) / 2.0
    let d = BezierClip::derivative(b, t)
    let speed = (d.x() * d.x() + d.y() * d.y()).sqrt()
    sum += weights[i] * speed
  }
  sum / 2.0
}