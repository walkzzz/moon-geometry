///|
/// # Intersection Multiplicity
/// # 相交重数
///
/// Local intersection multiplicity of algebraic varieties.
/// 代数簇的局部相交重数。

///|
pub fn intersection_multiplicity(order_a : Int, order_b : Int) -> Int {
  if order_a < order_b { order_a } else { order_b }
}

///|
pub fn tangency_multiplicity(contact_order : Int) -> Int {
  contact_order
}

///|
pub fn total_multiplicity(local_mults : Array[Int]) -> Int {
  let mut sum = 0
  for i in 0..<local_mults.length() {
    sum += local_mults[i]
  }
  sum
}

///|
pub fn is_simple_intersection(mult : Int) -> Bool {
  mult == 1
}

///|
pub fn multiplicity_from_tangent(tangent_dot : Double, tol : Double) -> Int {
  if tangent_dot.abs() > tol { 1 } else { 2 }
}
