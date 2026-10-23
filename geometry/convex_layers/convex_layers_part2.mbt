///|
/// Count the number of convex layers. / 计算凸包层次数。
pub fn layer_count(points : Array[@core.Point2D]) -> Int32 {
  convex_layers(points).length()
}

///|
/// Get the outermost layer (first convex hull). / 获取最外层（第一个凸包）。
pub fn outermost_layer(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let layers = convex_layers(points)
  if layers.length() > 0 {
    layers[0]
  } else {
    []
  }
}
