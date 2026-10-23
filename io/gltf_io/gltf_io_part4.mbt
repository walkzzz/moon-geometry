///|
/// Write glTF mesh as binary bytes (compact format).
/// 将 glTF 网格写为二进制字节（紧凑格式）。
pub fn gltf_write_binary(mesh : GltfMesh) -> Bytes {
  let nv = mesh.vertices.length()
  let ni = mesh.indices.length()
  let total = 8 + nv * 12 + ni * 4
  let buf : Array[Byte] = Array::make(total, Byte::default())
  let mut pos = 0
  pos = set_u32le(buf, pos, nv)
  pos = set_u32le(buf, pos, ni)
  for p in mesh.vertices {
    pos = set_f32le(buf, pos, p.x)
    pos = set_f32le(buf, pos, p.y)
    pos = set_f32le(buf, pos, p.z)
  }
  for idx in mesh.indices {
    pos = set_u32le(buf, pos, idx)
  }
  Bytes::from_iter(buf.iter())
}
