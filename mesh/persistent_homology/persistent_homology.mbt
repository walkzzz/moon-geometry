///|
/// A persistence barcode: birth, death, and dimension. / 持久同调条形码：出生、死亡和维度。
pub struct Barcode {
  birth : Double
  death : Double
  dimension : Int
}


///|
/// Construct a barcode. / 构造条形码。
pub fn Barcode::new(
  birth : Double,
  death : Double,
  dimension : Int,
) -> Barcode {
  { birth, death, dimension }
}


///|
/// Check if the barcode is infinite (death is infinity). / 检查条形码是否为无穷（死亡值为无穷）。
pub fn Barcode::is_infinite(self : Barcode) -> Bool {
  self.death >= 999999999.0
}


///|
/// A simplex with its filtration value. / 带过滤值的单纯形。
pub struct SimplexWithFiltration {
  vertices : Array[Int]
  filtration : Double
}


///|
/// Construct a simplex with filtration value. / 构造带过滤值的单纯形。
pub fn SimplexWithFiltration::new(
  vertices : Array[Int],
  filtration : Double,
) -> SimplexWithFiltration {
  { vertices, filtration }
}


///|
/// Persistence diagram: collection of barcodes. / 持久同调图：条形码集合。
pub struct PersistenceDiagram {
  barcodes : Array[Barcode]
}
