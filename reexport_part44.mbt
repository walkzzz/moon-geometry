///|
/// Visibility polygon (general). / 可见多边形（通用）。
pub fn visibility_polygon(poly : Array[Point2D], pt : Point2D) -> Array[Point2D] {
  @visibility.visibility_polygon(poly, pt)
}


///|
/// Count visible vertices. / 计算可见顶点数。
pub fn visible_vertex_count(poly : Array[Point2D], pt : Point2D) -> Int {
  @visibility.visible_vertex_count(poly, pt)
}

// ---------------------------------------------------------------------------
// art_gallery: art gallery problem / 美术馆问题
// ---------------------------------------------------------------------------


///|
/// Upper bound on guards (floor(n/3)). / 守卫数上界。
pub fn art_gallery_guard_count(n : Int) -> Int {
  @art_gallery.art_gallery_guard_count(n)
}


///|
/// Place guards at vertices. / 在顶点放置守卫。
pub fn art_gallery_place_guards(poly : Array[Point2D]) -> Array[Point2D] {
  @art_gallery.art_gallery_place_guards(poly)
}


///|
/// Check if guards cover all vertices. / 检查守卫是否覆盖所有顶点。
pub fn art_gallery_covers_vertices(
  poly : Array[Point2D],
  guards : Array[Point2D],
) -> Bool {
  @art_gallery.art_gallery_covers_vertices(poly, guards)
}
