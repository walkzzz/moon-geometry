///|
/// Similarity transformation: uniform scale + rotation + translation. / 相似变换：均匀缩放 + 旋转 + 平移。
pub struct Similarity {
  scale : Double
  angle : Double
  tx : Double
  ty : Double
}


///|
/// Create identity similarity transformation. / 创建单位相似变换。
pub fn Similarity::identity() -> Similarity {
  { scale: 1.0, angle: 0.0, tx: 0.0, ty: 0.0 }
}


///|
/// Create similarity from scale only. / 仅由缩放创建相似变换。
pub fn Similarity::scaling(s : Double) -> Similarity {
  { scale: s, angle: 0.0, tx: 0.0, ty: 0.0 }
}
