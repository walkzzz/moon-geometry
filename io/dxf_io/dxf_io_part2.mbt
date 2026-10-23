///|
/// Write DXF document as text. / 将 DXF 文档写为文本。
pub fn dxf_write(doc : DxfDocument) -> String {
  let mut out = "0\nSECTION\n2\nENTITIES\n"
  for e in doc.entities {
    out += entity_to_dxf(e)
  }
  out + "0\nENDSEC\n0\nEOF\n"
}

fn entity_to_dxf(e : DxfEntity) -> String {
  match e {
    DxfLine(p1, p2) =>
      "0\nLINE\n10\n" +
      p1.x.to_string() +
      "\n20\n" +
      p1.y.to_string() +
      "\n30\n" +
      p1.z.to_string() +
      "\n11\n" +
      p2.x.to_string() +
      "\n21\n" +
      p2.y.to_string() +
      "\n31\n" +
      p2.z.to_string() +
      "\n"
    DxfCircle(c, r) =>
      "0\nCIRCLE\n10\n" +
      c.x().to_string() +
      "\n20\n" +
      c.y().to_string() +
      "\n40\n" +
      r.to_string() +
      "\n"
    DxfPolyline(pts) => {
      let mut s = "0\nLWPOLYLINE\n90\n" + pts.length().to_string() + "\n"
      for p in pts {
        s += "10\n" + p.x().to_string() + "\n20\n" + p.y().to_string() + "\n"
      }
      s
    }
  }
}
