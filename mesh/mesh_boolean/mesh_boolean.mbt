///|
/// Boolean operation type. / 布尔运算类型。
pub(all) enum BoolOp {
  Union
  Intersection
  Difference
}


///|

/// Result of mesh boolean operation. / 网格布尔运算结果。
pub struct MeshBoolResult {
  vertices : Array[@core.Point3D]
  faces : Array[(Int, Int, Int)]
}


///|
/// Construct mesh bool result. / 构造网格布尔结果。
pub fn MeshBoolResult::new(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
) -> MeshBoolResult {
  { vertices, faces }
}


///|
/// Check if a point is inside a mesh (ray casting). / 检查点是否在网格内（射线法）。
fn point_inside_mesh(
  p : @core.Point3D,
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
) -> Bool {
  let ray_dir = @core.Point3D::new(0.5773502691896258, 0.5773502691896258, 0.5773502691896258)
  let mut count = 0
  for f in faces {
    let v0 = vertices[f.0]
    let v1 = vertices[f.1]
    let v2 = vertices[f.2]
    if ray_triangle_intersect(p, ray_dir, v0, v1, v2) {
      count += 1
    }
  }
  count % 2 == 1
}
