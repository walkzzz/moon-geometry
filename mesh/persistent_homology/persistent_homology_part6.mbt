///|
/// Compute persistent homology from a filtration. / 由过滤计算持久同调。
pub fn persistent_homology(
  simplices : Array[SimplexWithFiltration],
) -> PersistenceDiagram {
  { barcodes: compute_barcode(simplices), }
}
