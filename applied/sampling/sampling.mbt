///|
/// Uniform grid sampling in a rectangle. / 在矩形中均匀网格采样。
pub fn grid_sample(
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  nx : Int32,
  ny : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let dx = (x_hi - x_lo) / nx.to_double()
  let dy = (y_hi - y_lo) / ny.to_double()
  for i in 0..<nx {
    for j in 0..<ny {
      result.push(
        @core.Point2D::new(
          x_lo + (i.to_double() + 0.5) * dx,
          y_lo + (j.to_double() + 0.5) * dy,
        ),
      )
    }
  }
  result
}
