///|
/// Invert similarity transformation. / 求相似变换的逆。
pub fn Similarity::inverse(s : Similarity) -> Similarity? {
  if @core.approx_eq(s.scale, 0.0, 0.000000001) {
    return None
  }
  let inv_s = 1.0 / s.scale
  let c = @math.cos(s.angle)
  let sn = @math.sin(s.angle)
  Some({
    scale: inv_s,
    angle: -s.angle,
    tx: -inv_s * (c * s.tx + sn * s.ty),
    ty: -inv_s * (-sn * s.tx + c * s.ty),
  })
}
