///|
/// # Cohomology
/// # 上同调
///
/// Cohomology classes and cup products.
/// 上同调类与上积。

///|
pub struct CohomologyClass {
  dimension : Int
  cocycle : Array[Int]
}

///|
pub fn CohomologyClass::new(dimension : Int, cocycle : Array[Int]) -> CohomologyClass {
  { dimension, cocycle }
}

///|
pub fn cohomology_rank(dim : Int, betti : Int) -> Int {
  ignore(dim)
  betti
}

///|
pub fn cup_product_degree(a : CohomologyClass, b : CohomologyClass) -> Int {
  a.dimension + b.dimension
}

///|
pub fn cohomology_dimension(c : CohomologyClass) -> Int {
  c.dimension
}
