///|
/// # GJK Collision Detection
/// # GJK 碰撞检测
///
/// Gilbert-Johnson-Keerthi algorithm using support mappings for convex shapes.
/// 使用支撑映射的 GJK 算法检测凸体碰撞。
///
/// ## Complexity: O(1) per iteration, typically converges in < 20 iterations
/// ## 复杂度: 每次迭代 O(1)，通常 < 20 次迭代收敛

///|
/// GJK result. / GJK 结果。
pub struct GJKResult {
  collides : Bool
  iterations : Int32
}

///|
/// Construct a GJK result. / 构造 GJK 结果。
pub fn GJKResult::new(collides : Bool, iterations : Int32) -> GJKResult {
  { collides, iterations, }
}

///|

///|
/// Support function for a convex polygon. / 凸多边形的支撑函数。
pub fn polygon_support(
  poly : Array[@core.Point2D],
  dx : Double,
  dy : Double,
) -> @core.Point2D {
  let mut best = poly[0]
  let mut best_dot = poly[0].x() * dx + poly[0].y() * dy
  for i in 1..<poly.length() {
    let dot = poly[i].x() * dx + poly[i].y() * dy
    if dot > best_dot {
      best_dot = dot
      best = poly[i]
    }
  }
  best
}

///|
/// Support function for a circle. / 圆的支撑函数。
pub fn circle_support(
  center : @core.Point2D,
  radius : Double,
  dx : Double,
  dy : Double,
) -> @core.Point2D {
  let len = (dx * dx + dy * dy).sqrt()
  if len < 0.000000000001 {
    return center
  }
  @core.Point2D::new(
    center.x() + radius * dx / len,
    center.y() + radius * dy / len,
  )
}

///|
/// Minkowski difference support function. / 闵可夫斯基差支撑函数。
pub fn minkowski_support(
  support_a : (Double, Double) -> @core.Point2D,
  support_b : (Double, Double) -> @core.Point2D,
  dx : Double,
  dy : Double,
) -> @core.Point2D {
  let pa = support_a(dx, dy)
  let pb = support_b(-dx, -dy)
  @core.Point2D::new(pa.x() - pb.x(), pa.y() - pb.y())
}

///|
/// Run GJK algorithm to check collision between two convex shapes. / 运行 GJK 算法检测两凸体碰撞。
///
/// # Arguments / 参数
/// - `support_a`: support function of shape A / 形体 A 的支撑函数
/// - `support_b`: support function of shape B / 形体 B 的支撑函数
/// - `max_iterations`: maximum iterations / 最大迭代次数
pub fn gjk_collide(
  support_a : (Double, Double) -> @core.Point2D,
  support_b : (Double, Double) -> @core.Point2D,
  max_iterations : Int32,
) -> GJKResult {
  let support = fn(dx, dy) { minkowski_support(support_a, support_b, dx, dy) }
  let d = @core.Point2D::new(1.0, 0.0)
  let s1 = support(d.x(), d.y())
  let simplex : Array[@core.Point2D] = [s1]
  let mut nd_x = -s1.x()
  let mut nd_y = -s1.y()
  for iter in 0..<max_iterations {
    let p = support(nd_x, nd_y)
    let dot = p.x() * nd_x + p.y() * nd_y
    if dot < 0.0 {
      return GJKResult::new(false, iter + 1)
    }
    simplex.push(p)
    let (contains, new_d) = gjk_simplex_update(simplex)
    if contains {
      return GJKResult::new(true, iter + 1)
    }
    if new_d.x() * new_d.x() + new_d.y() * new_d.y() < 0.000000000001 {
      return GJKResult::new(true, iter + 1)
    }
    nd_x = new_d.x()
    nd_y = new_d.y()
  }
  GJKResult::new(false, max_iterations)
}

///|
fn gjk_simplex_update(simplex : Array[@core.Point2D]) -> (Bool, @core.Point2D) {
  if simplex.length() == 2 {
    let b = simplex[0]
    let a = simplex[1]
    let ab = @core.Point2D::new(b.x() - a.x(), b.y() - a.y())
    let ao = @core.Point2D::new(-a.x(), -a.y())
    let dot = ab.x() * ao.x() + ab.y() * ao.y()
    if dot > 0.0 {
      let d = @core.Point2D::new(
        ab.x() * dot / (ab.x() * ab.x() + ab.y() * ab.y()) - a.x(),
        ab.y() * dot / (ab.x() * ab.x() + ab.y() * ab.y()) - a.y(),
      )
      return (false, d)
    }
    simplex.remove(0) |> ignore
    return (false, ao)
  }
  if simplex.length() == 3 {
    let c = simplex[0]
    let b = simplex[1]
    let a = simplex[2]
    let ab = @core.Point2D::new(b.x() - a.x(), b.y() - a.y())
    let ac = @core.Point2D::new(c.x() - a.x(), c.y() - a.y())
    let ao = @core.Point2D::new(-a.x(), -a.y())
    let ab_perp = triple_product(ac, ab, ab)
    let ac_perp = triple_product(ab, ac, ac)
    let ab_dot = ab_perp.x() * ao.x() + ab_perp.y() * ao.y()
    let ac_dot = ac_perp.x() * ao.x() + ac_perp.y() * ao.y()
    if ab_dot > 0.0 {
      simplex.remove(0) |> ignore
      return (false, ab_perp)
    }
    if ac_dot > 0.0 {
      simplex.remove(1) |> ignore
      return (false, ac_perp)
    }
    return (true, @core.Point2D::new(0.0, 0.0))
  }
  (
    false,
    @core.Point2D::new(
      -simplex[simplex.length() - 1].x(),
      -simplex[simplex.length() - 1].y(),
    ),
  )
}

///|
fn triple_product(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ac = a.x() * c.x() + a.y() * c.y()
  let bc = b.x() * c.x() + b.y() * c.y()
  @core.Point2D::new(b.x() * ac - a.x() * bc, b.y() * ac - a.y() * bc)
}

///|
/// Check collision between two convex polygons using GJK. / 使用 GJK 检测两凸多边形碰撞。
pub fn gjk_collide_polygons(
  poly1 : Array[@core.Point2D],
  poly2 : Array[@core.Point2D],
) -> GJKResult {
  let sa = fn(dx, dy) { polygon_support(poly1, dx, dy) }
  let sb = fn(dx, dy) { polygon_support(poly2, dx, dy) }
  gjk_collide(sa, sb, 100)
}

///|
/// Check collision between two circles using GJK. / 使用 GJK 检测两圆碰撞。
pub fn gjk_collide_circles(
  c1 : @core.Point2D,
  r1 : Double,
  c2 : @core.Point2D,
  r2 : Double,
) -> GJKResult {
  let sa = fn(dx, dy) { circle_support(c1, r1, dx, dy) }
  let sb = fn(dx, dy) { circle_support(c2, r2, dx, dy) }
  gjk_collide(sa, sb, 100)
}

///|
/// Check collision between a convex polygon and a circle using GJK. / 使用 GJK 检测凸多边形与圆碰撞。
pub fn gjk_collide_polygon_circle(
  poly : Array[@core.Point2D],
  center : @core.Point2D,
  radius : Double,
) -> GJKResult {
  let sa = fn(dx, dy) { polygon_support(poly, dx, dy) }
  let sb = fn(dx, dy) { circle_support(center, radius, dx, dy) }
  gjk_collide(sa, sb, 100)
}

///|
/// Check if a point is inside a convex polygon using GJK. / 使用 GJK 检测点是否在凸多边形内。
pub fn gjk_point_in_polygon(
  p : @core.Point2D,
  poly : Array[@core.Point2D],
) -> GJKResult {
  let sa = fn(dx, dy) { polygon_support(poly, dx, dy) }
  let sb = fn(_dx, _dy) { p }
  gjk_collide(sa, sb, 100)
}
