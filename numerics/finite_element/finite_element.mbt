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
