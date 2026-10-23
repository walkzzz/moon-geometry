///|
pub fn kruskal_mst(n : Int, edges : Array[WEdge]) -> Array[WEdge] {
  @spanning_tree.kruskal_mst(n, edges)
}

///|
pub fn mst_weight(n : Int, edges : Array[WEdge]) -> Double {
  @spanning_tree.mst_weight(n, edges)
}

///|
pub fn mst_edge_count(n : Int, edges : Array[WEdge]) -> Int {
  @spanning_tree.mst_edge_count(n, edges)
}

///|
pub fn is_connected(n : Int, edges : Array[WEdge]) -> Bool {
  @spanning_tree.is_connected(n, edges)
}

// ---------------------------------------------------------------------------
// polynomial: Polynomial operations / 多项式运算
// ---------------------------------------------------------------------------

///|
pub fn poly_eval(coeffs : Array[Double], x : Double) -> Double {
  @polynomial.poly_eval(coeffs, x)
}

///|
pub fn poly_derivative(coeffs : Array[Double]) -> Array[Double] {
  @polynomial.poly_derivative(coeffs)
}

///|
pub fn poly_add(a : Array[Double], b : Array[Double]) -> Array[Double] {
  @polynomial.poly_add(a, b)
}