///|
/// A face in a planar subdivision. / 平面细分中的面。
pub struct Face {
  boundary : Array[@core.Point2D]
  holes : Array[Array[@core.Point2D]]
}
