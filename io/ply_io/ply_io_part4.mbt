///|
/// Write PLY mesh as binary bytes (compact format).
/// 将 PLY 网格写为二进制字节（紧凑格式）。
pub fn ply_write_binary(mesh : PlyMesh) -> Bytes {
  let nv = mesh.vertices.length()
  let nf = mesh.faces.length()
  let mut total = 8 + nv * 12
  for f in mesh.faces {
    total += 1 + f.length() * 4
  }
  let buf : Array[Byte] = Array::make(total, Byte::default())
  let mut pos = 0
  pos = set_u32le(buf, pos, nv)
  for p in mesh.vertices {
    pos = set_f32le(buf, pos, p.x)
    pos = set_f32le(buf, pos, p.y)
    pos = set_f32le(buf, pos, p.z)
  }
  pos = set_u32le(buf, pos, nf)
  for f in mesh.faces {
    buf[pos] = f.length().to_byte()
    pos += 1
    for idx in f {
      pos = set_u32le(buf, pos, idx)
    }
  }
  Bytes::from_iter(buf.iter())
}
