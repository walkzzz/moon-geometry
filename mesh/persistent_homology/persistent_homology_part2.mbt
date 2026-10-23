///|
/// Construct an empty persistence diagram. / 构造空的持久同调图。
pub fn PersistenceDiagram::new() -> PersistenceDiagram {
  { barcodes: [] }
}


///|
/// Get the number of barcodes. / 获取条形码数量。
pub fn PersistenceDiagram::barcode_count(pd : PersistenceDiagram) -> Int {
  pd.barcodes.length()
}


///|
/// Get the dimension of a simplex (number of vertices - 1). / 获取单纯形维度（顶点数 - 1）。
fn simplex_dim(s : SimplexWithFiltration) -> Int {
  s.vertices.length() - 1
}
