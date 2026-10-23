///|
/// 3D convex hull face (triangle indices). / 三维凸包面。
pub struct HullFace {
  v0 : Int
  v1 : Int
  v2 : Int
} derive(Debug)

pub extend HullFace with @moonbitlang/core/debug.Debug::{to_repr}
