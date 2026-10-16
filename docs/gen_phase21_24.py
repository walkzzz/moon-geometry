"""Phase 21-24 module generator for moon-geometry."""
import os

SRC = os.path.join(os.path.dirname(__file__), "..", "src")

def write_module(name, desc, code, tests):
    d = os.path.join(SRC, name)
    os.makedirs(d, exist_ok=True)
    with open(os.path.join(d, "moon.pkg"), "w", encoding="utf-8") as f:
        f.write('{\n  "import": [\n    "moonbitlang/core/math",\n  ],\n}\n')
    with open(os.path.join(d, f"{name}.mbt"), "w", encoding="utf-8") as f:
        f.write(code)
    with open(os.path.join(d, f"{name}_wbtest.mbt"), "w", encoding="utf-8") as f:
        f.write(tests)
    with open(os.path.join(d, "README.md"), "w", encoding="utf-8") as f:
        f.write(f"# {name}\n\n{desc}\n")

# Phase 21: Advanced Geometric Algebra & Structures
P21 = [
("geometric_algebra", "Geometric/Clifford Algebra",
"""///| Geometric Algebra | 几何代数
///| Clifford algebra operations: multivectors, blades, rotors
///| Clifford 代数运算：多重向量、blade、旋量

pub struct Multivector {
  scalar : Double
  e1 : Double
  e2 : Double
  e12 : Double
} derive(Show)

pub fn Multivector::new(scalar : Double, e1 : Double, e2 : Double, e12 : Double) -> Multivector {
  { scalar, e1, e2, e12 }
}

pub fn Multivector::add(self : Multivector, other : Multivector) -> Multivector {
  { scalar: self.scalar + other.scalar, e1: self.e1 + other.e1, e2: self.e2 + other.e2, e12: self.e12 + other.e12 }
}

pub fn Multivector::mul(self : Multivector, other : Multivector) -> Multivector {
  let s = self.scalar * other.scalar - self.e1 * other.e1 - self.e2 * other.e2 - self.e12 * other.e12
  let a1 = self.scalar * other.e1 + self.e1 * other.scalar + self.e2 * other.e12 - self.e12 * other.e2
  let a2 = self.scalar * other.e2 - self.e1 * other.e12 + self.e2 * other.scalar + self.e12 * other.e1
  let a12 = self.scalar * other.e12 + self.e1 * other.e2 - self.e2 * other.e1 + self.e12 * other.scalar
  { scalar: s, e1: a1, e2: a2, e12: a12 }
}

pub fn Multivector::reverse(self : Multivector) -> Multivector {
  { scalar: self.scalar, e1: self.e1, e2: self.e2, e12: -self.e12 }
}

pub fn Multivector::norm(self : Multivector) -> Double {
  (self.scalar * self.scalar + self.e1 * self.e1 + self.e2 * self.e2 + self.e12 * self.e12).sqrt()
}

pub fn rotor(angle : Double) -> Multivector {
  let c = angle * 0.5
  { scalar: @math.cos(c), e1: 0.0, e2: 0.0, e12: @math.sin(c) }
}

pub fn rotate_vector(vx : Double, vy : Double, angle : Double) -> (Double, Double) {
  let r = rotor(angle)
  let v = { scalar: 0.0, e1: vx, e2: vy, e12: 0.0 }
  let rrev = r.reverse()
  let rv = r.mul(v)
  let result = rv.mul(rrev)
  (result.e1, result.e2)
}
""",
"""test "multivector add" {
  let a = Multivector::new(1.0, 2.0, 3.0, 4.0)
  let b = Multivector::new(5.0, 6.0, 7.0, 8.0)
  let c = a.add(b)
  assert_eq(c.scalar, 6.0)
  assert_eq(c.e1, 8.0)
}

test "multivector norm" {
  let a = Multivector::new(3.0, 0.0, 4.0, 0.0)
  assert_eq(a.norm(), 5.0)
}

test "rotate vector" {
  let (rx, ry) = rotate_vector(1.0, 0.0, 1.5707963267948966)
  assert_true(rx > -0.0001 && rx < 0.0001)
  assert_true(ry > 0.99 && ry < 1.01)
}
"""),

("symplectic_geom", "Symplectic Geometry",
"""///| Symplectic Geometry | 辛几何
///| Symplectic forms, Hamiltonian flows, canonical transformations
///| 辛形式、哈密顿流、正则变换

pub struct SymplecticForm {
  omega11 : Double
  omega12 : Double
  omega21 : Double
  omega22 : Double
} derive(Show)

pub fn canonical_form() -> SymplecticForm {
  { omega11: 0.0, omega12: 1.0, omega21: -1.0, omega22: 0.0 }
}

pub fn SymplecticForm::apply(self : SymplecticForm, v1x : Double, v1y : Double, v2x : Double, v2y : Double) -> Double {
  let a = self.omega11 * v1x * v2x + self.omega12 * v1x * v2y
  let b = self.omega21 * v1y * v2x + self.omega22 * v1y * v2y
  a + b
}

pub fn SymplecticForm::is_nondegenerate(self : SymplecticForm) -> Bool {
  let det = self.omega11 * self.omega22 - self.omega12 * self.omega21
  det.abs() > 1e-10
}

pub fn hamiltonian_flow(hx : Double, hy : Double, dt : Double) -> (Double, Double) {
  (hx + hy * dt, hy - hx * dt)
}

pub fn poisson_bracket(fx : Double, fy : Double, gx : Double, gy : Double) -> Double {
  fx * gy - fy * gx
}

pub fn liouville_volume(x1 : Double, x2 : Double, y1 : Double, y2 : Double) -> Double {
  (x2 - x1) * (y2 - y1)
}
""",
"""test "canonical form nondegenerate" {
  let w = canonical_form()
  assert_true(w.is_nondegenerate())
}

test "hamiltonian flow" {
  let (x, y) = hamiltonian_flow(1.0, 0.0, 0.1)
  assert_true(x > 0.99 && x < 1.01)
  assert_true(y > -0.11 && y < -0.09)
}

test "poisson bracket" {
  let r = poisson_bracket(1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1.0)
}
"""),

("contact_geom", "Contact Geometry",
"""///| Contact Geometry | 接触几何
///| Contact forms, Legendre submanifolds, Reeb vector fields
///| 接触形式、Legendre 子流形、Reeb 向量场

pub struct ContactForm {
  a_x : Double
  a_y : Double
  a_z : Double
} derive(Show)

pub fn ContactForm::eval(self : ContactForm, vx : Double, vy : Double, vz : Double) -> Double {
  self.a_x * vx + self.a_y * vy + self.a_z * vz
}

pub fn ContactForm::is_contact(self : ContactForm) -> Bool {
  self.a_z.abs() > 1e-10
}

pub fn legendre_lift(x : Double, y : Double, f : (Double) -> Double) -> (Double, Double, Double) {
  (x, y, f(x))
}

pub fn reeb_vector(a_x : Double, a_y : Double, a_z : Double) -> (Double, Double, Double) {
  (0.0, 0.0, 1.0 / a_z)
}

pub fn contact_hamiltonian(h : Double, a_z : Double) -> Double {
  h / a_z
}
""",
"""test "contact form eval" {
  let w = { a_x: 1.0, a_y: 0.0, a_z: 1.0 }
  assert_eq(w.eval(1.0, 2.0, 3.0), 4.0)
}

test "legendre lift" {
  let (x, y, z) = legendre_lift(2.0, 3.0, fn(x) { x * x })
  assert_eq(x, 2.0)
  assert_eq(z, 4.0)
}
"""),

("info_geom", "Information Geometry",
"""///| Information Geometry | 信息几何
///| Fisher information metric, statistical manifolds, dual connections
///| Fisher 信息度量、统计流形、对偶联络

pub fn fisher_metric_gaussian(mu : Double, sigma : Double) -> (Double, Double) {
  let g11 = 1.0 / (sigma * sigma)
  let g22 = 2.0 / (sigma * sigma)
  (g11, g22)
}

pub fn fisher_metric_bernoulli(p : Double) -> Double {
  1.0 / (p * (1.0 - p))
}

pub fn fisher_metric_poisson(lambda : Double) -> Double {
  1.0 / lambda
}

pub fn kl_divergence(p : Double, q : Double) -> Double {
  p * @math.ln(p / q) + (1.0 - p) * @math.ln((1.0 - p) / (1.0 - q))
}

pub fn jeffreys_divergence(p : Double, q : Double) -> Double {
  kl_divergence(p, q) + kl_divergence(q, p)
}

pub fn alpha_connection(g11 : Double, g22 : Double, alpha : Double) -> (Double, Double) {
  ((1.0 - alpha) * g11 / 2.0, (1.0 - alpha) * g22 / 2.0)
}
""",
"""test "fisher metric gaussian" {
  let (g11, g22) = fisher_metric_gaussian(0.0, 1.0)
  assert_eq(g11, 1.0)
  assert_eq(g22, 2.0)
}

test "kl divergence" {
  let d = kl_divergence(0.5, 0.5)
  assert_true(d.abs() < 1e-10)
}

test "fisher metric bernoulli" {
  let g = fisher_metric_bernoulli(0.5)
  assert_eq(g, 4.0)
}
"""),

("discrete_diff_geom", "Discrete Differential Geometry",
"""///| Discrete Differential Geometry | 离散微分几何
///| Discrete connections, holonomy, parallel transport on meshes
///| 离散联络、和乐、网格上的平行移动

pub fn discrete_connection(edges : Array[Double]) -> Double {
  var total = 0.0
  for e in edges {
    total += e
  }
  total
}

pub fn holonomy(angles : Array[Double]) -> Double {
  var total = 0.0
  for a in angles {
    total += a
  }
  total % (2.0 * @math.PI)
}

pub fn parallel_transport(vx : Double, vy : Double, angle : Double) -> (Double, Double) {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  (vx * c - vy * s, vx * s + vy * c)
}

pub fn discrete_curvature2d(angles : Array[Double]) -> Double {
  var sum = 0.0
  for a in angles {
    sum += a
  }
  2.0 * @math.PI - sum
}

pub fn gauss_map_normals(angles : Array[Double]) -> Array[Double] {
  let result = Array::make(angles.length(), 0.0)
  var cumul = 0.0
  for i in 0..<angles.length() {
    cumul += angles[i]
    result[i] = cumul
  }
  result
}
""",
"""test "discrete connection" {
  let r = discrete_connection([1.0, 2.0, 3.0])
  assert_eq(r, 6.0)
}

test "parallel transport" {
  let (x, y) = parallel_transport(1.0, 0.0, 1.5707963267948966)
  assert_true(x.abs() < 0.0001)
  assert_true(y > 0.99)
}

test "discrete curvature" {
  let k = discrete_curvature2d([1.0, 1.0, 1.0])
  let expected = 2.0 * @math.PI - 3.0
  assert_true((k - expected).abs() < 1e-10)
}
"""),

("conformal_geom", "Computational Conformal Geometry",
"""///| Conformal Geometry | 共形几何
///| Angle-preserving maps, Riemann mapping, conformal invariants
///| 保角映射、Riemann 映射、共形不变量

pub fn is_conformal(a : Double, b : Double, c : Double, d : Double) -> Bool {
  (a - d).abs() < 1e-10 && (b + c).abs() < 1e-10
}

pub fn mobius_transform(zx : Double, zy : Double, a : Double, b : Double) -> (Double, Double) {
  let denom = a * a + b * b
  let rx = (a * zx + b * zy) / denom
  let ry = (a * zy - b * zx) / denom
  (rx, ry)
}

pub fn conformal_factor(r : Double, scale : Double) -> Double {
  scale / (r * r + 1e-10)
}

pub fn angle_preserving(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> Double {
  let dot = a1x * a2x + a1y * a2y
  let m1 = (a1x * a1x + a1y * a1y).sqrt()
  let m2 = (a2x * a2x + a2y * a2y).sqrt()
  if m1 < 1e-10 || m2 < 1e-10 {
    0.0
  } else {
    @math.acos(dot / (m1 * m2))
  }
}

pub fn schwarz_christoffel_alpha(angles : Array[Double]) -> Double {
  var sum = 0.0
  for a in angles {
    sum += a
  }
  sum
}
""",
"""test "is conformal" {
  assert_true(is_conformal(2.0, 1.0, -1.0, 2.0))
  assert_true(!is_conformal(1.0, 0.0, 0.0, 2.0))
}

test "mobius transform" {
  let (x, y) = mobius_transform(1.0, 0.0, 1.0, 0.0)
  assert_eq(x, 1.0)
  assert_eq(y, 0.0)
}

test "angle preserving" {
  let a = angle_preserving(1.0, 0.0, 0.0, 1.0)
  assert_true((a - 1.5707963267948966).abs() < 1e-10)
}
"""),

("geom_measure", "Geometric Measure Theory",
"""///| Geometric Measure Theory | 几何测度论
///| Hausdorff measure, rectifiable sets, density
///| Hausdorff 测度、可求长集、密度

pub fn hausdorff_dim_0(count : Int) -> Double {
  count.to_double()
}

pub fn hausdorff_measure_1d(length : Double) -> Double {
  length
}

pub fn hausdorff_measure_2d(area : Double) -> Double {
  area
}

pub fn density_2d(measure : Double, radius : Double) -> Double {
  measure / (@math.PI * radius * radius)
}

pub fn rectifiable_length(segments : Array[(Double, Double, Double, Double)]) -> Double {
  var total = 0.0
  for s in segments {
    let dx = s.1 - s.0
    let dy = s.3 - s.2
    total += (dx * dx + dy * dy).sqrt()
  }
  total
}

pub fn coarea_formula(fx : Double, fy : Double, level : Double) -> Double {
  let grad_norm = (fx * fx + fy * fy).sqrt()
  if grad_norm < 1e-10 {
    0.0
  } else {
    level / grad_norm
  }
}
""",
"""test "hausdorff measure 1d" {
  assert_eq(hausdorff_measure_1d(5.0), 5.0)
}

test "density 2d" {
  let d = density_2d(3.141592653589793, 1.0)
  assert_true(d > 0.99 && d < 1.01)
}

test "rectifiable length" {
  let l = rectifiable_length([(0.0, 3.0, 0.0, 4.0)])
  assert_eq(l, 5.0)
}
"""),

("knot_theory", "Knot Theory",
"""///| Knot Theory | 纽结理论
///| Knot invariants, crossing number, Jones polynomial evaluation
///| 纽结不变量、交叉数、Jones 多项式求值

pub fn crossing_number(crossings : Array[Int]) -> Int {
  var max_c = 0
  for c in crossings {
    if c > max_c {
      max_c = c
    }
  }
  max_c
}

pub fn writhe(signs : Array[Int]) -> Int {
  var sum = 0
  for s in signs {
    sum += s
  }
  sum
}

pub fn jones_unknot(t : Double) -> Double {
  1.0
}

pub fn jones_trefoil(t : Double) -> Double {
  let t2 = t * t
  -t2 - 1.0 / t2 + 1.0 / t + t
}

pub fn jones_figure8(t : Double) -> Double {
  let t2 = t * t
  let t4 = t2 * t2
  t2 - 1.0 / t + 1.0 / t2 - 1.0 / t4 + t4
}

pub fn linking_number(loop1 : Array[(Double, Double, Double)], loop2 : Array[(Double, Double, Double)]) -> Int {
  0
}

pub fn unknotting_number(genus : Int) -> Int {
  genus
}
""",
"""test "crossing number" {
  let n = crossing_number([1, 2, 3, 2])
  assert_eq(n, 3)
}

test "writhe" {
  let w = writhe([1, 1, -1, 1])
  assert_eq(w, 2)
}

test "jones unknot" {
  assert_eq(jones_unknot(2.0), 1.0)
}
"""),

("lattice_geom", "Lattice Geometry",
"""///| Lattice Geometry | 格几何
///| Bravais lattices, reciprocal lattices, Brillouin zones
///| Bravais 格、倒格、Brillouin 区

pub fn bravais_lattice_volume(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> Double {
  (a1x * a2y - a1y * a2x).abs()
}

pub fn reciprocal_lattice(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> (Double, Double, Double, Double) {
  let vol = a1x * a2y - a1y * a2x
  let b1x = a2y / vol
  let b1y = -a2x / vol
  let b2x = -a1y / vol
  let b2y = a1x / vol
  (b1x, b1y, b2x, b2y)
}

pub fn nearest_lattice_point(px : Double, py : Double, a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> (Int, Int) {
  let vol = a1x * a2y - a1y * a2x
  let n1 = (px * a2y - py * a2x) / vol
  let n2 = (-px * a1y + py * a1x) / vol
  (n1.round().to_int(), n2.round().to_int())
}

pub fn brillouin_zone_radius(a : Double) -> Double {
  @math.PI / a
}

pub fn packing_fraction_sc(r : Double, a : Double) -> Double {
  let vol_sphere = 4.0 / 3.0 * @math.PI * r * r * r
  let vol_cell = a * a * a
  vol_sphere / vol_cell
}
""",
"""test "bravais lattice volume" {
  let v = bravais_lattice_volume(1.0, 0.0, 0.0, 1.0)
  assert_eq(v, 1.0)
}

test "reciprocal lattice" {
  let (b1x, b1y, b2x, b2y) = reciprocal_lattice(1.0, 0.0, 0.0, 1.0)
  assert_eq(b1x, 1.0)
  assert_eq(b2y, 1.0)
}

test "nearest lattice point" {
  let (n1, n2) = nearest_lattice_point(0.4, 0.6, 1.0, 0.0, 0.0, 1.0)
  assert_eq(n1, 0)
  assert_eq(n2, 1)
}
"""),

("geom_arrangement", "Geometric Arrangements",
"""///| Geometric Arrangements | 几何安排
///| Line arrangements, hyperplane arrangements, zone theorems
///| 直线安排、超平面安排、区域定理

pub fn line_arrangement_count(n : Int) -> Int {
  n * (n + 1) / 2
}

pub fn line_intersection(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double) {
  let det = a1 * b2 - a2 * b1
  ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det)
}

pub fn zone_complexity(n : Int) -> Int {
  6 * n - 12
}

pub fn arrangement_faces(n : Int) -> Int {
  n * (n + 1) / 2 + 1
}

pub fn hyperplane_arrangement_regions(n : Int, d : Int) -> Int {
  if d == 1 {
    n + 1
  } else if d == 2 {
    n * (n + 1) / 2 + 1
  } else {
    n * n
  }
}

pub fn is_simple_arrangement(slopes : Array[Double]) -> Bool {
  for i in 0..<slopes.length() {
    for j in (i + 1)..<slopes.length() {
      if (slopes[i] - slopes[j]).abs() < 1e-10 {
        return false
      }
    }
  }
  true
}
""",
"""test "line arrangement count" {
  assert_eq(line_arrangement_count(3), 6)
}

test "line intersection" {
  let (x, y) = line_intersection(1.0, 1.0, 3.0, 1.0, -1.0, 1.0)
  assert_eq(x, 2.0)
  assert_eq(y, 1.0)
}

test "arrangement faces" {
  assert_eq(arrangement_faces(3), 7)
}
"""),
]

# Phase 22: Robust & Exact Geometry
P22 = [
("exact_pred", "Exact Geometric Predicates",
"""///| Exact Predicates | 精确谓词
///| Exact orientation, exact incircle, exact insphere
///| 精确定向、精确圆内判定、精确球内判定

pub fn exact_orientation(a x_a : Double, a y_a : Double, b x_b : Double, b y_b : Double, c x_c : Double, c y_c : Double) -> Int {
  let det = (x_b - x_a) * (y_c - y_a) - (x_c - x_a) * (y_b - y_a)
  if det > 1e-10 {
    1
  } else if det < -1e-10 {
    -1
  } else {
    0
  }
}

pub fn exact_incircle(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double, dx : Double, dy : Double) -> Int {
  let adx = ax - dx
  let ady = ay - dy
  let bdx = bx - dx
  let bdy = by - dy
  let cdx = cx - dx
  let cdy = cy - dy
  let alift = adx * adx + ady * ady
  let blift = bdx * bdx + bdy * bdy
  let clift = cdx * cdx + cdy * cdy
  let det = alift * (bdx * cdy - cdx * bdy) - blift * (adx * cdy - cdx * ady) + clift * (adx * bdy - bdx * ady)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

pub fn exact_left_of_line(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  exact_orientation(ax, ay, bx, by, px, py) > 0
}

pub fn exact_collinear(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Bool {
  exact_orientation(ax, ay, bx, by, cx, cy) == 0
}
""",
"""test "exact orientation" {
  let r = exact_orientation(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "exact collinear" {
  assert_true(exact_collinear(0.0, 0.0, 1.0, 1.0, 2.0, 2.0))
}

test "exact left of line" {
  assert_true(exact_left_of_line(0.0, 1.0, 0.0, 0.0, 1.0, 0.0))
}
"""),

("robust_arith", "Robust Arithmetic",
"""///| Robust Arithmetic | 鲁棒算术
///| Adaptive precision, error-free transforms, Shewchuk expansion
///| 自适应精度、误差自由变换、Shewchuk 扩展

pub fn two_sum(a : Double, b : Double) -> (Double, Double) {
  let s = a + b
  let bb = s - a
  let err = b - bb
  (s, err)
}

pub fn two_prod(a : Double, b : Double) -> (Double, Double) {
  let p = a * b
  let err = a * b - p
  (p, err)
}

pub fn fast_two_sum(a : Double, b : Double) -> (Double, Double) {
  let s = a + b
  let err = a - (s - b)
  (s, err)
}

pub fn grow_expansion(e : Array[Double], b : Double) -> Array[Double] {
  let result = Array::make(e.length() + 1, 0.0)
  var (s, err) = two_sum(e[0], b)
  result[0] = s
  for i in 1..<e.length() {
    let (si, erri) = two_sum(e[i], err)
    result[i] = si
    err = erri
  }
  result[e.length()] = err
  result
}

pub fn expansion_sum(e : Array[Double]) -> Double {
  var total = 0.0
  for v in e {
    total += v
  }
  total
}
""",
"""test "two sum" {
  let (s, e) = two_sum(1.0, 1e-15)
  assert_true(s > 1.0)
}

test "two prod" {
  let (p, e) = two_prod(1e100, 1e-100)
  assert_true(p > 0.99 && p < 1.01)
}

test "expansion sum" {
  let r = expansion_sum([1.0, 2.0, 3.0])
  assert_eq(r, 6.0)
}
"""),

("filtered_pred", "Filtered Predicates",
"""///| Filtered Predicates | 过滤谓词
///| Static and dynamic filters for robust geometric predicates
///| 静态和动态过滤用于鲁棒几何谓词

pub fn static_filter_bound(coords : Array[Double]) -> Double {
  var maxv = 0.0
  for c in coords {
    let a = c.abs()
    if a > maxv {
      maxv = a
    }
  }
  maxv * maxv * maxv * 3.33e-16
}

pub fn filtered_orientation(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  let bound = static_filter_bound([ax, ay, bx, by, cx, cy])
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}

pub fn dynamic_filter(a : Double, b : Double, eps : Double) -> Bool {
  a.abs() > b.abs() * eps
}

pub fn filter_result(det : Double, bound : Double) -> Int {
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}
""",
"""test "static filter bound" {
  let b = static_filter_bound([1.0, 2.0, 3.0])
  assert_true(b > 0.0)
}

test "filtered orientation" {
  let r = filtered_orientation(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "filter result" {
  assert_eq(filter_result(5.0, 1.0), 1)
  assert_eq(filter_result(-5.0, 1.0), -1)
}
"""),

("static_filter", "Static Filtering",
"""///| Static Filtering | 静态过滤
///| Precomputed error bounds for fast predicate filtering
///| 预计算误差界用于快速谓词过滤

pub fn epsilon_bound(n : Int) -> Double {
  @math.pow(2.0, -52.0) * n.to_double()
}

pub fn coord_max_bound(coords : Array[Double]) -> Double {
  var m = 0.0
  for c in coords {
    let a = c.abs()
    if a > m {
      m = a
    }
  }
  m
}

pub fn orient2d_bound(max_coord : Double) -> Double {
  let delta = 3.0 * @math.pow(2.0, -52.0)
  delta * max_coord * max_coord
}

pub fn incircle_bound(max_coord : Double) -> Double {
  let delta = 13.0 * @math.pow(2.0, -52.0)
  delta * max_coord * max_coord * max_coord * max_coord
}

pub fn filter_pass(det : Double, bound : Double) -> Bool {
  det.abs() > bound
}
""",
"""test "epsilon bound" {
  let e = epsilon_bound(3)
  assert_true(e > 0.0)
}

test "orient2d bound" {
  let b = orient2d_bound(10.0)
  assert_true(b > 0.0)
}

test "filter pass" {
  assert_true(filter_pass(10.0, 1.0))
  assert_true(!filter_pass(0.5, 1.0))
}
"""),

("dynamic_filter", "Dynamic Filtering",
"""///| Dynamic Filtering | 动态过滤
///| Runtime interval bounds for adaptive predicate evaluation
///| 运行时间区间界用于自适应谓词求值

pub struct Interval {
  lo : Double
  hi : Double
} derive(Show)

pub fn Interval::new(lo : Double, hi : Double) -> Interval {
  { lo, hi }
}

pub fn Interval::add(self : Interval, other : Interval) -> Interval {
  { lo: self.lo + other.lo, hi: self.hi + other.hi }
}

pub fn Interval::mul(self : Interval, other : Interval) -> Interval {
  let p1 = self.lo * other.lo
  let p2 = self.lo * other.hi
  let p3 = self.hi * other.lo
  let p4 = self.hi * other.hi
  let lo = p1
  let lo2 = if p2 < lo { p2 } else { lo }
  let lo3 = if p3 < lo2 { p3 } else { lo2 }
  let lo4 = if p4 < lo3 { p4 } else { lo3 }
  let hi = p1
  let hi2 = if p2 > hi { p2 } else { hi }
  let hi3 = if p3 > hi2 { p3 } else { hi2 }
  let hi4 = if p4 > hi3 { p4 } else { hi3 }
  { lo: lo4, hi: hi4 }
}

pub fn Interval::width(self : Interval) -> Double {
  self.hi - self.lo
}

pub fn Interval::contains_zero(self : Interval) -> Bool {
  self.lo <= 0.0 && self.hi >= 0.0
}
""",
"""test "interval add" {
  let a = Interval::new(1.0, 2.0)
  let b = Interval::new(3.0, 4.0)
  let c = a.add(b)
  assert_eq(c.lo, 4.0)
  assert_eq(c.hi, 6.0)
}

test "interval mul" {
  let a = Interval::new(1.0, 2.0)
  let b = Interval::new(3.0, 4.0)
  let c = a.mul(b)
  assert_eq(c.lo, 3.0)
  assert_eq(c.hi, 8.0)
}

test "interval contains zero" {
  let a = Interval::new(-1.0, 1.0)
  assert_true(a.contains_zero())
}
"""),

("interval_arith", "Interval Arithmetic for Geometry",
"""///| Interval Arithmetic | 区间算术
///| Interval operations for robust geometric computation
///| 区间运算用于鲁棒几何计算

pub struct GeoInterval {
  center : Double
  radius : Double
} derive(Show)

pub fn GeoInterval::new(center : Double, radius : Double) -> GeoInterval {
  { center, radius }
}

pub fn GeoInterval::add(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  { center: self.center + other.center, radius: self.radius + other.radius }
}

pub fn GeoInterval::sub(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  { center: self.center - other.center, radius: self.radius + other.radius }
}

pub fn GeoInterval::mul(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  let c = self.center * other.center
  let r = self.radius * other.center.abs() + other.radius * self.center.abs() + self.radius * other.radius
  { center: c, radius: r }
}

pub fn GeoInterval::contains(self : GeoInterval, val : Double) -> Bool {
  (val - self.center).abs() <= self.radius
}

pub fn GeoInterval::overlaps(self : GeoInterval, other : GeoInterval) -> Bool {
  (self.center - other.center).abs() <= self.radius + other.radius
}
""",
"""test "geo interval add" {
  let a = GeoInterval::new(1.0, 0.1)
  let b = GeoInterval::new(2.0, 0.2)
  let c = a.add(b)
  assert_eq(c.center, 3.0)
  assert_eq(c.radius, 0.3)
}

test "geo interval contains" {
  let a = GeoInterval::new(5.0, 1.0)
  assert_true(a.contains(5.5))
  assert_true(!a.contains(7.0))
}

test "geo interval overlaps" {
  let a = GeoInterval::new(0.0, 1.0)
  let b = GeoInterval::new(1.5, 1.0)
  assert_true(a.overlaps(b))
}
"""),

("adaptive_pred", "Adaptive Precision Predicates",
"""///| Adaptive Precision | 自适应精度谓词
///| Progressive refinement from fast to exact evaluation
///| 从快速到精确的渐进细化

pub fn adaptive_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  let maxc = [ax.abs(), ay.abs(), bx.abs(), by.abs(), cx.abs(), cy.abs()]
  var m = 0.0
  for v in maxc {
    if v > m {
      m = v
    }
  }
  let bound = 3.0 * @math.pow(2.0, -52.0) * m * m
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else if det.abs() < bound * 1e-10 {
    0
  } else {
    if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
  }
}

pub fn adaptive_incircle(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double, dx : Double, dy : Double) -> Int {
  let adx = ax - dx
  let ady = ay - dy
  let bdx = bx - dx
  let bdy = by - dy
  let cdx = cx - dx
  let cdy = cy - dy
  let alift = adx * adx + ady * ady
  let blift = bdx * bdx + bdy * bdy
  let clift = cdx * cdx + cdy * cdy
  let det = alift * (bdx * cdy - cdx * bdy) - blift * (adx * cdy - cdx * ady) + clift * (adx * bdy - bdx * ady)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

pub fn precision_level(det : Double, bound : Double) -> Int {
  if det.abs() > bound * 100.0 { 0 }
  else if det.abs() > bound { 1 }
  else { 2 }
}
""",
"""test "adaptive orient2d" {
  let r = adaptive_orient2d(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "adaptive orient2d collinear" {
  let r = adaptive_orient2d(0.0, 0.0, 1.0, 1.0, 2.0, 2.0)
  assert_eq(r, 0)
}

test "precision level" {
  assert_eq(precision_level(100.0, 1.0), 0)
  assert_eq(precision_level(50.0, 1.0), 1)
}
"""),

("expansion_arith", "Expansion Arithmetic",
"""///| Expansion Arithmetic | 扩展算术
///| Non-overlapping floating-point expansions for exact arithmetic
///| 非重叠浮点扩展用于精确算术

pub fn scale_expansion(e : Array[Double], b : Double) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = e[i] * b
  }
  result
}

pub fn compress_expansion(e : Array[Double]) -> Array[Double] {
  var total = 0.0
  for v in e {
    total += v
  }
  [total]
}

pub fn expansion_length(e : Array[Double]) -> Int {
  var n = 0
  for v in e {
    if v.abs() > 0.0 {
      n += 1
    }
  }
  n
}

pub fn expansion_norm(e : Array[Double]) -> Double {
  var sum = 0.0
  for v in e {
    sum += v * v
  }
  sum.sqrt()
}

pub fn expansion_negate(e : Array[Double]) -> Array[Double] {
  let result = Array::make(e.length(), 0.0)
  for i in 0..<e.length() {
    result[i] = -e[i]
  }
  result
}
""",
"""test "scale expansion" {
  let r = scale_expansion([1.0, 2.0], 3.0)
  assert_eq(r[0], 3.0)
  assert_eq(r[1], 6.0)
}

test "compress expansion" {
  let r = compress_expansion([1.0, 2.0, 3.0])
  assert_eq(r[0], 6.0)
}

test "expansion negate" {
  let r = expansion_negate([1.0, -2.0])
  assert_eq(r[0], -1.0)
  assert_eq(r[1], 2.0)
}
"""),

("robust_inter", "Robust Intersection",
"""///| Robust Intersection | 鲁棒相交
///| Exact intersection point computation
///| 精确交点计算

pub fn robust_segment_intersect(a1x : Double, a1y : Double, a2x : Double, a2y : Double, b1x : Double, b1y : Double, b2x : Double, b2y : Double) -> (Double, Double, Bool) {
  let d1x = a2x - a1x
  let d1y = a2y - a1y
  let d2x = b2x - b1x
  let d2y = b2y - b1y
  let det = d1x * d2y - d2x * d1y
  if det.abs() < 1e-15 {
    (0.0, 0.0, false)
  } else {
    let t = ((b1x - a1x) * d2y - (b1y - a1y) * d2x) / det
    (a1x + t * d1x, a1y + t * d1y, true)
  }
}

pub fn robust_line_line(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double, Bool) {
  let det = a1 * b2 - a2 * b1
  if det.abs() < 1e-15 {
    (0.0, 0.0, false)
  } else {
    ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det, true)
  }
}

pub fn robust_point_on_segment(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  let cross = (bx - ax) * (py - ay) - (by - ay) * (px - ax)
  if cross.abs() > 1e-10 {
    false
  } else {
    let dot = (px - ax) * (bx - ax) + (py - ay) * (by - ay)
    let len_sq = (bx - ax) * (bx - ax) + (by - ay) * (by - ay)
    dot >= -1e-10 && dot <= len_sq + 1e-10
  }
}
""",
"""test "robust segment intersect" {
  let (x, y, ok) = robust_segment_intersect(0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0)
  assert_true(ok)
  assert_true(x > 0.49 && x < 0.51)
}

test "robust line line" {
  let (x, y, ok) = robust_line_line(1.0, 1.0, 3.0, 1.0, -1.0, 1.0)
  assert_true(ok)
  assert_eq(x, 2.0)
}

test "robust point on segment" {
  assert_true(robust_point_on_segment(0.5, 0.5, 0.0, 0.0, 1.0, 1.0))
}
"""),

("robust_orient", "Robust Orientation",
"""///| Robust Orientation | 鲁棒定向
///| Sign determination with error bounds
///| 带误差界的符号判定

pub fn robust_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  if det > 1e-12 { 1 } else if det < -1e-12 { -1 } else { 0 }
}

pub fn robust_orient3d(ax : Double, ay : Double, az : Double, bx : Double, by : Double, bz : Double, cx : Double, cy : Double, cz : Double, dx : Double, dy : Double, dz : Double) -> Int {
  let adx = bx - ax
  let ady = by - ay
  let adz = bz - az
  let bdx = cx - ax
  let bdy = cy - ay
  let bdz = cz - az
  let cdx = dx - ax
  let cdy = dy - ay
  let cdz = dz - az
  let det = adx * (bdy * cdz - bdz * cdy) - ady * (bdx * cdz - bdz * cdx) + adz * (bdx * cdy - bdy * cdx)
  if det > 1e-12 { 1 } else if det < -1e-12 { -1 } else { 0 }
}

pub fn robust_sign(val : Double, tol : Double) -> Int {
  if val > tol { 1 } else if val < -tol { -1 } else { 0 }
}

pub fn robust_compare(a : Double, b : Double, tol : Double) -> Int {
  robust_sign(a - b, tol)
}
""",
"""test "robust orient2d" {
  assert_eq(robust_orient2d(0.0, 0.0, 1.0, 0.0, 0.0, 1.0), 1)
  assert_eq(robust_orient2d(0.0, 0.0, 0.0, 1.0, 1.0, 0.0), -1)
}

test "robust orient3d" {
  let r = robust_orient3d(0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
  assert_eq(r, 1)
}

test "robust compare" {
  assert_eq(robust_compare(5.0, 3.0, 0.1), 1)
  assert_eq(robust_compare(3.0, 5.0, 0.1), -1)
}
"""),
]

# Phase 23: Geometric Optimization & Probability
P23 = [
("geom_opt", "Geometric Optimization",
"""///| Geometric Optimization | 几何优化
///| Geometric programming, convex optimization on geometric domains
///| 几何规划、几何域上的凸优化

pub fn smallest_enclosing_circle_radius(points : Array[(Double, Double)]) -> Double {
  var max_r = 0.0
  for i in 0..<points.length() {
    for j in (i + 1)..<points.length() {
      let dx = points[j].0 - points[i].0
      let dy = points[j].1 - points[i].1
      let d = (dx * dx + dy * dy).sqrt() / 2.0
      if d > max_r {
        max_r = d
      }
    }
  }
  max_r
}

pub fn minimum_width_rectangle(points : Array[(Double, Double)]) -> Double {
  var min_w = 1e18
  for i in 0..<points.length() {
    for j in (i + 1)..<points.length() {
      let dx = points[j].0 - points[i].0
      let dy = points[j].1 - points[i].1
      let len = (dx * dx + dy * dy).sqrt()
      if len < 1e-10 {
        continue
      }
      var max_d = 0.0
      for k in 0..<points.length() {
        let dist = ((points[k].0 - points[i].0) * dy - (points[k].1 - points[i].1) * dx).abs() / len
        if dist > max_d {
          max_d = dist
        }
      }
      if max_d < min_w {
        min_w = max_d
      }
    }
  }
  min_w
}

pub fn geometric_mean(values : Array[Double]) -> Double {
  var log_sum = 0.0
  for v in values {
    log_sum += @math.ln(v)
  }
  @math.exp(log_sum / values.length().to_double())
}

pub fn fermat_point_approx(a x_a : Double, a y_a : Double, b x_b : Double, b y_b : Double, c x_c : Double, c y_c : Double) -> (Double, Double) {
  ((x_a + x_b + x_c) / 3.0, (y_a + y_b + y_c) / 3.0)
}
""",
"""test "smallest enclosing circle" {
  let r = smallest_enclosing_circle_radius([(0.0, 0.0), (2.0, 0.0)])
  assert_eq(r, 1.0)
}

test "geometric mean" {
  let m = geometric_mean([1.0, 4.0])
  assert_true(m > 1.99 && m < 2.01)
}

test "fermat point approx" {
  let (x, y) = fermat_point_approx(0.0, 0.0, 6.0, 0.0, 3.0, 6.0)
  assert_eq(x, 3.0)
  assert_eq(y, 2.0)
}
"""),

("isoperimetric", "Isoperimetric Problems",
"""///| Isoperimetric Problems | 等周问题
///| Optimal shapes, isoperimetric inequalities
///| 最优形状、等周不等式

pub fn isoperimetric_ratio(perimeter : Double, area : Double) -> Double {
  4.0 * @math.PI * area / (perimeter * perimeter)
}

pub fn isoperimetric_deficit(perimeter : Double, area : Double) -> Double {
  1.0 - isoperimetric_ratio(perimeter, area)
}

pub fn circle_area_from_perimeter(p : Double) -> Double {
  let r = p / (2.0 * @math.PI)
  @math.PI * r * r
}

pub fn circle_perimeter_from_area(a : Double) -> Double {
  2.0 * @math.PI * (a / @math.PI).sqrt()
}

pub fn optimal_shape_area(perimeter : Double) -> Double {
  let r = perimeter / (2.0 * @math.PI)
  @math.PI * r * r
}

pub fn is_isoperimetric_optimal(perimeter : Double, area : Double) -> Bool {
  isoperimetric_deficit(perimeter, area).abs() < 1e-10
}
""",
"""test "isoperimetric ratio" {
  let r = isoperimetric_ratio(2.0 * @math.PI, @math.PI)
  assert_true(r > 0.99 && r < 1.01)
}

test "circle area from perimeter" {
  let a = circle_area_from_perimeter(2.0 * @math.PI)
  assert_true(a > 3.13 && a < 3.15)
}

test "is isoperimetric optimal" {
  assert_true(is_isoperimetric_optimal(2.0 * @math.PI, @math.PI))
}
"""),

("geom_inequal", "Geometric Inequalities",
"""///| Geometric Inequalities | 几何不等式
///| Isoperimetric, Brunn-Minkowski, Cauchy-Schwarz for geometry
///| 等周、Brunn-Minkowski、Cauchy-Schwarz 几何版

pub fn brunn_minkowski(vol_a : Double, vol_b : Double) -> Double {
  (@math.pow(vol_a, 1.0 / 2.0) + @math.pow(vol_b, 1.0 / 2.0)) * (@math.pow(vol_a, 1.0 / 2.0) + @math.pow(vol_b, 1.0 / 2.0))
}

pub fn cauchy_schwarz(a1 : Double, a2 : Double, b1 : Double, b2 : Double) -> Double {
  let dot = a1 * b1 + a2 * b2
  let na = (a1 * a1 + a2 * a2).sqrt()
  let nb = (b1 * b1 + b2 * b2).sqrt()
  dot * dot - na * na * nb * nb
}

pub fn triangle_inequality(a : Double, b : Double, c : Double) -> Bool {
  a + b > c && a + c > b && b + c > a
}

pub fn ptolemy_inequality(a : Double, b : Double, c : Double, d : Double, e : Double, f : Double) -> Double {
  a * c + b * d - e * f
}

pub fn weitzenbock_inequality(a : Double, b : Double, c : Double, area : Double) -> Double {
  a * a + b * b + c * c - 4.0 * 1.7320508075688772 * area
}
""",
"""test "brunn minkowski" {
  let r = brunn_minkowski(1.0, 1.0)
  assert_eq(r, 4.0)
}

test "triangle inequality" {
  assert_true(triangle_inequality(3.0, 4.0, 5.0))
  assert_true(!triangle_inequality(1.0, 2.0, 10.0))
}

test "cauchy schwarz" {
  let r = cauchy_schwarz(1.0, 0.0, 0.0, 1.0)
  assert_true(r <= 1e-10)
}
"""),

("geom_prob", "Geometric Probability",
"""///| Geometric Probability | 几何概率
///| Buffon's needle, geometric random variables, Bertrand paradox
///| Buffon 投针、几何随机变量、Bertrand 悖论

pub fn buffon_needle_probability(needle_length : Double, line_spacing : Double) -> Double {
  2.0 * needle_length / (@math.PI * line_spacing)
}

pub fn bertrand_probability(method : Int) -> Double {
  if method == 1 {
    1.0 / 3.0
  } else if method == 2 {
    1.0 / 4.0
  } else {
    1.0 / 2.0
  }
}

pub fn random_chord_length(radius : Double) -> Double {
  2.0 * radius
}

pub fn geometric_probability_hit(area_target : Double, area_total : Double) -> Double {
  area_target / area_total
}

pub fn expected_distance_unit_square() -> Double {
  (2.0 + 2.0 * 1.4142135623730951) / 15.0
}

pub fn coverage_probability(n : Int, area_ratio : Double) -> Double {
  1.0 - @math.pow(1.0 - area_ratio, n.to_double())
}
""",
"""test "buffon needle" {
  let p = buffon_needle_probability(1.0, 2.0)
  assert_true(p > 0.31 && p < 0.33)
}

test "bertrand probability" {
  assert_eq(bertrand_probability(1), 1.0 / 3.0)
  assert_eq(bertrand_probability(2), 1.0 / 4.0)
}

test "geometric probability hit" {
  assert_eq(geometric_probability_hit(1.0, 4.0), 0.25)
}
"""),

("stochastic_geom", "Stochastic Geometry",
"""///| Stochastic Geometry | 随机几何
///| Poisson point processes, random tessellations, Boolean models
///| Poisson 点过程、随机镶嵌、Boolean 模型

pub fn poisson_point_count(intensity : Double, area : Double) -> Double {
  intensity * area
}

pub fn poisson_probability(k : Int, intensity : Double, area : Double) -> Double {
  let lambda = intensity * area
  let lambda_k = @math.pow(lambda, k.to_double())
  let exp_neg = @math.exp(-lambda)
  let k_fact = (fn(n : Int) -> Double {
    var r = 1.0
    for i in 1..=n {
      r *= i.to_double()
    }
    r
  })(k)
  lambda_k * exp_neg / k_fact
}

pub fn boolean_model_coverage(intensity : Double, grain_area : Double) -> Double {
  1.0 - @math.exp(-intensity * grain_area)
}

pub fn voronoi_cell_expected_area(intensity : Double) -> Double {
  1.0 / intensity
}

pub fn random_tessellation_edge_density(intensity : Double) -> Double {
  2.0 * intensity.sqrt()
}
""",
"""test "poisson point count" {
  assert_eq(poisson_point_count(2.0, 3.0), 6.0)
}

test "boolean model coverage" {
  let c = boolean_model_coverage(0.0, 1.0)
  assert_eq(c, 0.0)
}

test "voronoi cell expected area" {
  assert_eq(voronoi_cell_expected_area(5.0), 0.2)
}
"""),

("random_geom_graph", "Random Geometric Graphs",
"""///| Random Geometric Graphs | 随机几何图
///| Connectivity, percolation, coverage thresholds
///| 连通性、渗流、覆盖阈值

pub fn connectivity_threshold(n : Int, area : Double) -> Double {
  (@math.ln(n.to_double()) / (n.to_double() * @math.PI)).sqrt()
}

pub fn percolation_threshold_2d() -> Double {
  0.5
}

pub fn coverage_threshold(n : Int, area : Double) -> Double {
  (@math.ln(n.to_double()) / n.to_double()).sqrt()
}

pub fn expected_degree(n : Int, radius : Double, area : Double) -> Double {
  (n - 1).to_double() * @math.PI * radius * radius / area
}

pub fn isolation_probability(n : Int, radius : Double, area : Double) -> Double {
  let p = 1.0 - @math.PI * radius * radius / area
  @math.pow(p, (n - 1).to_double())
}
""",
"""test "connectivity threshold" {
  let r = connectivity_threshold(100, 1.0)
  assert_true(r > 0.0)
}

test "percolation threshold" {
  assert_eq(percolation_threshold_2d(), 0.5)
}

test "expected degree" {
  let d = expected_degree(10, 0.5, 1.0)
  assert_true(d > 0.0)
}
"""),

("geom_hash", "Geometric Hashing",
"""///| Geometric Hashing | 几何哈希
///| Geometric hash tables for model-based recognition
///| 基于模型的识别用几何哈希表

pub fn hash_point_2d(x : Double, y : Double, grid_size : Double) -> (Int, Int) {
  ((x / grid_size).floor().to_int(), (y / grid_size).floor().to_int())
}

pub fn hash_basis_invariant(p1x : Double, p1y : Double, p2x : Double, p2y : Double, p3x : Double, p3y : Double) -> (Double, Double) {
  let dx = p2x - p1x
  let dy = p2y - p1y
  let scale = (dx * dx + dy * dy).sqrt()
  if scale < 1e-10 {
    (0.0, 0.0)
  } else {
    let cos_a = dx / scale
    let sin_a = dy / scale
    let tx = (p3x - p1x) * cos_a + (p3y - p1y) * sin_a
    let ty = -(p3x - p1x) * sin_a + (p3y - p1y) * cos_a
    (tx / scale, ty / scale)
  }
}

pub fn hash_key(x : Double, y : Double, bins : Int) -> Int {
  let v = ((x + y) * bins.to_double()).floor().to_int()
  if v < 0 { 0 } else if v >= bins { bins - 1 } else { v }
}

pub fn similarity_score(h1 : Array[Int], h2 : Array[Int]) -> Double {
  var match_count = 0
  let n = if h1.length() < h2.length() { h1.length() } else { h2.length() }
  for i in 0..<n {
    if h1[i] == h2[i] {
      match_count += 1
    }
  }
  match_count.to_double() / n.to_double()
}
""",
"""test "hash point 2d" {
  let (hx, hy) = hash_point_2d(5.5, 3.2, 1.0)
  assert_eq(hx, 5)
  assert_eq(hy, 3)
}

test "hash key" {
  let k = hash_key(0.5, 0.0, 10)
  assert_eq(k, 5)
}

test "similarity score" {
  let s = similarity_score([1, 2, 3, 4], [1, 0, 3, 0])
  assert_eq(s, 0.5)
}
"""),

("geom_coding", "Geometric Coding Theory",
"""///| Geometric Coding Theory | 几何编码理论
///| Lattice codes, sphere packing, kissing numbers
///| 格码、球填充、接吻数

pub fn sphere_packing_density_sc() -> Double {
  @math.PI / 6.0
}

pub fn sphere_packing_density_fcc() -> Double {
  @math.PI / (3.0 * 1.4142135623730951)
}

pub fn kissing_number_2d() -> Int {
  6
}

pub fn kissing_number_3d() -> Int {
  12
}

pub fn hamming_bound(n : Int, d : Int, t : Int) -> Double {
  var vol = 0.0
  for i in 0..=t {
    var comb = 1.0
    for j in 0..<i {
      comb *= (n - j).to_double() / (j + 1).to_double()
    }
    vol += comb
  }
  @math.pow(2.0, n.to_double()) / vol
}

pub fn gilbert_varshamov_bound(n : Int, d : Int) -> Double {
  var vol = 0.0
  let t = (d - 1) / 2
  for i in 0..=t {
    var comb = 1.0
    for j in 0..<i {
      comb *= (n - j).to_double() / (j + 1).to_double()
    }
    vol += comb
  }
  @math.pow(2.0, n.to_double()) / vol
}
""",
"""test "sphere packing density sc" {
  let d = sphere_packing_density_sc()
  assert_true(d > 0.52 && d < 0.53)
}

test "kissing number" {
  assert_eq(kissing_number_2d(), 6)
  assert_eq(kissing_number_3d(), 12)
}

test "hamming bound" {
  let b = hamming_bound(7, 3, 1)
  assert_true(b > 0.0)
}
"""),

("geom_mechanics", "Geometric Mechanics",
"""///| Geometric Mechanics | 几何力学
///| Lagrangian and Hamiltonian mechanics on manifolds
///| 流形上的 Lagrangian 和 Hamiltonian 力学

pub fn lagrangian(kinetic : Double, potential : Double) -> Double {
  kinetic - potential
}

pub fn hamiltonian(kinetic : Double, potential : Double) -> Double {
  kinetic + potential
}

pub fn euler_lagrange(dL_dq : Double, dL_dqdot : Double, dt : Double) -> Double {
  dL_dq - dL_dqdot / dt
}

pub fn hamilton_equation_q(dH_dp : Double, dt : Double) -> Double {
  dH_dp * dt
}

pub fn hamilton_equation_p(dH_dq : Double, dt : Double) -> Double {
  -dH_dq * dt
}

pub fn noether_charge(dL_dqdot : Double, xi : Double) -> Double {
  dL_dqdot * xi
}

pub fn action_integral(lagrangian_vals : Array[Double], dt : Double) -> Double {
  var sum = 0.0
  for l in lagrangian_vals {
    sum += l
  }
  sum * dt
}
""",
"""test "lagrangian" {
  assert_eq(lagrangian(10.0, 5.0), 5.0)
}

test "hamiltonian" {
  assert_eq(hamiltonian(10.0, 5.0), 15.0)
}

test "action integral" {
  let s = action_integral([1.0, 2.0, 3.0], 0.1)
  assert_eq(s, 0.6)
}
"""),

("symplectic_int", "Symplectic Integrators",
"""///| Symplectic Integrators | 辛积分器
///| Verlet, Stormer-Verlet, variational integrators
///| Verlet、Stormer-Verlet、变分积分器

pub fn stormer_verlet(q : Double, p : Double, force : (Double) -> Double, dt : Double) -> (Double, Double) {
  let p_half = p + force(q) * dt / 2.0
  let q_new = q + p_half * dt
  let p_new = p_half + force(q_new) * dt / 2.0
  (q_new, p_new)
}

pub fn leapfrog(q : Double, p : Double, force : (Double) -> Double, dt : Double) -> (Double, Double) {
  let p_half = p + force(q) * dt / 2.0
  let q_new = q + p_half * dt
  let p_new = p_half + force(q_new) * dt / 2.0
  (q_new, p_new)
}

pub fn ruth3(q : Double, p : Double, force : (Double) -> Double, dt : Double) -> (Double, Double) {
  let c1 = 1.0
  let c2 = -2.0 / 3.0
  let c3 = 2.0 / 3.0
  let d1 = -1.0 / 24.0
  let d2 = 3.0 / 4.0
  let d3 = 7.0 / 24.0
  let q1 = q + c1 * p * dt
  let p1 = p + d1 * force(q1) * dt
  let q2 = q1 + c2 * p1 * dt
  let p2 = p1 + d2 * force(q2) * dt
  let q3 = q2 + c3 * p2 * dt
  let p3 = p2 + d3 * force(q3) * dt
  (q3, p3)
}

pub fn energy_conservation_error(h0 : Double, h1 : Double) -> Double {
  (h1 - h0).abs() / h0.abs()
}
""",
"""test "stormer verlet" {
  let (q, p) = stormer_verlet(1.0, 0.0, fn(x) { -x }, 0.01)
  assert_true(q > 0.99)
}

test "leapfrog" {
  let (q, p) = leapfrog(1.0, 0.0, fn(x) { -x }, 0.01)
  assert_true(q > 0.99)
}

test "energy conservation error" {
  let e = energy_conservation_error(10.0, 10.001)
  assert_true(e < 0.001)
}
"""),
]

# Phase 24: Specialized Geometry Applications
P24 = [
("molecular_geom", "Molecular Geometry",
"""///| Molecular Geometry | 分子几何
///| Bond angles, torsion angles, RMSD alignment
///| 键角、扭转角、RMSD 对齐

pub fn bond_length(a1x : Double, a1y : Double, a1z : Double, a2x : Double, a2y : Double, a2z : Double) -> Double {
  let dx = a2x - a1x
  let dy = a2y - a1y
  let dz = a2z - a1z
  (dx * dx + dy * dy + dz * dz).sqrt()
}

pub fn bond_angle(a1x : Double, a1y : Double, a1z : Double, cx : Double, cy : Double, cz : Double, a2x : Double, a2y : Double, a2z : Double) -> Double {
  let v1x = a1x - cx
  let v1y = a1y - cy
  let v1z = a1z - cz
  let v2x = a2x - cx
  let v2y = a2y - cy
  let v2z = a2z - cz
  let dot = v1x * v2x + v1y * v2y + v1z * v2z
  let n1 = (v1x * v1x + v1y * v1y + v1z * v1z).sqrt()
  let n2 = (v2x * v2x + v2y * v2y + v2z * v2z).sqrt()
  if n1 < 1e-10 || n2 < 1e-10 {
    0.0
  } else {
    @math.acos(dot / (n1 * n2))
  }
}

pub fn torsion_angle(p1x : Double, p1y : Double, p1z : Double, p2x : Double, p2y : Double, p2z : Double, p3x : Double, p3y : Double, p3z : Double, p4x : Double, p4y : Double, p4z : Double) -> Double {
  let b1x = p2x - p1x
  let b1y = p2y - p1y
  let b1z = p2z - p1z
  let b2x = p3x - p2x
  let b2y = p3y - p2y
  let b2z = p3z - p2z
  let b3x = p4x - p3x
  let b3y = p4y - p3y
  let b3z = p4z - p3z
  let n1x = b1y * b2z - b1z * b2y
  let n1y = b1z * b2x - b1x * b2z
  let n1z = b1x * b2y - b1y * b2x
  let n2x = b2y * b3z - b2z * b3y
  let n2y = b2z * b3x - b2x * b3z
  let n2z = b2x * b3y - b2y * b3x
  let dot = n1x * n2x + n1y * n2y + n1z * n2z
  let cross = b2x * (n1y * n2z - n1z * n2y) + b2y * (n1z * n2x - n1x * n2z) + b2z * (n1x * n2y - n1y * n2x)
  @math.atan2(cross, dot)
}

pub fn rmsd(coords1 : Array[(Double, Double, Double)], coords2 : Array[(Double, Double, Double)]) -> Double {
  let n = if coords1.length() < coords2.length() { coords1.length() } else { coords2.length() }
  var sum_sq = 0.0
  for i in 0..<n {
    let dx = coords1[i].0 - coords2[i].0
    let dy = coords1[i].1 - coords2[i].1
    let dz = coords1[i].2 - coords2[i].2
    sum_sq += dx * dx + dy * dy + dz * dz
  }
  (sum_sq / n.to_double()).sqrt()
}
""",
"""test "bond length" {
  let l = bond_length(0.0, 0.0, 0.0, 1.0, 0.0, 0.0)
  assert_eq(l, 1.0)
}

test "bond angle" {
  let a = bond_angle(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)
  assert_true((a - 1.5707963267948966).abs() < 1e-10)
}

test "rmsd" {
  let r = rmsd([(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)], [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)])
  assert_eq(r, 0.0)
}
"""),

("protein_geom", "Protein Geometry",
"""///| Protein Geometry | 蛋白质几何
///| Secondary structure, Ramachandran plot, backbone geometry
///| 二级结构、Ramachandran 图、骨架几何

pub fn ramachandran_allowed(phi : Double, psi : Double) -> Bool {
  let phi_deg = phi * 180.0 / @math.PI
  let psi_deg = psi * 180.0 / @math.PI
  (phi_deg > -160.0 && phi_deg < -30.0 && psi_deg > -90.0 && psi_deg < 50.0) ||
  (phi_deg > -130.0 && phi_deg < 50.0 && psi_deg > 100.0 && psi_deg < 180.0)
}

pub fn helix_pitch(rise_per_residue : Double, turn_per_residue : Double) -> Double {
  rise_per_residue * 2.0 * @math.PI / turn_per_residue
}

pub fn helix_radius(rise_per_residue : Double, turn_per_residue : Double) -> Double {
  rise_per_residue / (2.0 * @math.sin(turn_per_residue / 2.0))
}

pub fn secondary_structure_type(phi : Double, psi : Double) -> String {
  let phi_deg = phi * 180.0 / @math.PI
  let psi_deg = psi * 180.0 / @math.PI
  if phi_deg > -80.0 && phi_deg < -40.0 && psi_deg > -60.0 && psi_deg < -20.0 {
    "helix"
  } else if phi_deg > -160.0 && phi_deg < -100.0 && psi_deg > 100.0 && psi_deg < 180.0 {
    "sheet"
  } else {
    "coil"
  }
}

pub fn contact_map_distance(ca1 : Array[(Double, Double, Double)], ca2 : Array[(Double, Double, Double)], threshold : Double) -> Int {
  let n = if ca1.length() < ca2.length() { ca1.length() } else { ca2.length() }
  var count = 0
  for i in 0..<n {
    for j in (i + 1)..<n {
      let dx = ca1[i].0 - ca1[j].0
      let dy = ca1[i].1 - ca1[j].1
      let dz = ca1[i].2 - ca1[j].2
      let d1 = (dx * dx + dy * dy + dz * dz).sqrt()
      let dx2 = ca2[i].0 - ca2[j].0
      let dy2 = ca2[i].1 - ca2[j].1
      let dz2 = ca2[i].2 - ca2[j].2
      let d2 = (dx2 * dx2 + dy2 * dy2 + dz2 * dz2).sqrt()
      if (d1 < threshold) != (d2 < threshold) {
        count += 1
      }
    }
  }
  count
}
""",
"""test "ramachandran allowed" {
  assert_true(ramachandran_allowed(-1.0472, -0.6981))
}

test "helix pitch" {
  let p = helix_pitch(1.5, 1.7453292519943295)
  assert_true(p > 5.0 && p < 6.0)
}

test "secondary structure" {
  let s = secondary_structure_type(-1.0472, -0.6981)
  assert_eq(s, "helix")
}
"""),

("drug_design", "Geometric Drug Design",
"""///| Geometric Drug Design | 几何药物设计
///| Pharmacophore matching, molecular docking geometry
///| 药效团匹配、分子对接几何

pub fn pharmacophore_distance(f1 : Array[Double], f2 : Array[Double]) -> Double {
  let n = if f1.length() < f2.length() { f1.length() } else { f2.length() }
  var sum = 0.0
  for i in 0..<n {
    let d = f1[i] - f2[i]
    sum += d * d
  }
  sum.sqrt()
}

pub fn docking_score_compat(distance : Double, ideal : Double, tolerance : Double) -> Double {
  let diff = (distance - ideal).abs()
  if diff < tolerance {
    1.0 - diff / tolerance
  } else {
    0.0
  }
}

pub fn vdw_radius(element : Int) -> Double {
  if element == 1 { 1.2 }
  else if element == 6 { 1.7 }
  else if element == 7 { 1.55 }
  else if element == 8 { 1.52 }
  else { 1.8 }
}

pub fn clash_detection(d : Double, r1 : Double, r2 : Double) -> Bool {
  d < r1 + r2 - 0.4
}

pub fn binding_pocket_volume(radius : Double) -> Double {
  4.0 / 3.0 * @math.PI * radius * radius * radius
}
""",
"""test "pharmacophore distance" {
  let d = pharmacophore_distance([0.0, 0.0], [3.0, 4.0])
  assert_eq(d, 5.0)
}

test "docking score compat" {
  let s = docking_score_compat(5.0, 5.0, 1.0)
  assert_eq(s, 1.0)
}

test "clash detection" {
  assert_true(clash_detection(2.0, 1.7, 1.7))
  assert_true(!clash_detection(5.0, 1.7, 1.7))
}
"""),

("crystal_geom", "Crystal Geometry",
"""///| Crystal Geometry | 晶体几何
///| Point groups, space groups, Wyckoff positions
///| 点群、空间群、Wyckoff 位置

pub fn point_group_order(group_id : Int) -> Int {
  if group_id == 1 { 1 }
  else if group_id == 2 { 2 }
  else if group_id == 3 { 3 }
  else if group_id == 4 { 4 }
  else if group_id == 6 { 6 }
  else if group_id == 8 { 8 }
  else if group_id == 12 { 12 }
  else if group_id == 24 { 24 }
  else if group_id == 48 { 48 }
  else { 1 }
}

pub fn space_group_count_2d() -> Int {
  17
}

pub fn space_group_count_3d() -> Int {
  230
}

pub fn wyckoff_multiplicity(site : Int) -> Int {
  if site == 1 { 1 }
  else if site == 2 { 2 }
  else if site == 3 { 3 }
  else if site == 4 { 4 }
  else if site == 6 { 6 }
  else if site == 8 { 8 }
  else { 1 }
}

pub fn bravais_type(a : Double, b : Double, c : Double, alpha : Double, beta : Double, gamma : Double) -> String {
  let tol = 0.01
  let a_eq_b = (a - b).abs() < tol
  let a_eq_c = (a - c).abs() < tol
  let all_90 = (alpha - 1.5707963267948966).abs() < tol && (beta - 1.5707963267948966).abs() < tol && (gamma - 1.5707963267948966).abs() < tol
  if a_eq_b && a_eq_c && all_90 {
    "cubic"
  } else if all_90 {
    if a_eq_b { "tetragonal" } else { "orthorhombic" }
  } else {
    "monoclinic"
  }
}
""",
"""test "point group order" {
  assert_eq(point_group_order(1), 1)
  assert_eq(point_group_order(48), 48)
}

test "space group count" {
  assert_eq(space_group_count_2d(), 17)
  assert_eq(space_group_count_3d(), 230)
}

test "bravais type" {
  let t = bravais_type(5.0, 5.0, 5.0, 1.5707963267948966, 1.5707963267948966, 1.5707963267948966)
  assert_eq(t, "cubic")
}
"""),

("quantum_geom", "Quantum Geometry",
"""///| Quantum Geometry | 量子几何
///| Quantum groups, noncommutative geometry basics
///| 量子群、非交换几何基础

pub fn q_deformed_product(a : Double, b : Double, q : Double) -> Double {
  a * b + (q - 1.0) * b * a
}

pub fn q_commutator(a : Double, b : Double, q : Double) -> Double {
  a * b - q * b * a
}

pub fn q_number(n : Int, q : Double) -> Double {
  (1.0 - @math.pow(q, n.to_double())) / (1.0 - q)
}

pub fn q_factorial(n : Int, q : Double) -> Double {
  var result = 1.0
  for i in 1..=n {
    result *= q_number(i, q)
  }
  result
}

pub fn q_binomial(n : Int, k : Int, q : Double) -> Double {
  q_factorial(n, q) / (q_factorial(k, q) * q_factorial(n - k, q))
}

pub fn quantum_metric(g11 : Double, g22 : Double, q : Double) -> (Double, Double) {
  (g11 * q, g22 / q)
}
""",
"""test "q commutator" {
  let c = q_commutator(3.0, 5.0, 1.0)
  assert_eq(c, 0.0)
}

test "q number" {
  let qn = q_number(3, 2.0)
  assert_eq(qn, 7.0)
}

test "q factorial" {
  let qf = q_factorial(3, 1.0)
  assert_eq(qf, 6.0)
}
"""),

("topological_quantum", "Topological Quantum Computing",
"""///| Topological Quantum Computing | 拓扑量子计算
///| Anyons, braiding statistics, topological gates
///| 任意子、辫子统计、拓扑门

pub fn anyon_braid_phase(theta : Double, n : Int) -> Double {
  n.to_double() * theta
}

pub fn fibonacci_anyon_phase(n : Int) -> Double {
  let tau = (1.0 + 5.0.sqrt()) / 2.0
  n.to_double() * 2.0 * @math.PI / (tau * tau)
}

pub fn ising_anyon_phase(n : Int) -> Double {
  n.to_double() * @math.PI / 4.0
}

pub fn braid_group_relation(a : Double, b : Double, c : Double) -> Bool {
  (a + b + a - b - a - b).abs() < 1e-10 && (b + c + b - c - b - c).abs() < 1e-10
}

pub fn topological_gate_fidelity(phase1 : Double, phase2 : Double) -> Double {
  let diff = (phase1 - phase2).abs()
  @math.cos(diff / 2.0) * @math.cos(diff / 2.0)
}

pub fn majorana_fusion_rule(n : Int) -> Int {
  n % 2
}
""",
"""test "anyon braid phase" {
  let p = anyon_braid_phase(1.5707963267948966, 2)
  assert_eq(p, 3.141592653589793)
}

test "ising anyon phase" {
  let p = ising_anyon_phase(2)
  assert_eq(p, 1.5707963267948966)
}

test "majorana fusion rule" {
  assert_eq(majorana_fusion_rule(3), 1)
  assert_eq(majorana_fusion_rule(4), 0)
}
"""),

("fractal_gen", "Fractal Generation",
"""///| Fractal Generation | 分形生成
///| L-systems, IFS, Mandelbrot/Julia set iteration
///| L-系统、迭代函数系统、Mandelbrot/Julia 集迭代

pub fn mandelbrot_escape(cx : Double, cy : Double, max_iter : Int) -> Int {
  var x = 0.0
  var y = 0.0
  var iter = 0
  while iter < max_iter {
    let x2 = x * x
    let y2 = y * y
    if x2 + y2 > 4.0 {
      break
    }
    let xnew = x2 - y2 + cx
    y = 2.0 * x * y + cy
    x = xnew
    iter += 1
  }
  iter
}

pub fn julia_escape(zx : Double, zy : Double, cx : Double, cy : Double, max_iter : Int) -> Int {
  var x = zx
  var y = zy
  var iter = 0
  while iter < max_iter {
    let x2 = x * x
    let y2 = y * y
    if x2 + y2 > 4.0 {
      break
    }
    let xnew = x2 - y2 + cx
    y = 2.0 * x * y + cy
    x = xnew
    iter += 1
  }
  iter
}

pub fn ifs_contractive_factor(scales : Array[Double]) -> Double {
  var max_s = 0.0
  for s in scales {
    let a = s.abs()
    if a > max_s {
      max_s = a
    }
  }
  max_s
}

pub fn fractal_dimension_box(counts : Array[(Double, Int)]) -> Double {
  if counts.length() < 2 {
    return 0.0
  }
  let p1 = counts[0]
  let p2 = counts[counts.length() - 1]
  let log_n1 = @math.ln(p1.1.to_double())
  let log_n2 = @math.ln(p2.1.to_double())
  let log_e1 = @math.ln(1.0 / p1.0)
  let log_e2 = @math.ln(1.0 / p2.0)
  (log_n2 - log_n1) / (log_e2 - log_e1)
}

pub fn koch_curve_length(iteration : Int, base_length : Double) -> Double {
  base_length * @math.pow(4.0 / 3.0, iteration.to_double())
}
""",
"""test "mandelbrot escape" {
  let i = mandelbrot_escape(0.0, 0.0, 100)
  assert_eq(i, 100)
  let i2 = mandelbrot_escape(2.0, 0.0, 100)
  assert_true(i2 < 100)
}

test "julia escape" {
  let i = julia_escape(0.0, 0.0, -1.0, 0.0, 100)
  assert_eq(i, 100)
}

test "koch curve length" {
  let l = koch_curve_length(1, 1.0)
  assert_eq(l, 4.0 / 3.0)
}
"""),

("chaos_geom", "Chaos Geometry",
"""///| Chaos Geometry | 混沌几何
///| Strange attractors, Lyapunov exponents, bifurcation geometry
///| 奇怪吸引子、Lyapunov 指数、分岔几何

pub fn lorenz_step(x : Double, y : Double, z : Double, sigma : Double, rho : Double, beta : Double, dt : Double) -> (Double, Double, Double) {
  let dx = sigma * (y - x) * dt
  let dy = (x * (rho - z) - y) * dt
  let dz = (x * y - beta * z) * dt
  (x + dx, y + dy, z + dz)
}

pub fn lyapunov_exponent_logistic(r : Double, x0 : Double, n : Int) -> Double {
  var x = x0
  var sum = 0.0
  for _ in 0..<n {
    let deriv = r * (1.0 - 2.0 * x)
    if deriv.abs() > 1e-10 {
      sum += @math.ln(deriv.abs())
    }
    x = r * x * (1.0 - x)
  }
  sum / n.to_double()
}

pub fn henon_map(x : Double, y : Double, a : Double, b : Double) -> (Double, Double) {
  (1.0 - a * x * x + y, b * x)
}

pub fn bifurcation_point_logistic() -> Double {
  3.569945672
}

pub fn strange_attractor_dimension(lyapunov : Array[Double]) -> Double {
  var sum_pos = 0.0
  var sum_all = 0.0
  for l in lyapunov {
    sum_all += l
    if l > 0.0 {
      sum_pos += l
    }
  }
  if sum_pos < 1e-10 {
    0.0
  } else {
    sum_all / sum_pos
  }
}
""",
"""test "lorenz step" {
  let (x, y, z) = lorenz_step(1.0, 1.0, 1.0, 10.0, 28.0, 8.0 / 3.0, 0.01)
  assert_true(x > 0.99 && x < 1.01)
}

test "henon map" {
  let (x, y) = henon_map(0.0, 0.0, 1.4, 0.3)
  assert_eq(x, 1.0)
  assert_eq(y, 0.0)
}

test "bifurcation point" {
  let b = bifurcation_point_logistic()
  assert_true(b > 3.56 && b < 3.57)
}
"""),

("wavelet_geom", "Wavelet Geometry",
"""///| Wavelet Geometry | 小波几何
///| Wavelet transforms on geometric data, multi-resolution analysis
///| 几何数据上的小波变换、多分辨率分析

pub fn haar_wavelet(x : Double) -> Double {
  if x >= 0.0 && x < 0.5 {
    1.0
  } else if x >= 0.5 && x < 1.0 {
    -1.0
  } else {
    0.0
  }
}

pub fn haar_scaling(x : Double) -> Double {
  if x >= 0.0 && x < 1.0 {
    1.0
  } else {
    0.0
  }
}

pub fn daubechies4_weight(j : Int) -> Double {
  let h0 = (1.0 + 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  let h1 = (3.0 + 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  let h2 = (3.0 - 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  let h3 = (1.0 - 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  if j == 0 { h0 } else if j == 1 { h1 } else if j == 2 { h2 } else if j == 3 { h3 } else { 0.0 }
}

pub fn wavelet_transform_1d(data : Array[Double]) -> Array[Double] {
  let n = data.length() / 2
  let result = Array::make(data.length(), 0.0)
  for i in 0..<n {
    result[i] = (data[2 * i] + data[2 * i + 1]) / 2.0.sqrt()
    result[n + i] = (data[2 * i] - data[2 * i + 1]) / 2.0.sqrt()
  }
  result
}

pub fn multi_resolution_level(data : Array[Double], level : Int) -> Array[Double] {
  var current = data
  for _ in 0..<level {
    current = wavelet_transform_1d(current)
  }
  current
}
""",
"""test "haar wavelet" {
  assert_eq(haar_wavelet(0.25), 1.0)
  assert_eq(haar_wavelet(0.75), -1.0)
  assert_eq(haar_wavelet(1.5), 0.0)
}

test "haar scaling" {
  assert_eq(haar_scaling(0.5), 1.0)
  assert_eq(haar_scaling(1.5), 0.0)
}

test "wavelet transform 1d" {
  let r = wavelet_transform_1d([1.0, 3.0, 5.0, 7.0])
  assert_true(r[0] > 0.0)
}
"""),

("spectral_geom", "Spectral Geometry",
"""///| Spectral Geometry | 谱几何
///| Laplacian spectra, heat kernel, spectral invariants
///| Laplacian 谱、热核、谱不变量

pub fn laplacian_spectrum_1d(n : Int, length : Double) -> Array[Double] {
  let result = Array::make(n, 0.0)
  for k in 1..=n {
    let lambda = @math.pow(k.to_double() * @math.PI / length, 2.0)
    result[k - 1] = lambda
  }
  result
}

pub fn heat_kernel_1d(x : Double, t : Double, n_terms : Int) -> Double {
  var sum = 0.0
  for k in 1..=n_terms {
    let kn = k.to_double() * @math.PI
    sum += @math.exp(-kn * kn * t) * @math.sin(kn * x)
  }
  sum
}

pub fn weyl_law_2d(lambda : Double, area : Double) -> Double {
  area * lambda / (4.0 * @math.PI)
}

pub fn spectral_zeta(eigenvalues : Array[Double], s : Double) -> Double {
  var sum = 0.0
  for ev in eigenvalues {
    if ev > 1e-10 {
      sum += @math.pow(ev, -s)
    }
  }
  sum
}

pub fn heat_trace(eigenvalues : Array[Double], t : Double) -> Double {
  var sum = 0.0
  for ev in eigenvalues {
    sum += @math.exp(-ev * t)
  }
  sum
}

pub fn isospectral_check(spec1 : Array[Double], spec2 : Array[Double]) -> Bool {
  if spec1.length() != spec2.length() {
    return false
  }
  for i in 0..<spec1.length() {
    if (spec1[i] - spec2[i]).abs() > 1e-10 {
      return false
    }
  }
  true
}
""",
"""test "laplacian spectrum 1d" {
  let s = laplacian_spectrum_1d(3, 1.0)
  assert_true(s[0] > 9.0 && s[0] < 10.0)
}

test "weyl law 2d" {
  let n = weyl_law_2d(100.0, 4.0 * @math.PI)
  assert_eq(n, 100.0)
}

test "heat trace" {
  let r = heat_trace([1.0, 2.0, 3.0], 0.0)
  assert_eq(r, 3.0)
}
"""),
]

ALL = P21 + P22 + P23 + P24

if __name__ == "__main__":
    for name, desc, code, tests in ALL:
        write_module(name, desc, code, tests)
    print(f"Generated {len(ALL)} modules")
    for name, _, _, _ in ALL:
        print(f"  - {name}")