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
  max_iterations : Int,
) -> GJKResult {
  let support = fn(dx, dy) {
    minkowski_support(support_a, support_b, dx, dy)
  }
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

fn gjk_simplex_update(simplex : Array[@core.Point2D]) -> (Bool, @core.Point2D) {
  if simplex.length() == 2 {
    let b = simplex[0]
    let a = simplex[1]
    let ab = @core.Point2D::new(b.x() - a.x(), b.y() - a.y())
    let ao = @core.Point2D::new(-a.x(), -a.y())
    let dot = ab.x() * ao.x() + ab.y() * ao.y()
    if dot > 0.0 {
      let d = @core.Point2D::new(ab.x() * dot / (ab.x() * ab.x() + ab.y() * ab.y()) - a.x(), ab.y() * dot / (ab.x() * ab.x() + ab.y() * ab.y()) - a.y())
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
  (false, @core.Point2D::new(-simplex[simplex.length() - 1].x(), -simplex[simplex.length() - 1].y()))
}

fn triple_product(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ac = a.x() * c.x() + a.y() * c.y()
  let bc = b.x() * c.x() + b.y() * c.y()
  @core.Point2D::new(b.x() * ac - a.x() * bc, b.y() * ac - a.y() * bc)
}
