///|
/// # Affine Arithmetic
/// # 仿射算术
///
/// Affine arithmetic for tracking correlation in interval computation.
/// 仿射算术，用于追踪区间计算中的相关性。


///|
pub struct AffineForm {
  center : Double
  errors : Array[Double]
}


///|
pub fn AffineForm::new(center : Double, errors : Array[Double]) -> AffineForm {
  { center, errors }
}
