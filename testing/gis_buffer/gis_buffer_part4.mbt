///|
/// Minkowski sum of two convex polygons (both CCW). / 两个凸多边形（均为逆时针）的 Minkowski 和。
pub fn minkowski_sum_convex(
  poly_a : @core.Polygon,
  poly_b : @core.Polygon,
) -> @core.Polygon {
  let na = poly_a.size()
  let nb = poly_b.size()
  if na == 0 || nb == 0 {
    return @core.Polygon::new([])
  }
  let result : Array[@core.Point2D] = []
  let mut ia = 0
  let mut ib = 0
  let mut count = 0
  let total = na + nb
  while count < total {
    let pa = poly_a.get(ia)
    let pb = poly_b.get(ib)
    result.push(@core.Point2D::new(pa.x + pb.x, pa.y + pb.y))
    let ea = poly_a.get(ia + 1).sub(poly_a.get(ia))
    let eb = poly_b.get(ib + 1).sub(poly_b.get(ib))
    let cross = ea.x * eb.y - ea.y * eb.x
    if cross > 0.0 {
      ia = (ia + 1) % na
    } else if cross < 0.0 {
      ib = (ib + 1) % nb
    } else {
      ia = (ia + 1) % na
      ib = (ib + 1) % nb
    }
    count += 1
  }
  @core.Polygon::new(result)
}


///|
/// Buffer a convex polygon by Minkowski sum with a disk (approximated by n-gon). / 通过与圆盘（n 边形近似）的 Minkowski 和缓冲凸多边形。
pub fn convex_polygon_buffer(
  poly : @core.Polygon,
  radius : Double,
  n : Int,
) -> @core.Polygon {
  let disk = point_buffer(@core.Point2D::new(0.0, 0.0), radius, n)
  minkowski_sum_convex(poly, disk)
}
