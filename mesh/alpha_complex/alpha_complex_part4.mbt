///|
/// Check if a simplex is alpha-exposed (circumradius <= alpha). / 检查单纯形是否为 Alpha 暴露（外接圆半径 <= alpha）。
pub fn is_alpha_exposed(simplex : AlphaSimplex, alpha : Double) -> Bool {
  simplex.circumradius <= alpha + 0.0000000001
}
