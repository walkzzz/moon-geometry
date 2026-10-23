///|
/// UV coordinate for parameterization. / 参数化 UV 坐标。
pub struct UV {
  u : Double
  v : Double
}


///|
/// Construct UV. / 构造 UV。
pub fn UV::new(u : Double, v : Double) -> UV {
  { u, v }
}


///|
/// Mesh parameterization result (UV per vertex). / 网格参数化结果（每顶点 UV）。
pub struct MeshParamResult {
  uv : Array[UV]
  success : Bool
}


///|
/// Construct param result. / 构造参数化结果。
pub fn MeshParamResult::new(uv : Array[UV], success : Bool) -> MeshParamResult {
  { uv, success }
}
