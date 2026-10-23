///|
/// Compare two doubles with absolute tolerance.
/// 比较两个 Double 值的绝对容差。
pub fn approx_eq(a : Double, b : Double, eps : Double) -> Bool where {
  proof_ensure: result => result == ((b - a).abs() <= eps),
} {
  (a - b).abs() <= eps
}


///|
/// Default epsilon for geometry comparisons.
/// 几何比较的默认精度。
pub let default_eps : Double = 0.000000001


///|
pub extend Point2D with @moonbitlang/core/debug.Debug::{to_repr}


///|
pub extend Point3D with @moonbitlang/core/debug.Debug::{to_repr}


///|
/// Cross product of vectors OA and OB: (a-o) × (b-o).
/// 向量 OA 和 OB 的叉积：(a-o) × (b-o)。
/// Positive => O->A->B is a counter-clockwise turn.
/// 正值 => O->A->B 为逆时针方向。
pub fn turn(o : Point2D, a : Point2D, b : Point2D) -> Double where {
  proof_ensure: result => result == -((b.x - o.x) * (a.y - o.y) - (b.y - o.y) * (a.x - o.x)),
} {
  (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
}