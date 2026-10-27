///|
/// # NURBS Curve Intersection and Subdivision
/// # NURBS 曲线相交与细分
///
/// Intersection detection with line segments and curve subdivision via
/// Boehm knot insertion. All curves are 2D B-splines (NURBS with unit weights).
/// 通过 Boehm 节点插入实现与线段的相交检测和曲线细分。
/// 所有曲线为二维 B 样条（权重为 1 的 NURBS 特例）。

///|
/// Compute B-spline basis function N(i, p, u) via Cox-de Boor recursion.
/// 使用 Cox-de Boor 递推计算 B 样条基函数 N(i, p, u)。
///
/// # Arguments / 参数
/// - `i`: basis index / 基函数索引
/// - `p`: degree / 次数
/// - `u`: parameter / 参数
/// - `knots`: knot vector / 节点向量
fn bspline_basis(
  i : Int32,
  p : Int32,
  u : Double,
  knots : Array[Double],
) -> Double {
  if p == 0 {
    if knots[i] <= u && u < knots[i + 1] {
      return 1.0
    }
    return 0.0
  }
  let mut result = 0.0
  let denom1 = knots[i + p] - knots[i]
  if denom1.abs() > 0.000000000001 {
    result += (u - knots[i]) / denom1 * bspline_basis(i, p - 1, u, knots)
  }
  let denom2 = knots[i + p + 1] - knots[i + 1]
  if denom2.abs() > 0.000000000001 {
    result += (knots[i + p + 1] - u) /
      denom2 *
      bspline_basis(i + 1, p - 1, u, knots)
  }
  result
}

///|
/// Evaluate a 2D B-spline curve at parameter u.
/// 在参数 u 处求值二维 B 样条曲线。
fn nurbs_eval(
  control_points : Array[@core.Point2D],
  knots : Array[Double],
  degree : Int32,
  u : Double,
) -> @core.Point2D {
  let n = control_points.length()
  let mut x = 0.0
  let mut y = 0.0
  for i in 0..<n {
    let b = bspline_basis(i, degree, u, knots)
    x += b * control_points[i].x()
    y += b * control_points[i].y()
  }
  @core.Point2D::new(x, y)
}

///|
/// Find intersection points between a NURBS curve and a line segment.
/// 查找 NURBS 曲线与线段的交点。
///
/// The curve is sampled into a polyline and each segment is tested against
/// the line segment using 2D cross products. Duplicate hits are merged.
/// 曲线被采样为折线，每段与线段通过二维叉积求交，重复交点合并。
///
/// # Arguments / 参数
/// - `control_points`: NURBS control points / NURBS 控制点
/// - `knots`: knot vector / 节点向量
/// - `degree`: spline degree / 样条次数
/// - `line_start`: line segment start point / 线段起点
/// - `line_end`: line segment end point / 线段终点
///
/// # Returns / 返回
/// Array of intersection points (possibly empty).
/// 交点数组（可能为空）。
pub fn nurbs_line_intersect(
  control_points : Array[@core.Point2D],
  knots : Array[Double],
  degree : Int32,
  line_start : @core.Point2D,
  line_end : @core.Point2D,
) -> Array[@core.Point2D] {
  let samples = 200
  let pts : Array[@core.Point2D] = []
  for i in 0..<=samples {
    let u = i.to_double() / samples.to_double()
    pts.push(nurbs_eval(control_points, knots, degree, u))
  }
  let result : Array[@core.Point2D] = []
  let d2 = line_end.sub(line_start)
  for i in 0..<samples {
    let p1 = pts[i]
    let p2 = pts[i + 1]
    let d1 = p2.sub(p1)
    let denom = d1.cross(d2)
    if denom.abs() < 0.000000000001 {
      continue
    }
    let diff = line_start.sub(p1)
    let s = diff.cross(d2) / denom
    let tt = diff.cross(d1) / denom
    if s >= 0.0 && s <= 1.0 && tt >= 0.0 && tt <= 1.0 {
      let pt = p1.add(d1.mul(s))
      let mut dup = false
      for q in result {
        if q.approx_eq(pt, 0.000001) {
          dup = true
          break
        }
      }
      if !dup {
        result.push(pt)
      }
    }
  }
  result
}

///|
/// Insert a single knot into the B-spline curve (Boehm's algorithm).
/// 向 B 样条曲线插入单个节点（Boehm 算法）。
///
/// Returns the new control points and knot vector after one insertion.
/// 返回插入一次后的新控制点和节点向量。
fn insert_one_knot(
  pts : Array[@core.Point2D],
  knots : Array[Double],
  degree : Int32,
  t : Double,
) -> (Array[@core.Point2D], Array[Double]) {
  let n = pts.length() - 1
  let mut k = degree
  while k < n && knots[k + 1] <= t {
    k += 1
  }
  let new_pts : Array[@core.Point2D] = []
  for i in 0..<=(k - degree) {
    new_pts.push(pts[i])
  }
  for i in (k - degree + 1)..<=k {
    let denom = knots[i + degree] - knots[i]
    let alpha = if denom.abs() < 0.000000000001 {
      0.0
    } else {
      (t - knots[i]) / denom
    }
    new_pts.push(pts[i].mul(alpha).add(pts[i - 1].mul(1.0 - alpha)))
  }
  for i in (k + 1)..<=(n + 1) {
    new_pts.push(pts[i - 1])
  }
  let new_knots : Array[Double] = []
  for i in 0..<=k {
    new_knots.push(knots[i])
  }
  new_knots.push(t)
  for i in (k + 1)..<knots.length() {
    new_knots.push(knots[i])
  }
  (new_pts, new_knots)
}

///|
/// Subdivide a NURBS curve at parameter t into two curves.
/// 在参数 t 处将 NURBS 曲线细分为两段。
///
/// Uses Boehm knot insertion: the knot `t` is inserted `degree` times so its
/// multiplicity reaches `degree`, then the control point sequence is split.
/// Left curve spans `[knots[0], t]`, right curve spans `[t, knots[last]]`.
/// 使用 Boehm 节点插入：将节点 `t` 插入 `degree` 次使其重数达到 `degree`，
/// 然后分割控制点序列。左段定义在 `[knots[0], t]`，右段定义在 `[t, knots[last]]`。
///
/// # Arguments / 参数
/// - `control_points`: NURBS control points / NURBS 控制点
/// - `knots`: knot vector / 节点向量
/// - `degree`: spline degree / 样条次数
/// - `t`: subdivision parameter / 细分参数
///
/// # Returns / 返回
/// `(left_ctrl, left_knots, right_ctrl, right_knots)`.
/// `(左段控制点, 左段节点向量, 右段控制点, 右段节点向量)`。
pub fn nurbs_subdivide(
  control_points : Array[@core.Point2D],
  knots : Array[Double],
  degree : Int32,
  t : Double,
) -> (Array[@core.Point2D], Array[Double], Array[@core.Point2D], Array[Double]) {
  let mut cur_pts = control_points
  let mut cur_knots = knots
  for _ in 0..<degree {
    let (p, k) = insert_one_knot(cur_pts, cur_knots, degree, t)
    cur_pts = p
    cur_knots = k
  }
  let m = cur_pts.length() - 1
  let mut k = degree
  while k < m && cur_knots[k + 1] < t {
    k += 1
  }
  let left_pts : Array[@core.Point2D] = []
  for i in 0..<=k {
    left_pts.push(cur_pts[i])
  }
  let right_pts : Array[@core.Point2D] = []
  for i in k..<=m {
    right_pts.push(cur_pts[i])
  }
  let left_knots : Array[Double] = []
  for i in 0..<=(k + degree + 1) {
    if i <= k {
      left_knots.push(cur_knots[i])
    } else {
      left_knots.push(t)
    }
  }
  let right_knots : Array[Double] = []
  for i in 0..<=(m - k + degree) {
    if i < degree {
      right_knots.push(t)
    } else {
      right_knots.push(cur_knots[i - degree + k + 1])
    }
  }
  (left_pts, left_knots, right_pts, right_knots)
}

///|
/// Compute the axis-aligned bounding box of NURBS control points.
/// 计算 NURBS 控制点的轴对齐包围盒。
///
/// Note: this is the bounding box of the control points, which contains the
/// curve (convex hull property). It is not the tight box of the curve itself.
/// 注意：这是控制点的包围盒，由凸包性质它包含曲线，但不是曲线的最紧包围盒。
///
/// # Arguments / 参数
/// - `control_points`: NURBS control points / NURBS 控制点
///
/// # Returns / 返回
/// `(min_x, min_y, max_x, max_y)`.
/// `(最小 x, 最小 y, 最大 x, 最大 y)`。
pub fn nurbs_bbox(
  control_points : Array[@core.Point2D],
) -> (Double, Double, Double, Double) {
  let mut min_x = control_points[0].x()
  let mut min_y = control_points[0].y()
  let mut max_x = min_x
  let mut max_y = min_y
  for i in 1..<control_points.length() {
    let px = control_points[i].x()
    let py = control_points[i].y()
    if px < min_x {
      min_x = px
    }
    if px > max_x {
      max_x = px
    }
    if py < min_y {
      min_y = py
    }
    if py > max_y {
      max_y = py
    }
  }
  (min_x, min_y, max_x, max_y)
}
