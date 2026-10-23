///|
pub extend Similarity with @core.Composable::{compose}


///|
/// Compose two similarity transformations (self then other). / 组合两个相似变换（先 self 后 other）。
pub impl @core.Composable for Similarity with compose(self, other) {
  let c = @math.cos(self.angle)
  let sn = @math.sin(self.angle)
  {
    scale: self.scale * other.scale,
    angle: self.angle + other.angle,
    tx: self.scale * (c * other.tx - sn * other.ty) + self.tx,
    ty: self.scale * (sn * other.tx + c * other.ty) + self.ty,
  }
}
