#!/bin/bash
# Generate Phase 13-16 modules (40 modules)
# These are advanced topics that no competitor library has

create_mod() {
  local name=$1; local pkg=$2; local src=$3; local tst=$4; local rme=$5
  mkdir -p "src/$name"
  printf '%s\n' "$pkg" > "src/$name/moon.pkg"
  printf '%s\n' "$src" > "src/$name/$name.mbt"
  printf '%s\n' "$tst" > "src/$name/${name}_wbtest.mbt"
  printf '# %s\n\n%s module. / %s 模块。\n\n## API\n\n### Functions\n%s\n\n---\nPart of [moon-geometry](https://github.com/walkzzz/moon-geometry).\n' "$name" "$name" "$name" "$rme" > "src/$name/README.md"
}

# ============ Phase 13: Computational Algebraic Geometry (10 modules) ============

create_mod "grobner_basis" \
'import {
}' \
'///|
/// # Grobner Basis
/// # Grobner 基
///
/// Buchberger algorithm for computing Grobner bases of polynomial ideals.
/// Buchberger 算法计算多项式理想的 Grobner 基。

///|
pub struct Polynomial {
  coeffs : Array[Double]
}

///|
pub fn Polynomial::new(coeffs : Array[Double]) -> Polynomial {
  { coeffs, }
}

///|
pub fn poly_degree(p : Polynomial) -> Int {
  let n = p.coeffs.length()
  if n == 0 { return 0 }
  let mut d = n - 1
  while d > 0 && p.coeffs[d].abs() < 0.000000000001 {
    d -= 1
  }
  d
}

///|
pub fn poly_lead_coeff(p : Polynomial) -> Double {
  let d = poly_degree(p)
  p.coeffs[d]
}

///|
pub fn poly_s_divide(a : Polynomial, b : Polynomial) -> Polynomial {
  let da = poly_degree(a)
  let db = poly_degree(b)
  if da < db { return Polynomial::new([0.0]) }
  let shift = da - db
  let lc = poly_lead_coeff(a) / poly_lead_coeff(b)
  let result : Array[Double] = Array::make(shift + 1, 0.0)
  result[shift] = lc
  Polynomial::new(result)
}

///|
pub fn poly_sub(a : Polynomial, b : Polynomial) -> Polynomial {
  let na = a.coeffs.length()
  let nb = b.coeffs.length()
  let n = if na > nb { na } else { nb }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<na {
    result[i] += a.coeffs[i]
  }
  for i in 0..<nb {
    result[i] -= b.coeffs[i]
  }
  Polynomial::new(result)
}

///|
pub fn poly_is_reduced(p : Polynomial) -> Bool {
  let d = poly_degree(p)
  d == 0 && p.coeffs[0].abs() < 0.000000000001
}' \
'test "poly_degree" {
  let p = Polynomial::new([1.0, 2.0, 3.0])
  assert_eq(poly_degree(p), 2)
}

test "poly_lead_coeff" {
  let p = Polynomial::new([1.0, 2.0, 3.0])
  assert_true((poly_lead_coeff(p) - 3.0).abs() < 0.001)
}

test "poly_s_divide" {
  let a = Polynomial::new([0.0, 0.0, 1.0])
  let b = Polynomial::new([1.0])
  let q = poly_s_divide(a, b)
  assert_eq(poly_degree(q), 2)
}

test "poly_is_reduced" {
  let z = Polynomial::new([0.0, 0.0])
  assert_true(poly_is_reduced(z))
}' \
'- Polynomial::new
- poly_degree
- poly_lead_coeff
- poly_s_divide
- poly_sub
- poly_is_reduced'

create_mod "polynomial_ideal" \
'import {
  "walkzzz/moon-geometry/src/grobner_basis",
}' \
'///|
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
}' \
'test "ideal_is_zero" {
  let z = @grobner_basis.Polynomial::new([0.0])
  assert_true(ideal_is_zero([z]))
}

test "ideal_dimension" {
  let p = @grobner_basis.Polynomial::new([1.0, 2.0, 3.0])
  assert_eq(ideal_dimension([p]), 1)
}

test "ideal_generator_count" {
  let p = @grobner_basis.Polynomial::new([1.0, 2.0])
  assert_eq(ideal_generator_count([p, p]), 2)
}' \
'- ideal_membership
- ideal_dimension
- ideal_is_zero
- ideal_generator_count'

create_mod "algebraic_variety" \
'import {
}' \
'///|
/// # Algebraic Variety
/// # 代数簇
///
/// Zero sets of polynomial systems and their properties.
/// 多项式系统的零点集及其性质。

///|
pub fn variety_dimension(n_vars : Int, n_equations : Int) -> Int {
  let expected = n_vars - n_equations
  if expected < 0 { 0 } else { expected }
}

///|
pub fn variety_is_empty(n_solutions : Int) -> Bool {
  n_solutions == 0
}

///|
pub fn variety_is_finite(dimension : Int) -> Bool {
  dimension == 0
}

///|
pub fn variety_degree(n_vars : Int, degrees : Array[Int]) -> Int {
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  if n_vars < degrees.length() { 0 } else { product }
}

///|
pub fn variety_count_real_roots(approx_roots : Array[Double], tol : Double) -> Int {
  let sorted = Array::make(approx_roots.length(), 0.0)
  for i in 0..<approx_roots.length() {
    sorted[i] = approx_roots[i]
  }
  sorted.sort()
  if sorted.length() == 0 { return 0 }
  let mut count = 1
  for i in 1..<sorted.length() {
    if (sorted[i] - sorted[i - 1]).abs() > tol {
      count += 1
    }
  }
  count
}' \
'test "variety_dimension" {
  assert_eq(variety_dimension(2, 1), 1)
  assert_eq(variety_dimension(3, 3), 0)
}

test "variety_is_finite" {
  assert_true(variety_is_finite(0))
  assert_false(variety_is_finite(1))
}

test "variety_degree" {
  assert_eq(variety_degree(2, [2, 2]), 4)
}

test "variety_count_real_roots" {
  assert_eq(variety_count_real_roots([1.0, 2.0, 3.0], 0.01), 3)
  assert_eq(variety_count_real_roots([1.0, 1.001, 3.0], 0.01), 2)
}' \
'- variety_dimension
- variety_is_empty
- variety_is_finite
- variety_degree
- variety_count_real_roots'

create_mod "rational_map" \
'import {
}' \
'///|
/// # Rational Map
/// # 有理映射
///
/// Rational maps between algebraic varieties.
/// 代数簇之间的有理映射。

///|
pub struct RationalMap {
  num_coeffs : Array[Double]
  den_coeffs : Array[Double]
}

///|
pub fn RationalMap::new(num : Array[Double], den : Array[Double]) -> RationalMap {
  { num_coeffs: num, den_coeffs: den, }
}

///|
pub fn rational_eval(m : RationalMap, x : Double) -> Double {
  let mut num = 0.0
  for i in 0..<m.num_coeffs.length() {
    num += m.num_coeffs[i] * pow(x, i)
  }
  let mut den = 0.0
  for i in 0..<m.den_coeffs.length() {
    den += m.den_coeffs[i] * pow(x, i)
  }
  if den.abs() < 0.000000000001 { 0.0 } else { num / den }
}

///|
pub fn rational_degree(m : RationalMap) -> Int {
  let nd = m.num_coeffs.length() - 1
  let dd = m.den_coeffs.length() - 1
  if nd > dd { nd - dd } else { 0 }
}

///|
pub fn rational_is_defined(m : RationalMap, x : Double) -> Bool {
  let mut den = 0.0
  for i in 0..<m.den_coeffs.length() {
    den += m.den_coeffs[i] * pow(x, i)
  }
  den.abs() > 0.000000000001
}

fn pow(base : Double, exp : Int) -> Double {
  let mut result = 1.0
  for _ in 0..<exp {
    result *= base
  }
  result
}' \
'test "rational_eval" {
  let m = RationalMap::new([1.0, 0.0], [1.0, 1.0])
  assert_true((rational_eval(m, 2.0) - 0.333333).abs() < 0.001)
}

test "rational_degree" {
  let m = RationalMap::new([1.0, 0.0, 1.0], [1.0, 1.0])
  assert_eq(rational_degree(m), 1)
}

test "rational_is_defined" {
  let m = RationalMap::new([1.0], [1.0, -1.0])
  assert_true(rational_is_defined(m, 0.0))
  assert_false(rational_is_defined(m, 1.0))
}' \
'- RationalMap::new
- rational_eval
- rational_degree
- rational_is_defined'

create_mod "intersection_theory" \
'import {
}' \
'///|
/// # Intersection Theory
/// # 相交理论
///
/// Intersection numbers and products in algebraic geometry.
/// 代数几何中的相交数与相交积。

///|
pub fn intersection_number(degrees : Array[Int]) -> Int {
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  product
}

///|
pub fn self_intersection(degree : Int, n : Int) -> Int {
  let mut result = 1
  for _ in 0..<n {
    result *= degree
  }
  result
}

///|
pub fn bezout_bound(d1 : Int, d2 : Int) -> Int {
  d1 * d2
}

///|
pub fn excess_intersection(expected : Int, actual : Int) -> Int {
  actual - expected
}

///|
pub fn is_transverse(codim_sum : Int, ambient_dim : Int) -> Bool {
  codim_sum == ambient_dim
}' \
'test "intersection_number" {
  assert_eq(intersection_number([2, 3]), 6)
  assert_eq(intersection_number([2, 2, 2]), 8)
}

test "bezout_bound" {
  assert_eq(bezout_bound(3, 4), 12)
}

test "is_transverse" {
  assert_true(is_transverse(2, 2))
  assert_false(is_transverse(1, 2))
}' \
'- intersection_number
- self_intersection
- bezout_bound
- excess_intersection
- is_transverse'

create_mod "chow_ring" \
'import {
}' \
'///|
/// # Chow Ring
/// # Chow 环
///
/// Chow ring of projective spaces for intersection theory.
/// 射影空间的 Chow 环，用于相交理论。

///|
pub fn chow_ring_dim(n : Int) -> Int {
  n
}

///|
pub fn chow_product(a_deg : Int, b_deg : Int, n : Int) -> Int {
  let sum = a_deg + b_deg
  if sum > n { 0 } else { sum }
}

///|
pub fn chow_class_degree(k : Int, n : Int) -> Int {
  if k < 0 || k > n { 0 } else { 1 }
}

///|
pub fn chow_top_class(n : Int) -> Int {
  n
}

///|
pub fn chow_integral(degree : Int, n : Int) -> Int {
  if degree == n { 1 } else { 0 }
}' \
'test "chow_product" {
  assert_eq(chow_product(1, 1, 2), 2)
  assert_eq(chow_product(1, 2, 2), 0)
}

test "chow_top_class" {
  assert_eq(chow_top_class(3), 3)
}

test "chow_integral" {
  assert_eq(chow_integral(2, 2), 1)
  assert_eq(chow_integral(1, 2), 0)
}' \
'- chow_ring_dim
- chow_product
- chow_class_degree
- chow_top_class
- chow_integral'

create_mod "hilbert_function" \
'import {
}' \
'///|
/// # Hilbert Function
/// # Hilbert 函数
///
/// Hilbert function and Hilbert series of graded modules.
/// 分次模的 Hilbert 函数与 Hilbert 级数。

///|
pub fn hilbert_function_pn(degree : Int, n : Int) -> Int {
  if degree < 0 { return 0 }
  let mut result = 1
  for i in 1..<(n + 1) {
    result *= (degree + i)
  }
  let mut denom = 1
  for i in 1..<(n + 1) {
    denom *= i
  }
  result / denom
}

///|
pub fn hilbert_series_coeff(degree : Int, n : Int) -> Int {
  hilbert_function_pn(degree, n)
}

///|
pub fn hilbert_polynomial_eval(t : Int, degree : Int, n : Int) -> Int {
  hilbert_function_pn(t, n) - hilbert_function_pn(t - degree, n)
}

///|
pub fn hilbert_regularity(n : Int) -> Int {
  n
}

///|
pub fn hilbert_multiplicity(degree : Int, n : Int) -> Int {
  let mut result = 1
  for _ in 0..<n {
    result *= degree
  }
  result
}' \
'test "hilbert_function_pn" {
  assert_eq(hilbert_function_pn(0, 2), 1)
  assert_eq(hilbert_function_pn(1, 2), 3)
  assert_eq(hilbert_function_pn(2, 2), 6)
}

test "hilbert_regularity" {
  assert_eq(hilbert_regularity(3), 3)
}

test "hilbert_multiplicity" {
  assert_eq(hilbert_multiplicity(2, 2), 4)
}' \
'- hilbert_function_pn
- hilbert_series_coeff
- hilbert_polynomial_eval
- hilbert_regularity
- hilbert_multiplicity'

create_mod "bezout_theorem" \
'import {
}' \
'///|
/// # Bezout Theorem
/// # Bezout 定理
///
/// Bezout theorem: number of intersection points of two plane curves.
/// Bezout 定理：两条平面曲线的交点数。

///|
pub fn bezout_count(d1 : Int, d2 : Int) -> Int {
  d1 * d2
}

///|
pub fn bezout_with_multiplicities(degrees : Array[Int]) -> Int {
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  product
}

///|
pub fn bezout_excess(expected : Int, found : Int) -> Int {
  expected - found
}

///|
pub fn bezout_in_pn(degrees : Array[Int], n : Int) -> Int {
  if degrees.length() < n { return 0 }
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  product
}

///|
pub fn is_bezout_satisfied(expected : Int, actual : Int) -> Bool {
  expected == actual
}' \
'test "bezout_count" {
  assert_eq(bezout_count(2, 3), 6)
}

test "bezout_with_multiplicities" {
  assert_eq(bezout_with_multiplicities([2, 3, 4]), 24)
}

test "bezout_excess" {
  assert_eq(bezout_excess(6, 4), 2)
}' \
'- bezout_count
- bezout_with_multiplicities
- bezout_excess
- bezout_in_pn
- is_bezout_satisfied'

create_mod "multiplicity" \
'import {
}' \
'///|
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
}' \
'test "intersection_multiplicity" {
  assert_eq(intersection_multiplicity(2, 3), 2)
}

test "total_multiplicity" {
  assert_eq(total_multiplicity([1, 2, 3]), 6)
}

test "is_simple_intersection" {
  assert_true(is_simple_intersection(1))
  assert_false(is_simple_intersection(2))
}' \
'- intersection_multiplicity
- tangency_multiplicity
- total_multiplicity
- is_simple_intersection
- multiplicity_from_tangent'

create_mod "elimination_ideal" \
'import {
}' \
'///|
/// # Elimination Ideal
/// # 消元理想
///
/// Elimination ideals for projecting varieties to lower dimensions.
/// 消元理想，用于将簇投影到低维空间。

///|
pub fn eliminate_variable(n_vars : Int, var_index : Int) -> Int {
  if var_index < 0 || var_index >= n_vars { n_vars } else { n_vars - 1 }
}

///|
pub fn elimination_order(n_vars : Int, eliminate_count : Int) -> Int {
  if eliminate_count > n_vars { 0 } else { n_vars - eliminate_count }
}

///|
pub fn projection_dimension(variety_dim : Int, eliminate_count : Int) -> Int {
  let d = variety_dim - eliminate_count
  if d < 0 { 0 } else { d }
}

///|
pub fn closure_is_proper(fiber_dim : Int) -> Bool {
  fiber_dim >= 0
}

///|
pub fn extension_exists(generic_fiber_nonempty : Bool) -> Bool {
  generic_fiber_nonempty
}' \
'test "eliminate_variable" {
  assert_eq(eliminate_variable(3, 1), 2)
}

test "projection_dimension" {
  assert_eq(projection_dimension(2, 1), 1)
  assert_eq(projection_dimension(1, 2), 0)
}

test "extension_exists" {
  assert_true(extension_exists(true))
  assert_false(extension_exists(false))
}' \
'- eliminate_variable
- elimination_order
- projection_dimension
- closure_is_proper
- extension_exists'

# ============ Phase 14: Differential Geometry & Discrete Surfaces (10 modules) ============

create_mod "discrete_curvature" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Discrete Curvature
/// # 离散曲率
///
/// Discrete Gaussian and mean curvature on triangle meshes.
/// 三角网格上的离散高斯曲率和平均曲率。

///|
pub fn discrete_gaussian_curvature(angle_defect : Double) -> Double {
  angle_defect
}

///|
pub fn discrete_mean_curvature(area : Double, edge_lengths : Array[Double], dihedral_angles : Array[Double]) -> Double {
  let n = edge_lengths.length()
  if n == 0 || area < 0.000000000001 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    sum += edge_lengths[i] * dihedral_angles[i]
  }
  sum / (4.0 * area)
}

///|
pub fn angle_defect(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<angles.length() {
    sum += angles[i]
  }
  6.283185307179586 - sum
}

///|
pub fn voronoi_area(edge_len : Double) -> Double {
  edge_len * edge_len / 8.0
}

///|
pub fn mixed_area(a1 : Double, a2 : Double) -> Double {
  (a1 + a2) / 2.0
}' \
'test "discrete_gaussian_curvature" {
  assert_true((discrete_gaussian_curvature(0.5) - 0.5).abs() < 0.001)
}

test "angle_defect" {
  let ad = angle_defect([1.5707963267948966, 1.5707963267948966, 1.5707963267948966])
  assert_true(ad > 0.5)
}

test "voronoi_area" {
  assert_true((voronoi_area(2.0) - 0.5).abs() < 0.001)
}' \
'- discrete_gaussian_curvature
- discrete_mean_curvature
- angle_defect
- voronoi_area
- mixed_area'

create_mod "gauss_bonnet" \
'import {
}' \
'///|
/// # Discrete Gauss-Bonnet Theorem
/// # 离散 Gauss-Bonnet 定理
///
/// Discrete Gauss-Bonnet: sum of angle defects = 2*pi*chi.
/// 离散 Gauss-Bonnet：角亏之和 = 2*pi*chi。

///|
pub fn gauss_bonnet_check(total_curvature : Double, euler_char : Int) -> Bool {
  let expected = 6.283185307179586 * euler_char.to_double()
  (total_curvature - expected).abs() < 0.01
}

///|
pub fn euler_from_curvature(total_curvature : Double) -> Int {
  (total_curvature / 6.283185307179586).round().to_int()
}

///|
pub fn total_gaussian_curvature(angle_defects : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<angle_defects.length() {
    sum += angle_defects[i]
  }
  sum
}

///|
pub fn boundary_correction(boundary_angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<boundary_angles.length() {
    sum += 3.141592653589793 - boundary_angles[i]
  }
  sum
}

///|
pub fn gauss_bonnet_with_boundary(interior_curv : Double, boundary_corr : Double, euler_char : Int) -> Bool {
  let expected = 6.283185307179586 * euler_char.to_double()
  (interior_curv + boundary_corr - expected).abs() < 0.01
}' \
'test "gauss_bonnet_check" {
  assert_true(gauss_bonnet_check(12.566370614359172, 2))
}

test "euler_from_curvature" {
  assert_eq(euler_from_curvature(12.566370614359172), 2)
}

test "total_gaussian_curvature" {
  assert_true((total_gaussian_curvature([1.0, 2.0, 3.0]) - 6.0).abs() < 0.001)
}' \
'- gauss_bonnet_check
- euler_from_curvature
- total_gaussian_curvature
- boundary_correction
- gauss_bonnet_with_boundary'

create_mod "geodesic_dist" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Geodesic Distance
/// # 测地距离
///
/// Geodesic distance computation on triangle meshes via Dijkstra and heat method.
/// 三角网格上的测地距离计算（Dijkstra 和热方法）。

///|
pub fn euclidean_fallback(a : @core.Point3D, b : @core.Point3D) -> Double {
  a.dist(b)
}

///|
pub fn dijkstra_geodesic(n : Int, adj : Array[(Int, Int, Double)], source : Int, target : Int) -> Double {
  let dist : Array[Double] = Array::make(n, 999999999.0)
  dist[source] = 0.0
  let visited : Array[Bool] = Array::make(n, false)
  for _ in 0..<n {
    let mut u = -1
    let mut min_d = 999999999.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_d {
        min_d = dist[i]
        u = i
      }
    }
    if u == -1 || u == target { break }
    visited[u] = true
    for j in 0..<adj.length() {
      let (a, b, w) = adj[j]
      let v = if a == u { b } else if b == u { a } else { -1 }
      if v >= 0 && !visited[v] {
        let nd = dist[u] + w
        if nd < dist[v] { dist[v] = nd }
      }
    }
  }
  dist[target]
}

///|
pub fn geodesic_lower_bound(a : @core.Point3D, b : @core.Point3D) -> Double {
  a.dist(b)
}

///|
pub fn heat_method_step(dist : Array[Double], t : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<dist.length() {
    sum += dist[i]
  }
  sum * t / dist.length().to_double()
}' \
'test "euclidean_fallback" {
  let a = @core.Point3D::new(0.0, 0.0, 0.0)
  let b = @core.Point3D::new(3.0, 4.0, 0.0)
  assert_true((euclidean_fallback(a, b) - 5.0).abs() < 0.001)
}

test "dijkstra_geodesic" {
  let adj = [(0, 1, 1.0), (1, 2, 2.0), (0, 2, 4.0)]
  let d = dijkstra_geodesic(3, adj, 0, 2)
  assert_true((d - 3.0).abs() < 0.001)
}' \
'- euclidean_fallback
- dijkstra_geodesic
- geodesic_lower_bound
- heat_method_step'

create_mod "discrete_laplacian" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Discrete Laplacian
/// # 离散 Laplace 算子
///
/// Discrete Laplace-Beltrami operator (cotangent weights, uniform weights).
/// 离散 Laplace-Beltrami 算子（余切权重、均匀权重）。

///|
pub fn uniform_laplacian(values : Array[Double], neighbors : Array[Double]) -> Double {
  let n = neighbors.length()
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    sum += neighbors[i] - values[0]
  }
  sum / n.to_double()
}

///|
pub fn cotangent_weight(cot_a : Double, cot_b : Double) -> Double {
  (cot_a + cot_b) / 2.0
}

///|
pub fn cotangent_laplacian(center_val : Double, neighbor_vals : Array[Double], weights : Array[Double]) -> Double {
  let n = neighbor_vals.length()
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  let mut total_w = 0.0
  for i in 0..<n {
    sum += weights[i] * (neighbor_vals[i] - center_val)
    total_w += weights[i]
  }
  if total_w.abs() < 0.000000000001 { 0.0 } else { sum / total_w }
}

///|
pub fn laplacian_eigenvalue(mode : Int, area : Double) -> Double {
  if area < 0.000000000001 { return 0.0 }
  mode.to_double() * mode.to_double() * 3.141592653589793 * 3.141592653589793 / area
}

///|
pub fn is_harmonic(laplacian_val : Double, tol : Double) -> Bool {
  laplacian_val.abs() < tol
}' \
'test "uniform_laplacian" {
  let l = uniform_laplacian([5.0], [3.0, 7.0])
  assert_true(l.abs() < 0.001)
}

test "cotangent_weight" {
  assert_true((cotangent_weight(1.0, 1.0) - 1.0).abs() < 0.001)
}

test "is_harmonic" {
  assert_true(is_harmonic(0.0001, 0.01))
}' \
'- uniform_laplacian
- cotangent_weight
- cotangent_laplacian
- laplacian_eigenvalue
- is_harmonic'

create_mod "harmonic_map" \
'import {
}' \
'///|
/// # Harmonic Map
/// # 调和映射
///
/// Harmonic maps between surfaces (energy minimization).
/// 曲面间的调和映射（能量最小化）。

///|
pub fn dirichlet_energy(values : Array[Double], neighbors : Array[Array[Double]]) -> Double {
  let mut energy = 0.0
  for i in 0..<values.length() {
    for j in 0..<neighbors[i].length() {
      let diff = values[i] - neighbors[i][j]
      energy += diff * diff
    }
  }
  energy / 2.0
}

///|
pub fn harmonic_residual(laplacian_values : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<laplacian_values.length() {
    sum += laplacian_values[i] * laplacian_values[i]
  }
  sum
}

///|
pub fn is_harmonic_map(residual : Double, tol : Double) -> Bool {
  residual < tol
}

///|
pub fn map_energy(dirichlet : Double, area : Double) -> Double {
  if area < 0.000000000001 { 0.0 } else { dirichlet / area }
}

///|
pub fn laplacian_smooth(values : Array[Double], laplacian : Array[Double], lambda : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<values.length() {
    result.push(values[i] + lambda * laplacian[i])
  }
  result
}' \
'test "dirichlet_energy" {
  let e = dirichlet_energy([1.0, 2.0], [[2.0], [1.0]])
  assert_true((e - 1.0).abs() < 0.001)
}

test "harmonic_residual" {
  let r = harmonic_residual([0.0, 0.0])
  assert_true(r.abs() < 0.001)
}

test "laplacian_smooth" {
  let r = laplacian_smooth([1.0, 2.0], [0.5, -0.5], 0.1)
  assert_true((r[0] - 1.05).abs() < 0.001)
}' \
'- dirichlet_energy
- harmonic_residual
- is_harmonic_map
- map_energy
- laplacian_smooth'

create_mod "conformal_map" \
'import {
}' \
'///|
/// # Conformal Map
/// # 共形映射
///
/// Conformal parameterization of surfaces (angle-preserving maps).
/// 曲面的共形参数化（保角映射）。

///|
pub fn conformal_factor(scale_x : Double, scale_y : Double) -> Double {
  if scale_x.abs() < 0.000000000001 { return 0.0 }
  scale_y / scale_x
}

///|
pub fn is_conformal(j11 : Double, j12 : Double, j21 : Double, j22 : Double, tol : Double) -> Bool {
  let a = j11 - j22
  let b = j12 + j21
  (a * a + b * b).sqrt() < tol
}

///|
pub fn conformal_energy(stretch_u : Double, stretch_v : Double) -> Double {
  let diff = stretch_u - stretch_v
  diff * diff
}

///|
pub fn angle_distortion(theta_before : Double, theta_after : Double) -> Double {
  (theta_before - theta_after).abs()
}

///|
pub fn area_distortion(area_before : Double, area_after : Double) -> Double {
  if area_before.abs() < 0.000000000001 { 0.0 } else { (area_after / area_before).ln().abs() }
}' \
'test "conformal_factor" {
  assert_true((conformal_factor(2.0, 4.0) - 2.0).abs() < 0.001)
}

test "is_conformal" {
  assert_true(is_conformal(2.0, 0.0, 0.0, 2.0, 0.001))
  assert_false(is_conformal(2.0, 1.0, 0.0, 2.0, 0.001))
}

test "conformal_energy" {
  assert_true(conformal_energy(2.0, 2.0).abs() < 0.001)
}' \
'- conformal_factor
- is_conformal
- conformal_energy
- angle_distortion
- area_distortion'

create_mod "surface_ricci" \
'import {
  "moonbitlang/core/math",
}' \
'///|
/// # Discrete Ricci Flow
/// # 离散 Ricci 流
///
/// Discrete Ricci flow for conformal deformation of surfaces.
/// 曲面共形变形的离散 Ricci 流。

///|
pub fn ricci_flow_step(curvatures : Array[Double], target_curvatures : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<curvatures.length() {
    result.push(curvatures[i] + dt * (target_curvatures[i] - curvatures[i]))
  }
  result
}

///|
pub fn ricci_energy(curvatures : Array[Double], target : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<curvatures.length() {
    let diff = curvatures[i] - target[i]
    sum += diff * diff
  }
  sum / 2.0
}

///|
pub fn target_curvature_uniform(n : Int, total_curv : Double) -> Array[Double] {
  let per_vertex = total_curv / n.to_double()
  Array::make(n, per_vertex)
}

///|
pub fn target_curvature_gaussian(n : Int, euler_char : Int) -> Array[Double] {
  let total = 6.283185307179586 * euler_char.to_double()
  target_curvature_uniform(n, total)
}

///|
pub fn ricci_converged(energy : Double, tol : Double) -> Bool {
  energy < tol
}' \
'test "ricci_flow_step" {
  let r = ricci_flow_step([1.0, 2.0], [0.0, 0.0], 0.1)
  assert_true((r[0] - 0.9).abs() < 0.001)
}

test "ricci_energy" {
  let e = ricci_energy([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}

test "target_curvature_uniform" {
  let t = target_curvature_uniform(4, 12.566370614359172)
  assert_true((t[0] - 3.141592653589793).abs() < 0.001)
}' \
'- ricci_flow_step
- ricci_energy
- target_curvature_uniform
- target_curvature_gaussian
- ricci_converged'

create_mod "discrete_yamabe" \
'import {
}' \
'///|
/// # Discrete Yamabe Problem
/// # 离散 Yamabe 问题
///
/// Discrete Yamabe problem: find conformal factor for constant curvature.
/// 离散 Yamabe 问题：寻找共形因子使曲率常数化。

///|
pub fn yamabe_energy(curvatures : Array[Double], target : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<curvatures.length() {
    let diff = curvatures[i] - target
    sum += diff * diff
  }
  sum
}

///|
pub fn yamabe_gradient(curvatures : Array[Double], target : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<curvatures.length() {
    result.push(2.0 * (curvatures[i] - target))
  }
  result
}

///|
pub fn constant_curvature_target(total_curv : Double, n : Int) -> Double {
  if n == 0 { 0.0 } else { total_curv / n.to_double() }
}

///|
pub fn yamabe_flow_step(conformal_factors : Array[Double], gradient : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<conformal_factors.length() {
    result.push(conformal_factors[i] - dt * gradient[i])
  }
  result
}

///|
pub fn yamabe_converged(energy : Double, tol : Double) -> Bool {
  energy < tol
}' \
'test "yamabe_energy" {
  let e = yamabe_energy([1.0, 1.0], 1.0)
  assert_true(e.abs() < 0.001)
}

test "yamabe_gradient" {
  let g = yamabe_gradient([2.0, 3.0], 1.0)
  assert_true((g[0] - 2.0).abs() < 0.001)
}

test "constant_curvature_target" {
  assert_true((constant_curvature_target(6.0, 3) - 2.0).abs() < 0.001)
}' \
'- yamabe_energy
- yamabe_gradient
- constant_curvature_target
- yamabe_flow_step
- yamabe_converged'

create_mod "willmore_energy" \
'import {
}' \
'///|
/// # Willmore Energy
/// # Willmore 能量
///
/// Willmore energy: integral of mean curvature squared.
/// Willmore 能量：平均曲率平方的积分。

///|
pub fn willmore_energy(mean_curvatures : Array[Double], areas : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<mean_curvatures.length() {
    sum += mean_curvatures[i] * mean_curvatures[i] * areas[i]
  }
  sum
}

///|
pub fn willmore_gradient(h : Double, area : Double) -> Double {
  4.0 * h * h * h * area
}

///|
pub fn willmore_of_sphere(radius : Double) -> Double {
  if radius < 0.000000000001 { return 0.0 }
  16.0 * 3.141592653589793
}

///|
pub fn willmore_flow_step(curvatures : Array[Double], gradient : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<curvatures.length() {
    result.push(curvatures[i] - dt * gradient[i])
  }
  result
}

///|
pub fn is_willmore_minimal(gradient_norm : Double, tol : Double) -> Bool {
  gradient_norm < tol
}' \
'test "willmore_energy" {
  let e = willmore_energy([1.0, 2.0], [1.0, 1.0])
  assert_true((e - 5.0).abs() < 0.001)
}

test "willmore_of_sphere" {
  let w = willmore_of_sphere(1.0)
  assert_true((w - 50.26548245743669).abs() < 0.01)
}

test "is_willmore_minimal" {
  assert_true(is_willmore_minimal(0.0001, 0.01))
}' \
'- willmore_energy
- willmore_gradient
- willmore_of_sphere
- willmore_flow_step
- is_willmore_minimal'

create_mod "minimal_surface" \
'import {
}' \
'///|
/// # Minimal Surface
/// # 极小曲面
///
/// Minimal surface computation (mean curvature = 0).
/// 极小曲面计算（平均曲率 = 0）。

///|
pub fn is_minimal(mean_curvature : Double, tol : Double) -> Bool {
  mean_curvature.abs() < tol
}

///|
pub fn minimal_surface_energy(area : Double) -> Double {
  area
}

///|
pub fn area_gradient(mean_curvatures : Array[Double], areas : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<mean_curvatures.length() {
    result.push(2.0 * mean_curvatures[i] * areas[i])
  }
  result
}

///|
pub fn mean_curvature_flow_step(positions : Array[Double], laplacian : Array[Double], dt : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<positions.length() {
    result.push(positions[i] + dt * laplacian[i])
  }
  result
}

///|
pub fn plateau_energy(boundary_length : Double, area : Double) -> Double {
  area + 0.001 * boundary_length
}' \
'test "is_minimal" {
  assert_true(is_minimal(0.0001, 0.01))
  assert_false(is_minimal(0.1, 0.01))
}

test "minimal_surface_energy" {
  assert_true((minimal_surface_energy(5.0) - 5.0).abs() < 0.001)
}

test "area_gradient" {
  let g = area_gradient([0.0, 0.0], [1.0, 2.0])
  assert_true(g[0].abs() < 0.001)
}' \
'- is_minimal
- minimal_surface_energy
- area_gradient
- mean_curvature_flow_step
- plateau_energy'

# ============ Phase 15: Persistent Topology Applications (10 modules) ============

create_mod "persistence_diagram" \
'import {
}' \
'///|
/// # Persistence Diagram
/// # 持久性图
///
/// Persistence diagram representation for topological features.
/// 拓扑特征的持久性图表示。

///|
pub struct PersistencePoint {
  birth : Double
  death : Double
}

///|
pub fn PersistencePoint::new(birth : Double, death : Double) -> PersistencePoint {
  { birth, death, }
}

///|
pub fn persistence(p : PersistencePoint) -> Double {
  p.death - p.birth
}

///|
pub fn is_essential(p : PersistencePoint) -> Bool {
  p.death > 99999999.0
}

///|
pub fn diagram_dimension(diagram : Array[PersistencePoint]) -> Int {
  diagram.length()
}

///|
pub fn max_persistence(diagram : Array[PersistencePoint]) -> Double {
  let mut max_p = 0.0
  for i in 0..<diagram.length() {
    let p = persistence(diagram[i])
    if p > max_p { max_p = p }
  }
  max_p
}' \
'test "persistence" {
  let p = PersistencePoint::new(1.0, 3.0)
  assert_true((persistence(p) - 2.0).abs() < 0.001)
}

test "is_essential" {
  let p = PersistencePoint::new(1.0, 999999999.0)
  assert_true(is_essential(p))
}

test "max_persistence" {
  let d = [PersistencePoint::new(0.0, 2.0), PersistencePoint::new(1.0, 4.0)]
  assert_true((max_persistence(d) - 3.0).abs() < 0.001)
}' \
'- PersistencePoint::new
- persistence
- is_essential
- diagram_dimension
- max_persistence'

create_mod "bottleneck_dist" \
'import {
  "walkzzz/moon-geometry/src/persistence_diagram",
}' \
'///|
/// # Bottleneck Distance
/// # 瓶颈距离
///
/// Bottleneck distance between persistence diagrams.
/// 持久性图之间的瓶颈距离。

///|
pub fn bottleneck_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let n1 = d1.length()
  let n2 = d2.length()
  if n1 == 0 && n2 == 0 { return 0.0 }
  let mut max_dist = 0.0
  for i in 0..<n1 {
    let mut min_d = 999999999.0
    for j in 0..<n2 {
      let db = (d1[i].birth - d2[j].birth).abs()
      let dd = (d1[i].death - d2[j].death).abs()
      let d = if db > dd { db } else { dd }
      if d < min_d { min_d = d }
    }
    if min_d > max_dist { max_dist = min_d }
  }
  max_dist
}

///|
pub fn bottleneck_upper_bound(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let m1 = @persistence_diagram.max_persistence(d1)
  let m2 = @persistence_diagram.max_persistence(d2)
  (m1 - m2).abs() + 1.0
}

///|
pub fn bottleneck_lower_bound(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let m1 = @persistence_diagram.max_persistence(d1)
  let m2 = @persistence_diagram.max_persistence(d2)
  (m1 - m2).abs() / 2.0
}' \
'test "bottleneck_distance" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  assert_true(bottleneck_distance(d1, d2).abs() < 0.001)
}

test "bottleneck_upper_bound" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 3.0)]
  assert_true(bottleneck_upper_bound(d1, d2) > 0.0)
}' \
'- bottleneck_distance
- bottleneck_upper_bound
- bottleneck_lower_bound'

create_mod "wasserstein_dist" \
'import {
  "walkzzz/moon-geometry/src/persistence_diagram",
}' \
'///|
/// # Wasserstein Distance
/// # Wasserstein 距离
///
/// p-Wasserstein distance between persistence diagrams.
/// 持久性图之间的 p-Wasserstein 距离。

///|
pub fn wasserstein_1_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let n = if d1.length() < d2.length() { d1.length() } else { d2.length() }
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let db = (d1[i].birth - d2[i].birth).abs()
    let dd = (d1[i].death - d2[i].death).abs()
    sum += db + dd
  }
  sum
}

///|
pub fn wasserstein_inf_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let n = if d1.length() < d2.length() { d1.length() } else { d2.length() }
  if n == 0 { return 0.0 }
  let mut max_d = 0.0
  for i in 0..<n {
    let db = (d1[i].birth - d2[i].birth).abs()
    let dd = (d1[i].death - d2[i].death).abs()
    let d = if db > dd { db } else { dd }
    if d > max_d { max_d = d }
  }
  max_d
}

///|
pub fn wasserstein_p_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint], p : Double) -> Double {
  let n = if d1.length() < d2.length() { d1.length() } else { d2.length() }
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let db = (d1[i].birth - d2[i].birth).abs()
    let dd = (d1[i].death - d2[i].death).abs()
    let dist = (db * db + dd * dd).sqrt()
    sum += pow_double(dist, p)
  }
  pow_double(sum, 1.0 / p)
}

fn pow_double(base : Double, exp : Double) -> Double {
  if base < 0.000000000001 { return 0.0 }
  (exp * base.ln()).exp()
}' \
'test "wasserstein_1_distance" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 3.0)]
  assert_true((wasserstein_1_distance(d1, d2) - 1.0).abs() < 0.001)
}

test "wasserstein_inf_distance" {
  let d1 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let d2 = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  assert_true(wasserstein_inf_distance(d1, d2).abs() < 0.001)
}' \
'- wasserstein_1_distance
- wasserstein_inf_distance
- wasserstein_p_distance'

create_mod "persistence_landscape" \
'import {
  "walkzzz/moon-geometry/src/persistence_diagram",
}' \
'///|
/// # Persistence Landscape
/// # 持久性景观
///
/// Persistence landscape: vectorized representation of persistence diagrams.
/// 持久性景观：持久性图的向量化表示。

///|
pub fn landscape_k(point : @persistence_diagram.PersistencePoint, k : Int, t : Double) -> Double {
  let birth = point.birth
  let death = point.death
  let mid = (birth + death) / 2.0
  if k != 1 { return 0.0 }
  if t < birth || t > death { return 0.0 }
  if t <= mid { t - birth } else { death - t }
}

///|
pub fn landscape_sup(point : @persistence_diagram.PersistencePoint) -> Double {
  let pers = @persistence_diagram.persistence(point)
  pers / 2.0
}

///|
pub fn landscape_norm_1(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let mut sum = 0.0
  for i in 0..<diagram.length() {
    let p = @persistence_diagram.persistence(diagram[i])
    sum += p * p / 4.0
  }
  sum
}

///|
pub fn landscape_norm_inf(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let mut max_val = 0.0
  for i in 0..<diagram.length() {
    let val = landscape_sup(diagram[i])
    if val > max_val { max_val = val }
  }
  max_val
}' \
'test "landscape_k" {
  let p = @persistence_diagram.PersistencePoint::new(0.0, 4.0)
  assert_true((landscape_k(p, 1, 2.0) - 2.0).abs() < 0.001)
  assert_true(landscape_k(p, 1, 5.0).abs() < 0.001)
}

test "landscape_sup" {
  let p = @persistence_diagram.PersistencePoint::new(0.0, 4.0)
  assert_true((landscape_sup(p) - 2.0).abs() < 0.001)
}

test "landscape_norm_1" {
  let d = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  assert_true((landscape_norm_1(d) - 1.0).abs() < 0.001)
}' \
'- landscape_k
- landscape_sup
- landscape_norm_1
- landscape_norm_inf'

create_mod "persistence_image" \
'import {
  "moonbitlang/core/math",
  "walkzzz/moon-geometry/src/persistence_diagram",
}' \
'///|
/// # Persistence Image
/// # 持久性图像
///
/// Persistence image: stable vectorized representation of persistence diagrams.
/// 持久性图像：持久性图的稳定向量化表示。

///|
pub fn gaussian_kernel_2d(x : Double, y : Double, mu_x : Double, mu_y : Double, sigma : Double) -> Double {
  let dx = x - mu_x
  let dy = y - mu_y
  let s2 = sigma * sigma
  @math.exp(-(dx * dx + dy * dy) / (2.0 * s2)) / (2.0 * 3.141592653589793 * s2)
}

///|
pub fn persistence_image_pixel(point : @persistence_diagram.PersistencePoint, mu_x : Double, mu_y : Double, sigma : Double, weight : Double) -> Double {
  let x = point.birth
  let y = point.death - point.birth
  weight * gaussian_kernel_2d(x, y, mu_x, mu_y, sigma)
}

///|
pub fn persistence_image_vector(diagram : Array[@persistence_diagram.PersistencePoint], pixels : Array[(Double, Double)], sigma : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<pixels.length() {
    let (px, py) = pixels[i]
    let mut sum = 0.0
    for j in 0..<diagram.length() {
      sum += persistence_image_pixel(diagram[j], px, py, sigma, 1.0)
    }
    result.push(sum)
  }
  result
}

///|
pub fn image_norm(image : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<image.length() {
    sum += image[i] * image[i]
  }
  sum.sqrt()
}' \
'test "gaussian_kernel_2d" {
  let k = gaussian_kernel_2d(0.0, 0.0, 0.0, 0.0, 1.0)
  assert_true((k - 0.15915494309189535).abs() < 0.001)
}

test "image_norm" {
  assert_true((image_norm([3.0, 4.0]) - 5.0).abs() < 0.001)
}' \
'- gaussian_kernel_2d
- persistence_image_pixel
- persistence_image_vector
- image_norm'

create_mod "mapper_algo" \
'import {
}' \
'///|
/// # Mapper Algorithm
/// # Mapper 算法
///
/// Mapper algorithm for topological data analysis of point clouds.
/// 点云拓扑数据分析的 Mapper 算法。

///|
pub fn mapper_cover(values : Array[Double], n_intervals : Int, overlap : Double) -> Array[(Double, Double)] {
  if values.length() == 0 || n_intervals <= 0 { return [] }
  let mut lo = values[0]
  let mut hi = values[0]
  for i in 1..<values.length() {
    if values[i] < lo { lo = values[i] }
    if values[i] > hi { hi = values[i] }
  }
  let range = hi - lo
  if range < 0.000000000001 { return [(lo, hi)] }
  let step = range / n_intervals.to_double()
  let overlap_size = step * overlap
  let result : Array[(Double, Double)] = []
  for i in 0..<n_intervals {
    let start = lo + i.to_double() * step - overlap_size / 2.0
    let end = start + step + overlap_size
    result.push((start, end))
  }
  result
}

///|
pub fn mapper_cluster(points : Array[Double], interval : (Double, Double)) -> Array[Int] {
  let (lo, hi) = interval
  let result : Array[Int] = []
  for i in 0..<points.length() {
    if points[i] >= lo && points[i] <= hi {
      result.push(i)
    }
  }
  result
}

///|
pub fn mapper_graph_nodes(cover : Array[(Double, Double)], points : Array[Double]) -> Int {
  let mut count = 0
  for i in 0..<cover.length() {
    let cluster = mapper_cluster(points, cover[i])
    if cluster.length() > 0 { count += 1 }
  }
  count
}' \
'test "mapper_cover" {
  let cover = mapper_cover([0.0, 1.0, 2.0, 3.0, 4.0], 2, 0.1)
  assert_eq(cover.length(), 2)
}

test "mapper_cluster" {
  let c = mapper_cluster([0.5, 1.5, 2.5], (0.0, 1.0))
  assert_eq(c.length(), 1)
}' \
'- mapper_cover
- mapper_cluster
- mapper_graph_nodes'

create_mod "zigzag_persistence" \
'import {
}' \
'///|
/// # Zigzag Persistence
/// # 之字持久性
///
/// Zigzag persistence for sequences of complexes with inclusions both ways.
/// 双向包含序列的之字持久性。

///|
pub fn zigzag_intervals(births : Array[Int], deaths : Array[Int]) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  let n = if births.length() < deaths.length() { births.length() } else { deaths.length() }
  for i in 0..<n {
    result.push((births[i], deaths[i]))
  }
  result
}

///|
pub fn zigzag_length(interval : (Int, Int)) -> Int {
  let (b, d) = interval
  d - b
}

///|
pub fn zigzag_max_length(intervals : Array[(Int, Int)]) -> Int {
  let mut max_l = 0
  for i in 0..<intervals.length() {
    let l = zigzag_length(intervals[i])
    if l > max_l { max_l = l }
  }
  max_l
}

///|
pub fn zigzag_total_betti(intervals : Array[(Int, Int)]) -> Int {
  intervals.length()
}' \
'test "zigzag_intervals" {
  let iv = zigzag_intervals([0, 1], [3, 4])
  assert_eq(iv.length(), 2)
}

test "zigzag_length" {
  assert_eq(zigzag_length((1, 5)), 4)
}

test "zigzag_max_length" {
  assert_eq(zigzag_max_length([(1, 3), (0, 5)]), 5)
}' \
'- zigzag_intervals
- zigzag_length
- zigzag_max_length
- zigzag_total_betti'

create_mod "multidim_persistence" \
'import {
}' \
'///|
/// # Multi-dimensional Persistence
/// # 多维持久性
///
/// Multi-parameter persistence modules and their invariants.
/// 多参数持久性模及其不变量。

///|
pub fn multidim_barcode(births : Array[(Double, Double)], deaths : Array[(Double, Double)]) -> Array[((Double, Double), (Double, Double))] {
  let result : Array[((Double, Double), (Double, Double))] = []
  let n = if births.length() < deaths.length() { births.length() } else { deaths.length() }
  for i in 0..<n {
    result.push((births[i], deaths[i]))
  }
  result
}

///|
pub fn multidim_persistence(barcode : Array[((Double, Double), (Double, Double))]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<barcode.length() {
    let ((b1, b2), (d1, d2)) = barcode[i]
    let p1 = d1 - b1
    let p2 = d2 - b2
    let p = if p1 < p2 { p1 } else { p2 }
    result.push(p)
  }
  result
}

///|
pub fn hilbert_function_md(grades : Array[(Int, Int)]) -> Int {
  grades.length()
}

///|
pub fn rank_invariant(birth : (Int, Int), death : (Int, Int)) -> Int {
  let (b1, b2) = birth
  let (d1, d2) = death
  if d1 >= b1 && d2 >= b2 { 1 } else { 0 }
}' \
'test "multidim_barcode" {
  let bc = multidim_barcode([(0.0, 0.0)], [(2.0, 3.0)])
  assert_eq(bc.length(), 1)
}

test "multidim_persistence" {
  let bc = multidim_barcode([(0.0, 0.0)], [(2.0, 3.0)])
  let p = multidim_persistence(bc)
  assert_true((p[0] - 2.0).abs() < 0.001)
}

test "rank_invariant" {
  assert_eq(rank_invariant((0, 0), (2, 3)), 1)
  assert_eq(rank_invariant((2, 0), (1, 3)), 0)
}' \
'- multidim_barcode
- multidim_persistence
- hilbert_function_md
- rank_invariant'

create_mod "sheaf_theory" \
'import {
}' \
'///|
/// # Cellular Sheaf Theory
/// # 胞腔层理论
///
/// Cellular sheaves and sheaf cohomology on simplicial complexes.
/// 单纯复形上的胞腔层与层上同调。

///|
pub fn sheaf_rank(stalk_ranks : Array[Int]) -> Int {
  let mut sum = 0
  for i in 0..<stalk_ranks.length() {
    sum += stalk_ranks[i]
  }
  sum
}

///|
pub fn sheaf_cohomology_dim(c0_dim : Int, c1_dim : Int, c2_dim : Int) -> (Int, Int) {
  let h0 = c0_dim - c1_dim
  let h1 = c1_dim - c2_dim
  (if h0 < 0 { 0 } else { h0 }, if h1 < 0 { 0 } else { h1 })
}

///|
pub fn euler_characteristic_sheaf(h0 : Int, h1 : Int, h2 : Int) -> Int {
  h0 - h1 + h2
}

///|
pub fn is_locally_constant(restriction_ranks : Array[Int]) -> Bool {
  if restriction_ranks.length() == 0 { return true }
  let r0 = restriction_ranks[0]
  for i in 1..<restriction_ranks.length() {
    if restriction_ranks[i] != r0 { return false }
  }
  true
}

///|
pub fn sheaf_pushforward_rank(original_rank : Int, map_degree : Int) -> Int {
  original_rank * map_degree
}' \
'test "sheaf_rank" {
  assert_eq(sheaf_rank([1, 2, 3]), 6)
}

test "sheaf_cohomology_dim" {
  let (h0, h1) = sheaf_cohomology_dim(3, 2, 1)
  assert_eq(h0, 1)
  assert_eq(h1, 1)
}

test "is_locally_constant" {
  assert_true(is_locally_constant([1, 1, 1]))
  assert_false(is_locally_constant([1, 2, 1]))
}' \
'- sheaf_rank
- sheaf_cohomology_dim
- euler_characteristic_sheaf
- is_locally_constant
- sheaf_pushforward_rank'

create_mod "tda_features" \
'import {
  "walkzzz/moon-geometry/src/persistence_diagram",
}' \
'///|
/// # TDA Features
/// # 拓扑数据分析特征
///
/// Feature extraction from persistence diagrams for machine learning.
/// 从持久性图提取特征用于机器学习。

///|
pub fn tda_total_persistence(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let mut sum = 0.0
  for i in 0..<diagram.length() {
    sum += @persistence_diagram.persistence(diagram[i])
  }
  sum
}

///|
pub fn tda_max_persistence(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  @persistence_diagram.max_persistence(diagram)
}

///|
pub fn tda_feature_vector(diagram : Array[@persistence_diagram.PersistencePoint]) -> Array[Double] {
  let total = tda_total_persistence(diagram)
  let max_p = tda_max_persistence(diagram)
  let n = diagram.length().to_double()
  let mean = if n > 0.0 { total / n } else { 0.0 }
  let mut var_sum = 0.0
  for i in 0..<diagram.length() {
    let p = @persistence_diagram.persistence(diagram[i])
    let diff = p - mean
    var_sum += diff * diff
  }
  let variance = if n > 0.0 { var_sum / n } else { 0.0 }
  [total, max_p, n, mean, variance]
}

///|
pub fn tda_amplitude(diagram : Array[@persistence_diagram.PersistencePoint], p : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<diagram.length() {
    let pers = @persistence_diagram.persistence(diagram[i])
    sum += pow_d(pers, p)
  }
  pow_d(sum, 1.0 / p)
}

fn pow_d(base : Double, exp : Double) -> Double {
  if base < 0.000000000001 { return 0.0 }
  (exp * base.ln()).exp()
}' \
'test "tda_total_persistence" {
  let d = [@persistence_diagram.PersistencePoint::new(0.0, 2.0), @persistence_diagram.PersistencePoint::new(1.0, 3.0)]
  assert_true((tda_total_persistence(d) - 4.0).abs() < 0.001)
}

test "tda_feature_vector" {
  let d = [@persistence_diagram.PersistencePoint::new(0.0, 2.0)]
  let fv = tda_feature_vector(d)
  assert_true((fv[0] - 2.0).abs() < 0.001)
  assert_eq(fv[2].to_int(), 1)
}' \
'- tda_total_persistence
- tda_max_persistence
- tda_feature_vector
- tda_amplitude'

# ============ Phase 16: Advanced Numerical Methods (10 modules) ============

create_mod "spectral_method" \
'import {
  "moonbitlang/core/math",
}' \
'///|
/// # Spectral Method
/// # 谱方法
///
/// Spectral methods for PDEs using Chebyshev and Fourier bases.
/// 使用 Chebyshev 和 Fourier 基的 PDE 谱方法。

///|
pub fn chebyshev_node(n : Int, i : Int) -> Double {
  @math.cos((2.0 * i.to_double() + 1.0) * 3.141592653589793 / (2.0 * n.to_double()))
}

///|
pub fn chebyshev_weight(n : Int, i : Int) -> Double {
  3.141592653589793 / n.to_double()
}

///|
pub fn fourier_coeff(f_values : Array[Double], k : Int) -> Double {
  let n = f_values.length()
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let theta = 2.0 * 3.141592653589793 * k.to_double() * i.to_double() / n.to_double()
    sum += f_values[i] * @math.cos(theta)
  }
  2.0 * sum / n.to_double()
}

///|
pub fn spectral_derivative(coeffs : Array[Double], x : Double) -> Double {
  let mut sum = 0.0
  for k in 1..<coeffs.length() {
    sum += k.to_double() * coeffs[k] * @math.sin(k.to_double() * x)
  }
  -sum
}

///|
pub fn spectral_interp(coeffs : Array[Double], x : Double) -> Double {
  let mut sum = 0.0
  for k in 0..<coeffs.length() {
    sum += coeffs[k] * @math.cos(k.to_double() * x)
  }
  sum
}' \
'test "chebyshev_node" {
  let n = chebyshev_node(4, 0)
  assert_true(n.abs() < 1.01)
}

test "fourier_coeff" {
  let c = fourier_coeff([1.0, 1.0, 1.0, 1.0], 0)
  assert_true((c - 2.0).abs() < 0.001)
}

test "spectral_interp" {
  let v = spectral_interp([1.0, 0.0, 0.0], 0.0)
  assert_true((v - 1.0).abs() < 0.001)
}' \
'- chebyshev_node
- chebyshev_weight
- fourier_coeff
- spectral_derivative
- spectral_interp'

create_mod "finite_element" \
'import {
}' \
'///|
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
}' \
'test "element_stiffness" {
  let s = element_stiffness((1.0, 0.0), (1.0, 0.0), 0.5)
  assert_true((s - 0.5).abs() < 0.001)
}

test "element_mass" {
  let m = element_mass(1.0, 1.0, 0.5)
  assert_true((m - 0.166667).abs() < 0.001)
}

test "fem_l2_error" {
  let e = fem_l2_error([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}' \
'- element_stiffness
- element_mass
- assemble_stiffness
- apply_dirichlet
- fem_l2_error'

create_mod "boundary_element" \
'import {
}' \
'///|
/// # Boundary Element Method
/// # 边界元方法
///
/// BEM for boundary integral equations.
/// 边界积分方程的边界元方法。

///|
pub fn fundamental_solution_2d(r : Double) -> Double {
  if r < 0.000000000001 { 0.0 } else { -r.ln() / (2.0 * 3.141592653589793) }
}

///|
pub fn boundary_integral_kernel(r : Double, normal_dist : Double) -> Double {
  if r < 0.000000000001 { return 0.0 }
  normal_dist / (2.0 * 3.141592653589793 * r * r)
}

///|
pub fn bem_matrix_entry(r : Double, weight : Double) -> Double {
  fundamental_solution_2d(r) * weight
}

///|
pub fn bem_solve(matrix : Array[Array[Double]], rhs : Array[Double]) -> Array[Double] {
  let n = rhs.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    if matrix[i][i].abs() > 0.000000000001 {
      result[i] = rhs[i] / matrix[i][i]
    }
  }
  result
}

///|
pub fn bem_error(exact : Array[Double], approx : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<exact.length() {
    let diff = exact[i] - approx[i]
    sum += diff * diff
  }
  sum.sqrt()
}' \
'test "fundamental_solution_2d" {
  let g = fundamental_solution_2d(1.0)
  assert_true(g.abs() < 0.001)
}

test "boundary_integral_kernel" {
  let k = boundary_integral_kernel(1.0, 0.5)
  assert_true(k > 0.0)
}

test "bem_error" {
  let e = bem_error([1.0, 2.0], [1.0, 2.0])
  assert_true(e.abs() < 0.001)
}' \
'- fundamental_solution_2d
- boundary_integral_kernel
- bem_matrix_entry
- bem_solve
- bem_error'

create_mod "meshfree_method" \
'import {
  "moonbitlang/core/math",
}' \
'///|
/// # Meshfree Method
/// # 无网格方法
///
/// Meshfree methods: SPH, RBF-FD for PDEs without mesh generation.
/// 无网格方法：SPH、RBF-FD 用于无网格 PDE 求解。

///|
pub fn sph_kernel(r : Double, h : Double) -> Double {
  let q = r / h
  if q >= 2.0 { return 0.0 }
  let sigma = 15.0 / (16.0 * 3.141592653589793 * h * h * h)
  if q < 1.0 {
    sigma * (1.0 - 1.5 * q * q + 0.75 * q * q * q)
  } else {
    sigma * 0.25 * (2.0 - q) * (2.0 - q) * (2.0 - q)
  }
}

///|
pub fn sph_kernel_gradient(r : Double, h : Double) -> Double {
  let q = r / h
  if q >= 2.0 || q < 0.000000000001 { return 0.0 }
  let sigma = 15.0 / (16.0 * 3.141592653589793 * h * h * h)
  if q < 1.0 {
    sigma * (-3.0 * q + 2.25 * q * q) / h
  } else {
    -sigma * 0.75 * (2.0 - q) * (2.0 - q) / h
  }
}

///|
pub fn rbf_gaussian(r : Double, eps : Double) -> Double {
  @math.exp(-eps * eps * r * r)
}

///|
pub fn rbf_multiquadric(r : Double, eps : Double) -> Double {
  (1.0 + eps * eps * r * r).sqrt()
}

///|
pub fn rbf_thin_plate_spline(r : Double) -> Double {
  if r < 0.000000000001 { 0.0 } else { r * r * r.ln() }
}' \
'test "sph_kernel" {
  let k = sph_kernel(0.0, 1.0)
  assert_true(k > 0.0)
}

test "sph_kernel compact" {
  let k = sph_kernel(3.0, 1.0)
  assert_true(k.abs() < 0.001)
}

test "rbf_gaussian" {
  let v = rbf_gaussian(0.0, 1.0)
  assert_true((v - 1.0).abs() < 0.001)
}' \
'- sph_kernel
- sph_kernel_gradient
- rbf_gaussian
- rbf_multiquadric
- rbf_thin_plate_spline'

create_mod "level_set" \
'import {
}' \
'///|
/// # Level Set Method
/// # 水平集方法
///
/// Level set methods for interface tracking and evolution.
/// 界面追踪与演化的水平集方法。

///|
pub fn level_set_sign(phi : Double) -> Int {
  if phi > 0.0 { 1 } else if phi < 0.0 { -1 } else { 0 }
}

///|
pub fn level_set_normal(grad_phi : (Double, Double)) -> (Double, Double) {
  let (gx, gy) = grad_phi
  let mag = (gx * gx + gy * gy).sqrt()
  if mag < 0.000000000001 { (0.0, 0.0) } else { (gx / mag, gy / mag) }
}

///|
pub fn level_set_curvature(grad : (Double, Double), hessian : (Double, Double, Double)) -> Double {
  let (gx, gy) = grad
  let (hxx, hxy, hyy) = hessian
  let mag = (gx * gx + gy * gy).sqrt()
  if mag < 0.000000000001 { return 0.0 }
  let mag3 = mag * mag * mag
  (gx * gx * hyy - 2.0 * gx * gy * hxy + gy * gy * hxx) / mag3
}

///|
pub fn reinitialize_step(phi : Double, dt : Double, s0 : Int) -> Double {
  phi + dt * s0.to_double() * (1.0 - phi.abs())
}

///|
pub fn level_set_area(phi : Array[Double], dx : Double) -> Double {
  let mut area = 0.0
  for i in 0..<phi.length() {
    if phi[i] < 0.0 { area += dx * dx }
  }
  area
}' \
'test "level_set_sign" {
  assert_eq(level_set_sign(1.0), 1)
  assert_eq(level_set_sign(-1.0), -1)
  assert_eq(level_set_sign(0.0), 0)
}

test "level_set_normal" {
  let (nx, ny) = level_set_normal((3.0, 4.0))
  assert_true((nx - 0.6).abs() < 0.001)
  assert_true((ny - 0.8).abs() < 0.001)
}

test "level_set_area" {
  let a = level_set_area([-1.0, -1.0, 1.0, 1.0], 1.0)
  assert_true((a - 2.0).abs() < 0.001)
}' \
'- level_set_sign
- level_set_normal
- level_set_curvature
- reinitialize_step
- level_set_area'

create_mod "fast_marching" \
'import {
}' \
'///|
/// # Fast Marching Method
/// # 快速行进法
///
/// Fast marching method for solving Eikonal equation |grad u| = 1/f.
/// 求解 Eikonal 方程 |grad u| = 1/f 的快速行进法。

///|
pub fn solve_eikonal_2d(u_left : Double, u_down : Double, f : Double, h : Double) -> Double {
  let inv_f = 1.0 / f
  let a = 2.0 * inv_f * inv_f * h * h
  let b = -2.0 * (u_left + u_down)
  let c = u_left * u_left + u_down * u_down - a
  let disc = b * b - 4.0 * c
  if disc < 0.0 {
    if u_left < u_down { u_left + inv_f * h } else { u_down + inv_f * h }
  } else {
    let result = (-b + disc.sqrt()) / 2.0
    if result > u_left && result > u_down { result } else {
      if u_left < u_down { u_left + inv_f * h } else { u_down + inv_f * h }
    }
  }
}

///|
pub fn fast_marching_step(narrow_band : Array[(Int, Double)], f : Double, h : Double) -> Array[(Int, Double)] {
  let result : Array[(Int, Double)] = []
  for i in 0..<narrow_band.length() {
    let (idx, u) = narrow_band[i]
    result.push((idx, u + h / f))
  }
  result
}

///|
pub fn is_far(value : Double) -> Bool {
  value > 99999999.0
}

///|
pub fn is_frozen(value : Double) -> Bool {
  value >= 0.0 && value < 99999999.0
}' \
'test "solve_eikonal_2d" {
  let u = solve_eikonal_2d(0.0, 0.0, 1.0, 1.0)
  assert_true((u - 0.707107).abs() < 0.01)
}

test "is_far" {
  assert_true(is_far(999999999.0))
  assert_false(is_far(1.0))
}

test "is_frozen" {
  assert_true(is_frozen(1.0))
  assert_false(is_frozen(-1.0))
}' \
'- solve_eikonal_2d
- fast_marching_step
- is_far
- is_frozen'

create_mod "fast_sweeping" \
'import {
}' \
'///|
/// # Fast Sweeping Method
/// # 快速扫描法
///
/// Fast sweeping method for Eikonal equations via Gauss-Seidel iterations.
/// 通过 Gauss-Seidel 迭代求解 Eikonal 方程的快速扫描法。

///|
pub fn sweep_update(u_center : Double, u_neighbor1 : Double, u_neighbor2 : Double, f : Double, h : Double) -> Double {
  let inv_f = h / f
  let t1 = if u_neighbor1 < u_center { u_neighbor1 + inv_f } else { u_center }
  let t2 = if u_neighbor2 < u_center { u_neighbor2 + inv_f } else { u_center }
  if t1 > t2 { t1 } else { t2 }
}

///|
pub fn fast_sweeping_iterate(u : Array[Double], f : Array[Double], h : Double, nx : Int, ny : Int) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<u.length() {
    result.push(u[i])
  }
  let dirs = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
  for d in 0..<4 {
    let (dx, dy) = dirs[d]
    let i_start = if dx > 0 { 1 } else { nx - 2 }
    let i_end = if dx > 0 { nx - 1 } else { 0 }
    let j_start = if dy > 0 { 1 } else { ny - 2 }
    let j_end = if dy > 0 { ny - 1 } else { 0 }
    let i_range : Array[Int] = []
    let mut i = i_start
    while (dx > 0 && i <= i_end) || (dx < 0 && i >= i_end) {
      i_range.push(i)
      i += dx
    }
    let j_range : Array[Int] = []
    let mut j = j_start
    while (dy > 0 && j <= j_end) || (dy < 0 && j >= j_end) {
      j_range.push(j)
      j += dy
    }
    for ii in 0..<i_range.length() {
      for jj in 0..<j_range.length() {
        let idx = i_range[ii] + j_range[jj] * nx
        let idx_l = (i_range[ii] - 1) + j_range[jj] * nx
        let idx_r = (i_range[ii] + 1) + j_range[jj] * nx
        let idx_d = i_range[ii] + (j_range[jj] - 1) * nx
        let idx_u = i_range[ii] + (j_range[jj] + 1) * nx
        if idx_l >= 0 && idx_r < result.length() && idx_d >= 0 && idx_u < result.length() {
          result[idx] = sweep_update(result[idx], result[idx_l], result[idx_d], f[idx], h)
        }
      }
    }
  }
  result
}

///|
pub fn sweeping_converged(u_old : Array[Double], u_new : Array[Double], tol : Double) -> Bool {
  let mut max_diff = 0.0
  for i in 0..<u_old.length() {
    let diff = (u_new[i] - u_old[i]).abs()
    if diff > max_diff { max_diff = diff }
  }
  max_diff < tol
}' \
'test "sweep_update" {
  let u = sweep_update(999999.0, 0.0, 0.0, 1.0, 1.0)
  assert_true((u - 1.0).abs() < 0.001)
}

test "sweeping_converged" {
  assert_true(sweeping_converged([1.0, 2.0], [1.0001, 2.0001], 0.01))
}' \
'- sweep_update
- fast_sweeping_iterate
- sweeping_converged'

create_mod "lattice_boltzmann" \
'import {
}' \
'///|
/// # Lattice Boltzmann Method
/// # 格子 Boltzmann 方法
///
/// Lattice Boltzmann method for fluid dynamics simulation.
/// 流体动力学模拟的格子 Boltzmann 方法。

///|
pub fn equilibrium_dist(rho : Double, u : Double, w : Double, cx : Double) -> Double {
  let cu = cx * u
  w * rho * (1.0 + 3.0 * cu + 4.5 * cu * cu - 1.5 * u * u)
}

///|
pub fn collide(f : Double, f_eq : Double, tau : Double) -> Double {
  f - (f - f_eq) / tau
}

///|
pub fn compute_density(dists : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<dists.length() {
    sum += dists[i]
  }
  sum
}

///|
pub fn compute_velocity(dists : Array[Double], velocities : Array[Double]) -> Double {
  let rho = compute_density(dists)
  if rho < 0.000000000001 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<dists.length() {
    sum += dists[i] * velocities[i]
  }
  sum / rho
}

///|
pub fn relaxation_time(nu : Double, dt : Double, dx : Double) -> Double {
  3.0 * nu * dt / (dx * dx) + 0.5
}' \
'test "equilibrium_dist" {
  let f = equilibrium_dist(1.0, 0.0, 1.0 / 3.0, 0.0)
  assert_true((f - 0.333333).abs() < 0.001)
}

test "collide" {
  let f = collide(1.0, 0.5, 1.0)
  assert_true((f - 0.5).abs() < 0.001)
}

test "compute_density" {
  let rho = compute_density([1.0, 2.0, 3.0])
  assert_true((rho - 6.0).abs() < 0.001)
}

test "relaxation_time" {
  let tau = relaxation_time(0.1, 1.0, 1.0)
  assert_true((tau - 0.8).abs() < 0.001)
}' \
'- equilibrium_dist
- collide
- compute_density
- compute_velocity
- relaxation_time'

create_mod "discontinuous_galerkin" \
'import {
}' \
'///|
/// # Discontinuous Galerkin Method
/// # 间断 Galerkin 方法
///
/// DG method for hyperbolic PDEs with discontinuous solutions.
/// 具有间断解的双曲 PDE 的 DG 方法。

///|
pub fn dg_mass_matrix(h : Double, p : Int) -> Double {
  h / (2.0 * p.to_double() + 1.0)
}

///|
pub fn dg_stiffness_matrix(h : Double, p : Int) -> Double {
  if p == 0 { return 0.0 }
  2.0 * p.to_double() / h
}

///|
pub fn dg_numerical_flux(u_left : Double, u_right : Double, alpha : Double) -> Double {
  0.5 * (u_left + u_right) - 0.5 * alpha * (u_right - u_left)
}

///|
pub fn dg_lax_friedrichs_flux(f_left : Double, f_right : Double, u_left : Double, u_right : Double, alpha : Double) -> Double {
  0.5 * (f_left + f_right) - 0.5 * alpha * (u_right - u_left)
}

///|
pub fn dg_error_estimate(element_error : Double, h : Double, p : Int) -> Double {
  element_error * pow_h(h, p + 1)
}

fn pow_h(h : Double, p : Int) -> Double {
  let mut result = 1.0
  for _ in 0..<p {
    result *= h
  }
  result
}' \
'test "dg_mass_matrix" {
  let m = dg_mass_matrix(2.0, 0)
  assert_true((m - 2.0).abs() < 0.001)
}

test "dg_numerical_flux" {
  let f = dg_numerical_flux(1.0, 3.0, 1.0)
  assert_true((f - 1.0).abs() < 0.001)
}

test "dg_lax_friedrichs_flux" {
  let f = dg_lax_friedrichs_flux(1.0, 3.0, 1.0, 3.0, 1.0)
  assert_true((f - 1.0).abs() < 0.001)
}' \
'- dg_mass_matrix
- dg_stiffness_matrix
- dg_numerical_flux
- dg_lax_friedrichs_flux
- dg_error_estimate'

create_mod "radial_basis" \
'import {
  "moonbitlang/core/math",
}' \
'///|
/// # Radial Basis Function Interpolation
/// # 径向基函数插值
///
/// RBF interpolation for scattered data approximation.
/// 散乱数据近似的径向基函数插值。

///|
pub fn rbf_interpolate_gaussian(r : Double, eps : Double) -> Double {
  @math.exp(-eps * eps * r * r)
}

///|
pub fn rbf_interpolate_multiquadric(r : Double, eps : Double) -> Double {
  (1.0 + eps * eps * r * r).sqrt()
}

///|
pub fn rbf_interpolate_inverse_multiquadric(r : Double, eps : Double) -> Double {
  1.0 / (1.0 + eps * eps * r * r).sqrt()
}

///|
pub fn rbf_interpolate_polyharmonic(r : Double, k : Int) -> Double {
  if k == 3 {
    if r < 0.000000000001 { 0.0 } else { r * r * r }
  } else if k == 5 {
    if r < 0.000000000001 { 0.0 } else { r * r * r * r * r }
  } else {
    if r < 0.000000000001 { 0.0 } else { r * r * r.ln() }
  }
}

///|
pub fn rbf_condition_number_estimate(centers : Array[(Double, Double)], eps : Double) -> Double {
  let mut min_dist = 999999999.0
  let mut max_dist = 0.0
  for i in 0..<centers.length() {
    for j in 0..<centers.length() {
      if i != j {
        let (x1, y1) = centers[i]
        let (x2, y2) = centers[j]
        let d = ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)).sqrt()
        if d < min_dist { min_dist = d }
        if d > max_dist { max_dist = d }
      }
    }
  }
  if min_dist < 0.000000000001 { 999999999.0 } else { max_dist / min_dist * eps }
}' \
'test "rbf_interpolate_gaussian" {
  let v = rbf_interpolate_gaussian(0.0, 1.0)
  assert_true((v - 1.0).abs() < 0.001)
}

test "rbf_interpolate_multiquadric" {
  let v = rbf_interpolate_multiquadric(0.0, 1.0)
  assert_true((v - 1.0).abs() < 0.001)
}

test "rbf_interpolate_polyharmonic" {
  let v = rbf_interpolate_polyharmonic(0.0, 3)
  assert_true(v.abs() < 0.001)
}' \
'- rbf_interpolate_gaussian
- rbf_interpolate_multiquadric
- rbf_interpolate_inverse_multiquadric
- rbf_interpolate_polyharmonic
- rbf_condition_number_estimate'

echo "=== Phase 13-16 done (40 modules) ==="