///|
/// Polyhedron boolean operation result. / 多面体布尔运算结果。
pub struct PolyBoolResult {
  vertices : Array[@core.Point3D]
  faces : Array[Array[Int]]
  success : Bool
}


///|
/// Construct poly bool result. / 构造多面体布尔结果。
pub fn PolyBoolResult::new(
  vertices : Array[@core.Point3D],
  faces : Array[Array[Int]],
  success : Bool,
) -> PolyBoolResult {
  { vertices, faces, success }
}
