///|
/// Write PLY mesh as ASCII text. / 将 PLY 网格写为 ASCII 文本。
pub fn ply_write_ascii(mesh : PlyMesh) -> String {
  let mut out = "ply\nformat ascii 1.0\n"
  out += "element vertex " + mesh.vertices.length().to_string() + "\n"
  out += "property float x\nproperty float y\nproperty float z\n"
  out += "element face " + mesh.faces.length().to_string() + "\n"
  out += "property list uchar int vertex_indices\nend_header\n"
  for p in mesh.vertices {
    out += p.x.to_string() + " " + p.y.to_string() + " " + p.z.to_string() + "\n"
  }
  for f in mesh.faces {
    out += f.length().to_string()
    for idx in f {
      out += " " + idx.to_string()
    }
    out += "\n"
  }
  out
}
