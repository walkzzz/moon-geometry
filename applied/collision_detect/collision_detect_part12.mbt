///|
/// Narrow phase: AABB-polygon collision. / 窄相：AABB-多边形碰撞。
pub fn aabb_polygon_collide(box : AABB, poly : Array[@core.Point2D]) -> Bool {
  let corners = [
    @core.Point2D::new(box.min_x, box.min_y),
    @core.Point2D::new(box.max_x, box.min_y),
    @core.Point2D::new(box.max_x, box.max_y),
    @core.Point2D::new(box.min_x, box.max_y),
  ]
  polygon_polygon_collide(corners, poly)
}
