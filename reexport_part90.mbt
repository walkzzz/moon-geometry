///|
pub fn dynamic_hull_insert(dh : DynamicHull, p : Point2D) -> Unit {
  @convex_hull_dynamic.DynamicHull::insert(dh, p)
}

///|
pub fn dynamic_hull_get_hull(dh : DynamicHull) -> Array[Point2D] {
  @convex_hull_dynamic.DynamicHull::get_hull(dh)
}

///|
pub fn dynamic_hull_size(dh : DynamicHull) -> Int {
  @convex_hull_dynamic.DynamicHull::size(dh)
}

///|
pub fn dynamic_hull_contains(dh : DynamicHull, p : Point2D) -> Bool {
  @convex_hull_dynamic.DynamicHull::contains(dh, p)
}

// ---------------------------------------------------------------------------
// convex_layers: Convex layers (onion decomposition) / 凸包层次（洋葱分解）
// ---------------------------------------------------------------------------

///|
pub fn convex_layers(points : Array[Point2D]) -> Array[Array[Point2D]] {
  @convex_layers.convex_layers(points)
}

///|
pub fn layer_count(points : Array[Point2D]) -> Int {
  @convex_layers.layer_count(points)
}

///|
pub fn outermost_layer(points : Array[Point2D]) -> Array[Point2D] {
  @convex_layers.outermost_layer(points)
}

// ---------------------------------------------------------------------------
// concave_hull: Concave hull / 凹包
// ---------------------------------------------------------------------------