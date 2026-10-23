///|
/// Check if a triangle (a, b, c) is counter-clockwise (convex vertex).
/// 检查三角形 (a, b, c) 是否为逆时针（凸顶点）。
fn is_convex_vertex(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  @core.turn(a, b, c) > 0.0
}
