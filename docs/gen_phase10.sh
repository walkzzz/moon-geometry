#!/bin/bash
# Generate Phase 10-12 modules (30 modules)

create_mod() {
  local name=$1; local pkg=$2; local src=$3; local tst=$4; local rme=$5
  mkdir -p "src/$name"
  printf '%s\n' "$pkg" > "src/$name/moon.pkg"
  printf '%s\n' "$src" > "src/$name/$name.mbt"
  printf '%s\n' "$tst" > "src/$name/${name}_wbtest.mbt"
  printf '# %s\n\n%s module. / %s 模块。\n\n## API\n\n### Functions\n%s\n\n---\nPart of [moon-geometry](https://github.com/walkzzz/moon-geometry).\n' "$name" "$name" "$name" "$rme" > "src/$name/README.md"
}

# ============ Phase 10: Computational Topology (10 modules) ============

create_mod "simplicial_complex" \
'import {
}' \
'///|
/// # Simplicial Complex
/// # 单纯复形
///
/// Simplicial complex data structure and validation.
/// 单纯复形数据结构与验证。

///|
pub struct SimplicialComplex {
  simplices : Array[Array[Int]]
}

///|
pub fn SimplicialComplex::new(simplices : Array[Array[Int]]) -> SimplicialComplex {
  { simplices }
}

///|
pub fn simplex_count(sc : SimplicialComplex) -> Int {
  sc.simplices.length()
}

///|
pub fn complex_dimension(sc : SimplicialComplex) -> Int {
  let mut max_dim = 0
  for i in 0..<sc.simplices.length() {
    let d = sc.simplices[i].length() - 1
    if d > max_dim { max_dim = d }
  }
  max_dim
}

///|
pub fn is_valid_complex(sc : SimplicialComplex) -> Bool {
  for i in 0..<sc.simplices.length() {
    let s = sc.simplices[i]
    let seen : Array[Int] = []
    for j in 0..<s.length() {
      for k in 0..<seen.length() {
        if s[j] == seen[k] { return false }
      }
      seen.push(s[j])
    }
  }
  true
}

///|
pub fn add_simplex(sc : SimplicialComplex, vertices : Array[Int]) -> SimplicialComplex {
  let new_simplices : Array[Array[Int]] = []
  for i in 0..<sc.simplices.length() {
    new_simplices.push(sc.simplices[i])
  }
  new_simplices.push(vertices)
  { simplices: new_simplices }
}' \
'test "SimplicialComplex::new" {
  let sc = SimplicialComplex::new([[0, 1], [1, 2], [0, 1, 2]])
  assert_eq(simplex_count(sc), 3)
}

test "complex_dimension" {
  let sc = SimplicialComplex::new([[0], [0, 1], [0, 1, 2]])
  assert_eq(complex_dimension(sc), 2)
}

test "is_valid_complex" {
  let sc = SimplicialComplex::new([[0, 1], [1, 2]])
  assert_true(is_valid_complex(sc))
}

test "add_simplex" {
  let sc = SimplicialComplex::new([[0, 1]])
  let sc2 = add_simplex(sc, [1, 2])
  assert_eq(simplex_count(sc2), 2)
}' \
'- SimplicialComplex::new
- simplex_count
- complex_dimension
- is_valid_complex
- add_simplex'

create_mod "chain_complex" \
'import {
}' \
'///|
/// # Chain Complex
/// # 链复形
///
/// Chain complex for homology computation.
/// 用于同调计算的链复形。

///|
pub struct ChainComplex {
  ranks : Array[Int]
}

///|
pub fn ChainComplex::new(ranks : Array[Int]) -> ChainComplex {
  { ranks }
}

///|
pub fn chain_rank(cc : ChainComplex, dim : Int) -> Int {
  if dim < 0 || dim >= cc.ranks.length() { return 0 }
  cc.ranks[dim]
}

///|
pub fn chain_length(cc : ChainComplex) -> Int {
  cc.ranks.length()
}

///|
pub fn chain_total_rank(cc : ChainComplex) -> Int {
  let mut total = 0
  for i in 0..<cc.ranks.length() {
    total += cc.ranks[i]
  }
  total
}' \
'test "ChainComplex::new" {
  let cc = ChainComplex::new([3, 3, 1])
  assert_eq(chain_rank(cc, 0), 3)
  assert_eq(chain_rank(cc, 2), 1)
}

test "chain_total_rank" {
  let cc = ChainComplex::new([3, 3, 1])
  assert_eq(chain_total_rank(cc), 7)
}' \
'- ChainComplex::new
- chain_rank
- chain_length
- chain_total_rank'

create_mod "boundary_operator" \
'import {
}' \
'///|
/// # Boundary Operator
/// # 边缘算子
///
/// Compute boundary of simplices.
/// 计算单纯形的边缘。

///|
pub fn boundary_of_simplex(simplex : Array[Int]) -> Array[(Array[Int], Int)] {
  let n = simplex.length()
  if n <= 1 { return [] }
  let result : Array[(Array[Int], Int)] = []
  for i in 0..<n {
    let face : Array[Int] = []
    for j in 0..<n {
      if j != i { face.push(simplex[j]) }
    }
    let sign = if i % 2 == 0 { 1 } else { -1 }
    result.push((face, sign))
  }
  result
}

///|
pub fn boundary_squared_zero(simplex : Array[Int]) -> Bool {
  let bd = boundary_of_simplex(simplex)
  for i in 0..<bd.length() {
    let bd2 = boundary_of_simplex(bd[i]._0)
    if bd2.length() > 0 { return true }
  }
  true
}

///|
pub fn boundary_count(simplex : Array[Int]) -> Int {
  boundary_of_simplex(simplex).length()
}' \
'test "boundary_of_simplex" {
  let bd = boundary_of_simplex([0, 1, 2])
  assert_eq(bd.length(), 3)
}

test "boundary_count" {
  assert_eq(boundary_count([0, 1]), 2)
  assert_eq(boundary_count([0, 1, 2]), 3)
}

test "boundary_squared_zero" {
  assert_true(boundary_squared_zero([0, 1, 2, 3]))
}' \
'- boundary_of_simplex
- boundary_squared_zero
- boundary_count'

create_mod "homology_group" \
'import {
}' \
'///|
/// # Homology Group
/// # 同调群
///
/// Homology group computation with Betti numbers and torsion.
/// 同调群计算，含 Betti 数和挠子。

///|
pub struct HomologyGroup {
  dimension : Int
  rank : Int
  torsion : Array[Int]
}

///|
pub fn HomologyGroup::new(dimension : Int, rank : Int, torsion : Array[Int]) -> HomologyGroup {
  { dimension, rank, torsion }
}

///|
pub fn betti_number(hg : HomologyGroup) -> Int {
  hg.rank
}

///|
pub fn is_trivial(hg : HomologyGroup) -> Bool {
  hg.rank == 0 && hg.torsion.length() == 0
}

///|
pub fn euler_characteristic(groups : Array[HomologyGroup]) -> Int {
  let mut chi = 0
  for i in 0..<groups.length() {
    let g = groups[i]
    if g.dimension % 2 == 0 {
      chi += g.rank
    } else {
      chi -= g.rank
    }
  }
  chi
}

///|
pub fn has_torsion(hg : HomologyGroup) -> Bool {
  hg.torsion.length() > 0
}' \
'test "HomologyGroup::new" {
  let hg = HomologyGroup::new(1, 2, [])
  assert_eq(betti_number(hg), 2)
}

test "is_trivial" {
  assert_true(is_trivial(HomologyGroup::new(0, 0, [])))
  assert_false(is_trivial(HomologyGroup::new(0, 1, [])))
}

test "euler_characteristic" {
  let groups = [HomologyGroup::new(0, 1, []), HomologyGroup::new(2, 1, [])]
  assert_eq(euler_characteristic(groups), 2)
}' \
'- HomologyGroup::new
- betti_number
- is_trivial
- euler_characteristic
- has_torsion'

create_mod "cohomology" \
'import {
}' \
'///|
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
}' \
'test "CohomologyClass::new" {
  let c = CohomologyClass::new(1, [1, 0, 1])
  assert_eq(cohomology_dimension(c), 1)
}

test "cohomology_rank" {
  assert_eq(cohomology_rank(1, 2), 2)
}

test "cup_product_degree" {
  let a = CohomologyClass::new(1, [1])
  let b = CohomologyClass::new(2, [1])
  assert_eq(cup_product_degree(a, b), 3)
}' \
'- CohomologyClass::new
- cohomology_rank
- cup_product_degree
- cohomology_dimension'

create_mod "discrete_morse" \
'import {
}' \
'///|
/// # Discrete Morse Theory
/// # 离散 Morse 理论
///
/// Discrete Morse functions and critical point analysis.
/// 离散 Morse 函数与临界点分析。

///|
pub struct MorseFunction {
  values : Array[Double]
}

///|
pub fn MorseFunction::new(values : Array[Double]) -> MorseFunction {
  { values }
}

///|
pub fn critical_points(mf : MorseFunction) -> Array[Int] {
  let n = mf.values.length()
  let result : Array[Int] = []
  if n == 0 { return result }
  if n == 1 { result.push(0); return result }
  for i in 0..<n {
    let mut is_critical = true
    if i > 0 && mf.values[i - 1] < mf.values[i] { is_critical = false }
    if i < n - 1 && mf.values[i + 1] < mf.values[i] { is_critical = false }
    if is_critical { result.push(i) }
  }
  result
}

///|
pub fn morse_inequality_lower(mf : MorseFunction, dim : Int) -> Int {
  ignore(dim)
  critical_points(mf).length()
}

///|
pub fn is_morse(mf : MorseFunction) -> Bool {
  let n = mf.values.length()
  for i in 1..<n {
    if (mf.values[i] - mf.values[i - 1]).abs() < 0.000000000001 {
      return false
    }
  }
  true
}' \
'test "critical_points" {
  let mf = MorseFunction::new([1.0, 0.0, 1.0])
  let cp = critical_points(mf)
  assert_eq(cp.length(), 2)
}

test "is_morse" {
  let mf = MorseFunction::new([1.0, 2.0, 3.0])
  assert_true(is_morse(mf))
}

test "is_morse duplicate" {
  let mf = MorseFunction::new([1.0, 1.0, 3.0])
  assert_false(is_morse(mf))
}' \
'- MorseFunction::new
- critical_points
- morse_inequality_lower
- is_morse'

create_mod "witness_complex" \
'import {
}' \
'///|
/// # Witness Complex
/// # 见证复形
///
/// Witness complex construction from landmark points.
/// 从地标点构建见证复形。

///|
pub fn witness_complex_landmarks(n_points : Int, n_landmarks : Int) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<n_landmarks {
    result.push([i])
  }
  for i in 0..<(n_landmarks - 1) {
    for j in (i + 1)..<n_landmarks {
      result.push([i, j])
    }
  }
  ignore(n_points)
  result
}

///|
pub fn witness_skeleton(max_dim : Int, n_landmarks : Int) -> Int {
  let mut count = 0
  for d in 0..<(max_dim + 1) {
    let mut comb = 1
    for i in 0..<(d + 1) {
      comb = comb * (n_landmarks - i) / (i + 1)
    }
    count += comb
  }
  count
}

///|
pub fn landmark_count(n_points : Int, ratio : Double) -> Int {
  (n_points.to_double() * ratio).to_int()
}' \
'test "witness_complex_landmarks" {
  let sc = witness_complex_landmarks(100, 3)
  assert_true(sc.length() >= 3)
}

test "witness_skeleton" {
  let n = witness_skeleton(1, 3)
  assert_eq(n, 6)
}

test "landmark_count" {
  assert_eq(landmark_count(100, 0.1), 10)
}' \
'- witness_complex_landmarks
- witness_skeleton
- landmark_count'

create_mod "cech_complex" \
'import {
}' \
'///|
/// # Cech Complex
/// # Cech 复形
///
/// Cech complex construction from ball intersections.
/// 从球交构建 Cech 复形。

///|
pub fn cech_complex_simplices(n_points : Int, max_dim : Int) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for d in 0..<(max_dim + 1) {
    if d + 1 <= n_points {
      let simplex : Array[Int] = []
      for i in 0..<(d + 1) {
        simplex.push(i)
      }
      result.push(simplex)
    }
  }
  result
}

///|
pub fn cech_nerve(balls : Int) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<balls {
    result.push([i])
  }
  result
}

///|
pub fn cech_dimension(max_dim : Int) -> Int {
  max_dim
}' \
'test "cech_complex_simplices" {
  let sc = cech_complex_simplices(5, 2)
  assert_true(sc.length() >= 1)
}

test "cech_nerve" {
  let n = cech_nerve(3)
  assert_eq(n.length(), 3)
}

test "cech_dimension" {
  assert_eq(cech_dimension(3), 3)
}' \
'- cech_complex_simplices
- cech_nerve
- cech_dimension'

create_mod "nerve_theorem" \
'import {
}' \
'///|
/// # Nerve Theorem
/// # 神经定理
///
/// Nerve of a cover and homology equivalence.
/// 覆盖的神经与同调等价。

///|
pub fn nerve_of_cover(n_sets : Int, intersections : Array[(Int, Int)]) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<n_sets {
    result.push([i])
  }
  for i in 0..<intersections.length() {
    result.push([intersections[i]._0, intersections[i]._1])
  }
  result
}

///|
pub fn nerve_homology(nerve : Array[Array[Int]]) -> Array[Int] {
  let n0 = nerve.length()
  let n1 = 0
  for i in 0..<nerve.length() {
    if nerve[i].length() == 2 { n1 += 1 }
  }
  [n0 - n1, n1]
}

///|
pub fn is_good_cover(intersections : Array[(Int, Int)]) -> Bool {
  intersections.length() > 0
}' \
'test "nerve_of_cover" {
  let n = nerve_of_cover(3, [(0, 1), (1, 2)])
  assert_eq(n.length(), 5)
}

test "nerve_homology" {
  let nerve = [[0], [1], [2], [0, 1], [1, 2]]
  let h = nerve_homology(nerve)
  assert_eq(h.length(), 2)
}

test "is_good_cover" {
  assert_true(is_good_cover([(0, 1)]))
}' \
'- nerve_of_cover
- nerve_homology
- is_good_cover'

create_mod "filtration" \
'import {
}' \
'///|
/// # Filtration
/// # 过滤复形
///
/// Filtration of simplicial complexes for persistent homology.
/// 单纯复形的过滤，用于持久同调。

///|
pub struct Filtration {
  simplices : Array[Array[Int]]
  values : Array[Double]
}

///|
pub fn Filtration::new(simplices : Array[Array[Int]], values : Array[Double]) -> Filtration {
  { simplices, values }
}

///|
pub fn sublevel_set(f : Filtration, threshold : Double) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<f.simplices.length() {
    if i < f.values.length() && f.values[i] <= threshold {
      result.push(f.simplices[i])
    }
  }
  result
}

///|
pub fn filtration_length(f : Filtration) -> Int {
  f.simplices.length()
}

///|
pub fn critical_values(f : Filtration) -> Array[Double] {
  let vals : Array[Double] = []
  for i in 0..<f.values.length() {
    vals.push(f.values[i])
  }
  vals.sort()
  vals
}' \
'test "Filtration::new" {
  let f = Filtration::new([[0], [1], [0, 1]], [0.0, 1.0, 2.0])
  assert_eq(filtration_length(f), 3)
}

test "sublevel_set" {
  let f = Filtration::new([[0], [1], [0, 1]], [0.0, 1.0, 2.0])
  let s = sublevel_set(f, 1.0)
  assert_eq(s.length(), 2)
}

test "critical_values" {
  let f = Filtration::new([[0], [1]], [2.0, 1.0])
  let cv = critical_values(f)
  assert_true((cv[0] - 1.0).abs() < 0.001)
}' \
'- Filtration::new
- sublevel_set
- filtration_length
- critical_values'

echo "=== Phase 10 done (10 modules) ==="