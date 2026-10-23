///|
/// 3D convex hull face (triangle indices). / 三维凸包面。
pub struct HullFace {
  v0 : Int32
  v1 : Int32
  v2 : Int32
} derive(Debug)

///|
pub extend HullFace with @moonbitlang/core/debug.Debug::{to_repr}
