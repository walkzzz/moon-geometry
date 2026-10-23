///|
/// Write STL mesh as binary bytes. / 将 STL 网格写为二进制字节。
pub fn stl_write_binary(mesh : StlMesh) -> Bytes {
  let n = mesh.triangles.length()
  let total = 84 + n * 50
  let fa : Array[Byte] = Array::make(total, Byte::default())
  let mut pos = 0
  // 80-byte header (name)
  for c in mesh.name.iter() {
    if pos >= 80 {
      break
    }
    fa[pos] = (c.to_int() & 255).to_byte()
    pos += 1
  }
  while pos < 80 {
    fa[pos] = Byte::default()
    pos += 1
  }
  // triangle count (uint32 little-endian) at offset 80
  set_uint32_le(fa, 80, n)
  pos = 84
  for t in mesh.triangles {
    pos = set_float_le(fa, pos, t.normal.x)
    pos = set_float_le(fa, pos, t.normal.y)
    pos = set_float_le(fa, pos, t.normal.z)
    pos = set_float_le(fa, pos, t.v0.x)
    pos = set_float_le(fa, pos, t.v0.y)
    pos = set_float_le(fa, pos, t.v0.z)
    pos = set_float_le(fa, pos, t.v1.x)
    pos = set_float_le(fa, pos, t.v1.y)
    pos = set_float_le(fa, pos, t.v1.z)
    pos = set_float_le(fa, pos, t.v2.x)
    pos = set_float_le(fa, pos, t.v2.y)
    pos = set_float_le(fa, pos, t.v2.z)
    // attribute byte count = 0
    fa[pos] = Byte::default()
    fa[pos + 1] = Byte::default()
    pos += 2
  }
  Bytes::from_iter(fa.iter())
}
