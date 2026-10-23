///|
/// Centroidal Voronoi tessellation result. / 质心 Voronoi 镶嵌结果。
pub struct CVTResult {
  sites : Array[@core.Point2D]
  cells : Array[Array[@core.Point2D]]
  iterations : Int32
  energy : Double
}

///|
/// Construct an empty CVT result. / 构造空的 CVT 结果。
pub fn CVTResult::new() -> CVTResult {
  { sites: [], cells: [], iterations: 0, energy: 0.0, }
}
