///|
/// Alpha complex. / Alpha 复形。
pub type AlphaComplex = @alpha_complex.AlphaComplex

pub fn alpha_complex_new() -> AlphaComplex {
  @alpha_complex.AlphaComplex::new()
}

pub fn alpha_complex_simplex_count(ac : AlphaComplex) -> Int {
  @alpha_complex.AlphaComplex::simplex_count(ac)
}

pub fn is_alpha_exposed(simplex : AlphaSimplex, alpha : Double) -> Bool {
  @alpha_complex.is_alpha_exposed(simplex, alpha)
}

pub fn alpha_complex(points : Array[Point2D], alpha : Double) -> AlphaComplex {
  @alpha_complex.alpha_complex(points, alpha)
}

pub fn alpha_shape(points : Array[Point2D], alpha : Double) -> Array[(Int, Int)] {
  @alpha_complex.alpha_shape(points, alpha)
}

pub fn alpha_complex_count(ac : AlphaComplex) -> Int {
  @alpha_complex.alpha_complex_count(ac)
}

// ---------------------------------------------------------------------------
// persistent_homology: Persistent homology / 持久同调
// ---------------------------------------------------------------------------


///|
/// Persistence barcode. / 持久同调条形码。
pub type Barcode = @persistent_homology.Barcode


///|
/// Simplex with filtration value. / 带过滤值的单纯形。
pub type SimplexWithFiltration = @persistent_homology.SimplexWithFiltration


///|
/// Persistence diagram. / 持久同调图。
pub type PersistenceDiagram = @persistent_homology.PersistenceDiagram

pub fn barcode_new(birth : Double, death : Double, dimension : Int) -> Barcode {
  @persistent_homology.Barcode::new(birth, death, dimension)
}

pub fn barcode_is_infinite(b : Barcode) -> Bool {
  @persistent_homology.Barcode::is_infinite(b)
}

pub fn simplex_with_filtration_new(
  vertices : Array[Int],
  filtration : Double,
) -> SimplexWithFiltration {
  @persistent_homology.SimplexWithFiltration::new(vertices, filtration)
}

pub fn persistence_diagram_new() -> PersistenceDiagram {
  @persistent_homology.PersistenceDiagram::new()
}

pub fn persistence_diagram_barcode_count(pd : PersistenceDiagram) -> Int {
  @persistent_homology.PersistenceDiagram::barcode_count(pd)
}

pub fn persistence_pairs(
  simplices : Array[SimplexWithFiltration],
) -> Array[(Int, Int)] {
  @persistent_homology.persistence_pairs(simplices)
}

pub fn compute_barcode(
  simplices : Array[SimplexWithFiltration],
) -> Array[Barcode] {
  @persistent_homology.compute_barcode(simplices)
}

pub fn persistent_homology(
  simplices : Array[SimplexWithFiltration],
) -> PersistenceDiagram {
  @persistent_homology.persistent_homology(simplices)
}

pub fn betti_from_barcode(barcodes : Array[Barcode], threshold : Double) -> Array[Int] {
  @persistent_homology.betti_from_barcode(barcodes, threshold)
}

// ---------------------------------------------------------------------------
// betti_numbers: Betti numbers / Betti 数
// ---------------------------------------------------------------------------


///|
/// Betti numbers result. / Betti 数结果。
pub type BettiResult = @betti_numbers.BettiResult

pub fn betti_result_new(b0 : Int, b1 : Int, b2 : Int) -> BettiResult {
  @betti_numbers.BettiResult::new(b0, b1, b2)
}

pub fn betti_numbers_0(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.betti_0(simplices)
}

pub fn betti_1(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.betti_1(simplices)
}

pub fn betti_2(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.betti_2(simplices)
}

pub fn betti_numbers(simplices : Array[Array[Int]]) -> BettiResult {
  @betti_numbers.betti_numbers(simplices)
}

pub fn compute_euler(simplices : Array[Array[Int]]) -> Int {
  @betti_numbers.compute_euler(simplices)
}

// ---------------------------------------------------------------------------
// reeb_graph: Reeb graph / Reeb 图
// ---------------------------------------------------------------------------


///|
/// Critical point type. / 临界点类型。
pub type CriticalType = @reeb_graph.CriticalType


///|
/// Reeb graph node. / Reeb 图节点。
pub type ReebNode = @reeb_graph.ReebNode
