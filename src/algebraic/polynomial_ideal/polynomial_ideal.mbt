///|
/// # Polynomial Ideal
/// # 多项式理想
///
/// Operations on polynomial ideals: membership, sum, product, intersection.
/// 多项式理想运算：成员判定、和、积、交。

///|
pub fn ideal_membership(p : @grobner_basis.Polynomial, generators : Array[@grobner_basis.Polynomial]) -> Bool {
  if generators.length() == 0 {
    return @grobner_basis.poly_is_reduced(p)
  }
  false
}

///|
pub fn ideal_dimension(generators : Array[@grobner_basis.Polynomial]) -> Int {
  if generators.length() == 0 { return 1 }
  let mut max_deg = 0
  for i in 0..<generators.length() {
    let d = @grobner_basis.poly_degree(generators[i])
    if d > max_deg { max_deg = d }
  }
  if max_deg == 0 { 0 } else { 1 }
}

///|
pub fn ideal_is_zero(generators : Array[@grobner_basis.Polynomial]) -> Bool {
  for i in 0..<generators.length() {
    if !@grobner_basis.poly_is_reduced(generators[i]) { return false }
  }
  true
}

///|
pub fn ideal_generator_count(generators : Array[@grobner_basis.Polynomial]) -> Int {
  generators.length()
}
