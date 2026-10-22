///|
/// # Finite Element Method
/// # 有限元方法
///
/// FEM for elliptic PDEs on triangular meshes.
/// 三角网格上椭圆 PDE 的有限元方法。

///|
pub fn element_stiffness(grad_u : (Double, Double), grad_v : (Double, Double), area : Double) -> Double {
  let (gux, guy) = grad_u
  let (gvx, gvy) = grad_v
  area * (gux * gvx + guy * gvy)
}

///|
pub fn element_mass(u_val : Double, v_val : Double, area : Double) -> Double {
  area * u_val * v_val / 3.0
}

///|
pub fn assemble_stiffness(n : Int, elements : Array[(Int, Int, Int, Double)]) -> Array[Array[Double]] {
  let k : Array[Array[Double]] = Array::make(n, Array::make(n, 0.0))
  for e in 0..<elements.length() {
    let (i, j, _l, val) = elements[e]
    k[i][j] += val
    k[j][i] += val
  }
  k
}

///|
pub fn apply_dirichlet(k : Array[Array[Double]], boundary_nodes : Array[Int]) -> Array[Array[Double]] {
  for i in 0..<boundary_nodes.length() {
    let idx = boundary_nodes[i]
    for j in 0..<k.length() {
      k[idx][j] = 0.0
      k[j][idx] = 0.0
    }
    k[idx][idx] = 1.0
  }
  k
}

///|
pub fn fem_l2_error(exact : Array[Double], approx : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<exact.length() {
    let diff = exact[i] - approx[i]
    sum += diff * diff
  }
  sum.sqrt()
}
