///|
/// Create similarity from rotation only. / 仅由旋转创建相似变换。
pub fn Similarity::rotation(angle : Double) -> Similarity {
  { scale: 1.0, angle, tx: 0.0, ty: 0.0, }
}

///|
/// Create similarity from translation only. / 仅由平移创建相似变换。
pub fn Similarity::translation(tx : Double, ty : Double) -> Similarity {
  { scale: 1.0, angle: 0.0, tx, ty, }
}
