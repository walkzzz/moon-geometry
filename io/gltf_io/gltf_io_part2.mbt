///|
/// Write glTF 2.0 mesh as JSON text (simplified embedded format).
/// 将 glTF 2.0 网格写为 JSON 文本（简化嵌入格式）。
pub fn gltf_write_json(mesh : GltfMesh) -> String {
  let mut out = "{\"asset\":{\"version\":\"2.0\"},\"vertices\":["
  for i in 0..<mesh.vertices.length() {
    let p = mesh.vertices[i]
    if i > 0 {
      out += ","
    }
    out += p.x.to_string() + "," + p.y.to_string() + "," + p.z.to_string()
  }
  out += "],\"indices\":["
  for i in 0..<mesh.indices.length() {
    if i > 0 {
      out += ","
    }
    out += mesh.indices[i].to_string()
  }
  out + "]}"
}
