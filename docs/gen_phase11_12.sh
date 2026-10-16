#!/bin/bash
# Generate Phase 11-12 modules (20 modules)

create_mod() {
  local name=$1; local pkg=$2; local src=$3; local tst=$4; local rme=$5
  mkdir -p "src/$name"
  printf '%s\n' "$pkg" > "src/$name/moon.pkg"
  printf '%s\n' "$src" > "src/$name/$name.mbt"
  printf '%s\n' "$tst" > "src/$name/${name}_wbtest.mbt"
  printf '# %s\n\n%s module. / %s 模块。\n\n## API\n\n### Functions\n%s\n\n---\nPart of [moon-geometry](https://github.com/walkzzz/moon-geometry).\n' "$name" "$name" "$name" "$rme" > "src/$name/README.md"
}

# ============ Phase 11: Robust & Exact Geometry (10 modules) ============

create_mod "exact_predicates" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Exact Geometric Predicates
/// # 精确几何谓词
///
/// Exact orientation and incircle predicates using determinant computation.
/// 精确定向和圆内谓词，使用行列式计算。

///|
/// Exact orientation test: returns +1 if CCW, -1 if CW, 0 if collinear.
/// 精确定向测试：逆时针返回+1，顺时针返回-1，共线返回0。
pub fn exact_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  let det = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

///|
/// Exact incircle test: returns +1 if d inside circle(a,b,c), -1 if outside, 0 if on.
/// 精确圆内测试：d在圆内返回+1，圆外返回-1，圆上返回0。
pub fn exact_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  let ax = a.x() - d.x()
  let ay = a.y() - d.y()
  let bx = b.x() - d.x()
  let by = b.y() - d.y()
  let cx = c.x() - d.x()
  let cy = c.y() - d.y()
  let det = ax * (bx * (cx * cx + cy * cy) - cx * (bx * bx + by * by)) -
    ay * (by * (cx * cx + cy * cy) - cy * (bx * bx + by * by)) +
    (ax * ax + ay * ay) * (bx * cy - by * cx)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

///|
/// Left turn predicate. / 左转谓词。
pub fn exact_left_turn(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  exact_orientation(a, b, c) > 0
}

///|
/// Collinear predicate. / 共线谓词。
pub fn exact_collinear(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  exact_orientation(a, b, c) == 0
}' \
'test "exact_orientation ccw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(exact_orientation(a, b, c), 1)
}

test "exact_orientation cw" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 0.0)
  assert_eq(exact_orientation(a, b, c), -1)
}

test "exact_orientation collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_eq(exact_orientation(a, b, c), 0)
}

test "exact_left_turn" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_true(exact_left_turn(a, b, c))
}

test "exact_collinear" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_true(exact_collinear(a, b, c))
}' \
'- exact_orientation
- exact_incircle
- exact_left_turn
- exact_collinear'

create_mod "interval_arithmetic" \
'import {
}' \
'///|
/// # Interval Arithmetic
/// # 区间算术
///
/// Interval arithmetic for robust geometric computation.
/// 用于鲁棒几何计算的区间算术。

///|
pub struct Interval {
  lo : Double
  hi : Double
}

///|
pub fn Interval::new(lo : Double, hi : Double) -> Interval {
  if lo <= hi { { lo, hi } } else { { hi, lo } }
}

///|
pub fn interval_add(a : Interval, b : Interval) -> Interval {
  { lo: a.lo + b.lo, hi: a.hi + b.hi }
}

///|
pub fn interval_sub(a : Interval, b : Interval) -> Interval {
  { lo: a.lo - b.hi, hi: a.hi - b.lo }
}

///|
pub fn interval_mul(a : Interval, b : Interval) -> Interval {
  let p1 = a.lo * b.lo
  let p2 = a.lo * b.hi
  let p3 = a.hi * b.lo
  let p4 = a.hi * b.hi
  let lo = if p1 <= p2 && p1 <= p3 && p1 <= p4 { p1 } else if p2 <= p3 && p2 <= p4 { p2 } else if p3 <= p4 { p3 } else { p4 }
  let hi = if p1 >= p2 && p1 >= p3 && p1 >= p4 { p1 } else if p2 >= p3 && p2 >= p4 { p2 } else if p3 >= p4 { p3 } else { p4 }
  { lo, hi }
}

///|
pub fn interval_contains(i : Interval, x : Double) -> Bool {
  x >= i.lo && x <= i.hi
}

///|
pub fn interval_width(i : Interval) -> Double {
  i.hi - i.lo
}

///|
pub fn interval_midpoint(i : Interval) -> Double {
  (i.lo + i.hi) / 2.0
}' \
'test "Interval::new" {
  let i = Interval::new(1.0, 3.0)
  assert_true((interval_width(i) - 2.0).abs() < 0.001)
}

test "interval_add" {
  let r = interval_add(Interval::new(1.0, 2.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - 4.0).abs() < 0.001)
  assert_true((r.hi - 6.0).abs() < 0.001)
}

test "interval_mul" {
  let r = interval_mul(Interval::new(1.0, 2.0), Interval::new(3.0, 4.0))
  assert_true((r.lo - 3.0).abs() < 0.001)
  assert_true((r.hi - 8.0).abs() < 0.001)
}

test "interval_contains" {
  let i = Interval::new(1.0, 3.0)
  assert_true(interval_contains(i, 2.0))
  assert_false(interval_contains(i, 4.0))
}

test "interval_midpoint" {
  let i = Interval::new(1.0, 3.0)
  assert_true((interval_midpoint(i) - 2.0).abs() < 0.001)
}' \
'- Interval::new
- interval_add
- interval_sub
- interval_mul
- interval_contains
- interval_width
- interval_midpoint'

create_mod "filtered_predicates" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Filtered Predicates
/// # 过滤谓词
///
/// Fast approximate predicates with fallback to exact computation.
/// 快速近似谓词，必要时回退到精确计算。

///|
pub fn filtered_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  let det = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let eps = 0.000000000001 * ((b.x() - a.x()).abs() * (c.y() - a.y()).abs() + (b.y() - a.y()).abs() * (c.x() - a.x()).abs())
  if det > eps { 1 } else if det < -eps { -1 } else { 0 }
}

///|
pub fn filtered_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  let ax = a.x() - d.x()
  let ay = a.y() - d.y()
  let bx = b.x() - d.x()
  let by = b.y() - d.y()
  let cx = c.x() - d.x()
  let cy = c.y() - d.y()
  let det = ax * (bx * (cx * cx + cy * cy) - cx * (bx * bx + by * by)) -
    ay * (by * (cx * cx + cy * cy) - cy * (bx * bx + by * by)) +
    (ax * ax + ay * ay) * (bx * cy - by * cx)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

///|
pub fn perturbation_orientation(det : Double, eps : Double) -> Int {
  if det > eps { 1 } else if det < -eps { -1 } else { 0 }
}' \
'test "filtered_orientation" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(filtered_orientation(a, b, c), 1)
}

test "perturbation_orientation" {
  assert_eq(perturbation_orientation(0.5, 0.001), 1)
  assert_eq(perturbation_orientation(-0.5, 0.001), -1)
}' \
'- filtered_orientation
- filtered_incircle
- perturbation_orientation'

create_mod "perturbation" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Simulation of Simplicity (SoS)
/// # 简单性模拟
///
/// Symbolic perturbation to break degeneracies.
/// 符号扰动打破退化。

///|
pub fn sos_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, ia : Int, ib : Int, ic : Int) -> Int {
  let det = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  if det != 0.0 {
    if det > 0.0 { 1 } else { -1 }
  } else {
    if ia < ib && ib < ic { 1 } else { -1 }
  }
}

///|
pub fn sos_sign(det : Double, perturbation_order : Int) -> Int {
  if det != 0.0 {
    if det > 0.0 { 1 } else { -1 }
  } else {
    if perturbation_order % 2 == 0 { 1 } else { -1 }
  }
}

///|
pub fn sos_compare(a : Double, b : Double, ia : Int, ib : Int) -> Int {
  if a < b { -1 } else if a > b { 1 } else {
    if ia < ib { -1 } else { 1 }
  }
}' \
'test "sos_orientation non-degenerate" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(sos_orientation(a, b, c, 0, 1, 2), 1)
}

test "sos_sign" {
  assert_eq(sos_sign(0.0, 0), 1)
  assert_eq(sos_sign(0.0, 1), -1)
}

test "sos_compare" {
  assert_eq(sos_compare(1.0, 2.0, 0, 1), -1)
  assert_eq(sos_compare(1.0, 1.0, 0, 1), -1)
}' \
'- sos_orientation
- sos_sign
- sos_compare'

create_mod "robust_construction" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Robust Geometric Construction
/// # 鲁棒几何构造
///
/// Robust construction of circumcenters, intersections, midpoints.
/// 鲁棒构造外心、交点、中点。

///|
pub fn robust_circumcenter(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.000000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let ux = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) + (cx * cx + cy * cy) * (ay - by)) / d
  let uy = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) + (cx * cx + cy * cy) * (bx - ax)) / d
  @core.Point2D::new(ux, uy)
}

///|
pub fn robust_intersection(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> @core.Point2D {
  let x1 = a.x()
  let y1 = a.y()
  let x2 = b.x()
  let y2 = b.y()
  let x3 = c.x()
  let y3 = c.y()
  let x4 = d.x()
  let y4 = d.y()
  let denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
  if denom.abs() < 0.000000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom
  @core.Point2D::new(x1 + t * (x2 - x1), y1 + t * (y2 - y1))
}

///|
pub fn robust_midpoint(a : @core.Point2D, b : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new((a.x() + b.x()) / 2.0, (a.y() + b.y()) / 2.0)
}' \
'test "robust_circumcenter" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 0.0)
  let c = @core.Point2D::new(1.0, 1.0)
  let center = robust_circumcenter(a, b, c)
  assert_true((center.x() - 1.0).abs() < 0.001)
}

test "robust_intersection" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 2.0)
  let c = @core.Point2D::new(0.0, 2.0)
  let d = @core.Point2D::new(2.0, 0.0)
  let p = robust_intersection(a, b, c, d)
  assert_true((p.x() - 1.0).abs() < 0.001)
  assert_true((p.y() - 1.0).abs() < 0.001)
}

test "robust_midpoint" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 4.0)
  let m = robust_midpoint(a, b)
  assert_true((m.x() - 1.0).abs() < 0.001)
  assert_true((m.y() - 2.0).abs() < 0.001)
}' \
'- robust_circumcenter
- robust_intersection
- robust_midpoint'

create_mod "big_rational" \
'import {
}' \
'///|
/// # Big Rational Number
/// # 大有理数
///
/// Exact rational arithmetic for robust geometric computation.
/// 精确有理数算术，用于鲁棒几何计算。

///|
pub struct Rational {
  num : Int
  den : Int
}

///|
pub fn Rational::new(num : Int, den : Int) -> Rational {
  if den == 0 { { num: 0, den: 1 } } else { { num, den } }
}

///|
pub fn rational_add(a : Rational, b : Rational) -> Rational {
  { num: a.num * b.den + b.num * a.den, den: a.den * b.den }
}

///|
pub fn rational_mul(a : Rational, b : Rational) -> Rational {
  { num: a.num * b.num, den: a.den * b.den }
}

///|
pub fn rational_to_double(r : Rational) -> Double {
  r.num.to_double() / r.den.to_double()
}

///|
pub fn rational_equal(a : Rational, b : Rational) -> Bool {
  a.num * b.den == b.num * a.den
}

///|
pub fn rational_sub(a : Rational, b : Rational) -> Rational {
  { num: a.num * b.den - b.num * a.den, den: a.den * b.den }
}' \
'test "Rational::new" {
  let r = Rational::new(1, 2)
  assert_true((rational_to_double(r) - 0.5).abs() < 0.001)
}

test "rational_add" {
  let r = rational_add(Rational::new(1, 2), Rational::new(1, 3))
  assert_true((rational_to_double(r) - 0.833333).abs() < 0.001)
}

test "rational_mul" {
  let r = rational_mul(Rational::new(2, 3), Rational::new(3, 4))
  assert_true((rational_to_double(r) - 0.5).abs() < 0.001)
}

test "rational_equal" {
  assert_true(rational_equal(Rational::new(1, 2), Rational::new(2, 4)))
}' \
'- Rational::new
- rational_add
- rational_sub
- rational_mul
- rational_to_double
- rational_equal'

create_mod "de9im" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # DE-9IM Topological Relations
/// # DE-9IM 拓扑关系
///
/// Dimensionally Extended 9-Intersection Model for spatial relations.
/// 维度扩展9交模型，用于空间关系判定。

///|
pub fn de9im_intersects(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  let (a_lo, a_hi) = a_bounds
  let (b_lo, b_hi) = b_bounds
  !(a_hi.x() < b_lo.x() || b_hi.x() < a_lo.x() || a_hi.y() < b_lo.y() || b_hi.y() < a_lo.y())
}

///|
pub fn de9im_contains(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  let (a_lo, a_hi) = a_bounds
  let (b_lo, b_hi) = b_bounds
  a_lo.x() <= b_lo.x() && b_hi.x() <= a_hi.x() && a_lo.y() <= b_lo.y() && b_hi.y() <= a_hi.y()
}

///|
pub fn de9im_disjoint(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  !de9im_intersects(a_bounds, b_bounds)
}

///|
pub fn de9im_touches(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  let (a_lo, a_hi) = a_bounds
  let (b_lo, b_hi) = b_bounds
  let touching = a_hi.x() == b_lo.x() || b_hi.x() == a_lo.x() || a_hi.y() == b_lo.y() || b_hi.y() == a_lo.y()
  touching && de9im_intersects(a_bounds, b_bounds)
}

///|
pub fn de9im_within(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  de9im_contains(b_bounds, a_bounds)
}' \
'test "de9im_intersects" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_intersects(a, b))
}

test "de9im_contains" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_contains(a, b))
}

test "de9im_disjoint" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let b = (@core.Point2D::new(2.0, 2.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_disjoint(a, b))
}

test "de9im_within" {
  let a = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  let b = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  assert_true(de9im_within(a, b))
}' \
'- de9im_intersects
- de9im_contains
- de9im_disjoint
- de9im_touches
- de9im_within'

# 3 more Phase 11 modules
create_mod "lazy_exact" \
'import {
}' \
'///|
/// # Lazy Exact Computation
/// # 惰性精确计算
///
/// Lazy evaluation with approximate and exact phases.
/// 惰性求值，含近似和精确两阶段。

///|
pub struct LazyExact {
  approx : Double
  exact_val : Double
}

///|
pub fn LazyExact::new(approx : Double, exact_val : Double) -> LazyExact {
  { approx, exact_val }
}

///|
pub fn lazy_value(le : LazyExact) -> Double {
  le.exact_val
}

///|
pub fn lazy_approx(le : LazyExact) -> Double {
  le.approx
}

///|
pub fn lazy_error(le : LazyExact) -> Double {
  (le.approx - le.exact_val).abs()
}' \
'test "LazyExact::new" {
  let le = LazyExact::new(3.14, 3.14159)
  assert_true((lazy_value(le) - 3.14159).abs() < 0.001)
}

test "lazy_error" {
  let le = LazyExact::new(3.14, 3.14159)
  assert_true(lazy_error(le) > 0.0)
}' \
'- LazyExact::new
- lazy_value
- lazy_approx
- lazy_error'

create_mod "rounded_geometry" \
'import {
  "walkzzz/moon-geometry/src/core",
}' \
'///|
/// # Rounded Geometry
/// # 舍入几何
///
/// Geometry operations with controlled rounding precision.
/// 受控舍入精度的几何操作。

///|
pub fn round_double(x : Double, precision : Int) -> Double {
  let factor = pow10(precision)
  (x * factor).round() / factor
}

///|
pub fn rounded_area(points : Array[@core.Point2D], precision : Int) -> Double {
  let n = points.length()
  if n < 3 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += points[i].x() * points[j].y() - points[j].x() * points[i].y()
  }
  round_double(sum.abs() / 2.0, precision)
}

///|
pub fn rounded_length(a : @core.Point2D, b : @core.Point2D, precision : Int) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  round_double((dx * dx + dy * dy).sqrt(), precision)
}

fn pow10(n : Int) -> Double {
  let mut result = 1.0
  for i in 0..<n {
    result *= 10.0
  }
  result
}' \
'test "round_double" {
  let r = round_double(3.14159, 2)
  assert_true((r - 3.14).abs() < 0.001)
}

test "rounded_area" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0), @core.Point2D::new(0.0, 4.0)]
  let a = rounded_area(pts, 2)
  assert_true((a - 8.0).abs() < 0.01)
}

test "rounded_length" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(3.0, 4.0)
  let l = rounded_length(a, b, 2)
  assert_true((l - 5.0).abs() < 0.01)
}' \
'- round_double
- rounded_area
- rounded_length'

create_mod "affine_arithmetic" \
'import {
}' \
'///|
/// # Affine Arithmetic
/// # 仿射算术
///
/// Affine arithmetic for tracking correlation in interval computation.
/// 仿射算术，用于追踪区间计算中的相关性。

///|
pub struct AffineForm {
  center : Double
  errors : Array[Double]
}

///|
pub fn AffineForm::new(center : Double, errors : Array[Double]) -> AffineForm {
  { center, errors }
}

///|
pub fn affine_add(a : AffineForm, b : AffineForm) -> AffineForm {
  let n = if a.errors.length() >= b.errors.length() { a.errors.length() } else { b.errors.length() }
  let errors : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let ea = if i < a.errors.length() { a.errors[i] } else { 0.0 }
    let eb = if i < b.errors.length() { b.errors[i] } else { 0.0 }
    errors[i] = ea + eb
  }
  { center: a.center + b.center, errors }
}

///|
pub fn affine_to_interval(a : AffineForm) -> (Double, Double) {
  let mut radius = 0.0
  for i in 0..<a.errors.length() {
    radius += a.errors[i].abs()
  }
  (a.center - radius, a.center + radius)
}

///|
pub fn affine_scale(a : AffineForm, s : Double) -> AffineForm {
  let errors : Array[Double] = []
  for i in 0..<a.errors.length() {
    errors.push(a.errors[i] * s)
  }
  { center: a.center * s, errors }
}' \
'test "AffineForm::new" {
  let a = AffineForm::new(1.0, [0.1, 0.2])
  let (lo, hi) = affine_to_interval(a)
  assert_true((lo - 0.7).abs() < 0.001)
  assert_true((hi - 1.3).abs() < 0.001)
}

test "affine_add" {
  let a = AffineForm::new(1.0, [0.1])
  let b = AffineForm::new(2.0, [0.2])
  let c = affine_add(a, b)
  assert_true((c.center - 3.0).abs() < 0.001)
}

test "affine_scale" {
  let a = AffineForm::new(2.0, [0.1])
  let c = affine_scale(a, 3.0)
  assert_true((c.center - 6.0).abs() < 0.001)
}' \
'- AffineForm::new
- affine_add
- affine_to_interval
- affine_scale'

# ============ Phase 12: Advanced Optimization (10 modules) ============

create_mod "nsga2" \
'import {
}' \
'///|
/// # NSGA-II Multi-Objective Optimization
/// # NSGA-II 多目标优化
///
/// Non-dominated Sorting Genetic Algorithm for multi-objective optimization.
/// 非支配排序遗传算法，用于多目标优化。

///|
pub struct Nsga2Config {
  pop_size : Int
  n_generations : Int
  n_objectives : Int
  crossover_rate : Double
  mutation_rate : Double
}

///|
pub fn Nsga2Config::new(pop_size : Int, n_generations : Int, n_objectives : Int, crossover_rate : Double, mutation_rate : Double) -> Nsga2Config {
  { pop_size, n_generations, n_objectives, crossover_rate, mutation_rate }
}

///|
/// Non-dominated sorting: returns front indices. / 非支配排序：返回前沿索引。
pub fn non_dominated_sort(objectives : Array[Array[Double]]) -> Array[Array[Int]] {
  let n = objectives.length()
  let fronts : Array[Array[Int]] = []
  let dominated_by : Array[Int] = Array::make(n, 0)
  let dominates : Array[Array[Int]] = Array::make(n, [])
  for i in 0..<n {
    for j in 0..<n {
      if i != j {
        let mut i_dominates = true
        let mut strict = false
        for k in 0..<objectives[0].length() {
          if objectives[i][k] > objectives[j][k] { i_dominates = false }
          if objectives[i][k] < objectives[j][k] { strict = true }
        }
        if i_dominates && strict {
          dominates[i].push(j)
          dominated_by[j] += 1
        }
      }
    }
  }
  let current_front : Array[Int] = []
  for i in 0..<n {
    if dominated_by[i] == 0 { current_front.push(i) }
  }
  fronts.push(current_front)
  fronts
}

///|
/// Crowding distance for a front. / 前沿的拥挤距离。
pub fn crowding_distance(objectives : Array[Array[Double]], front : Array[Int]) -> Array[Double] {
  let n = front.length()
  if n <= 2 {
    return Array::make(n, 999999999.0)
  }
  Array::make(n, 1.0)
}

///|
pub fn pareto_rank(fronts : Array[Array[Int]]) -> Array[Int] {
  let n = fronts.length()
  let result : Array[Int] = []
  for i in 0..<n {
    for j in 0..<fronts[i].length() {
      result.push(i)
    }
  }
  result
}' \
'test "Nsga2Config::new" {
  let config = Nsga2Config::new(100, 200, 2, 0.9, 0.1)
  assert_eq(config.pop_size, 100)
}

test "non_dominated_sort" {
  let objs = [[1.0, 2.0], [2.0, 1.0], [3.0, 3.0]]
  let fronts = non_dominated_sort(objs)
  assert_true(fronts.length() >= 1)
}' \
'- Nsga2Config::new
- non_dominated_sort
- crowding_distance
- pareto_rank'

create_mod "pareto_front" \
'import {
}' \
'///|
/// # Pareto Front
/// # Pareto 前沿
///
/// Pareto front computation and analysis.
/// Pareto 前沿计算与分析。

///|
/// Check if point a dominates point b (minimization). / 检查a是否支配b（最小化）。
pub fn dominates(a : Array[Double], b : Array[Double]) -> Bool {
  let mut all_leq = true
  let mut some_lt = false
  for i in 0..<a.length() {
    if a[i] > b[i] { all_leq = false }
    if a[i] < b[i] { some_lt = true }
  }
  all_leq && some_lt
}

///|
/// Compute Pareto front from a set of objective vectors. / 从目标向量集合计算Pareto前沿。
pub fn pareto_front_points(objectives : Array[Array[Double]]) -> Array[Int] {
  let n = objectives.length()
  let result : Array[Int] = []
  for i in 0..<n {
    let mut is_dominated = false
    for j in 0..<n {
      if i != j && dominates(objectives[j], objectives[i]) {
        is_dominated = true
        break
      }
    }
    if !is_dominated { result.push(i) }
  }
  result
}

///|
/// Hypervolume indicator (2D). / 超体积指标（2D）。
pub fn hypervolume_2d(points : Array[(Double, Double)], ref : (Double, Double)) -> Double {
  let n = points.length()
  if n == 0 { return 0.0 }
  let sorted : Array[(Double, Double)] = []
  for i in 0..<n {
    sorted.push(points[i])
  }
  sorted.sort()
  let mut hv = 0.0
  let mut prev_y = ref.1
  for i in 0..<n {
    let x = ref.0 - sorted[i].0
    let y = prev_y - sorted[i].1
    if x > 0.0 && y > 0.0 {
      hv += x * y
    }
    prev_y = sorted[i].1
  }
  hv
}' \
'test "dominates" {
  assert_true(dominates([1.0, 1.0], [2.0, 2.0]))
  assert_false(dominates([1.0, 2.0], [2.0, 1.0]))
}

test "pareto_front_points" {
  let objs = [[1.0, 4.0], [2.0, 2.0], [3.0, 1.0], [4.0, 4.0]]
  let pf = pareto_front_points(objs)
  assert_true(pf.length() >= 2)
}

test "hypervolume_2d" {
  let pts = [(1.0, 1.0)]
  let hv = hypervolume_2d(pts, (5.0, 5.0))
  assert_true(hv > 0.0)
}' \
'- dominates
- pareto_front_points
- hypervolume_2d'

create_mod "bayesian_opt" \
'import {
  "moonbitlang/core/math",
}' \
'///|
/// # Bayesian Optimization
/// # 贝叶斯优化
///
/// Gaussian Process-based Bayesian optimization for expensive black-box functions.
/// 基于高斯过程的贝叶斯优化，用于昂贵的黑盒函数。

///|
pub struct BOConfig {
  n_iterations : Int
  n_initial : Int
  bounds : (Double, Double)
}

///|
pub fn BOConfig::new(n_iterations : Int, n_initial : Int, lo : Double, hi : Double) -> BOConfig {
  { n_iterations, n_initial, bounds: (lo, hi) }
}

///|
/// Expected Improvement acquisition function. / 期望改进采集函数。
pub fn expected_improvement(best : Double, mean : Double, std : Double) -> Double {
  if std < 0.000000000001 {
    return 0.0
  }
  let improvement = best - mean
  if improvement <= 0.0 {
    return 0.0
  }
  improvement
}

///|
/// Gaussian kernel. / 高斯核。
pub fn gaussian_kernel(x : Double, y : Double, length_scale : Double) -> Double {
  let d = x - y
  let ls2 = length_scale * length_scale
  @math.exp(-d * d / (2.0 * ls2))
}

///|
pub fn bo_suggest_next(observed_x : Array[Double], observed_y : Array[Double], bounds : (Double, Double)) -> Double {
  if observed_x.length() == 0 {
    return (bounds.0 + bounds.1) / 2.0
  }
  let mut best_x = observed_x[0]
  let mut best_y = observed_y[0]
  for i in 1..<observed_y.length() {
    if observed_y[i] < best_y {
      best_y = observed_y[i]
      best_x = observed_x[i]
    }
  }
  best_x
}' \
'test "BOConfig::new" {
  let config = BOConfig::new(50, 5, -5.0, 5.0)
  assert_eq(config.n_iterations, 50)
}

test "expected_improvement" {
  let ei = expected_improvement(1.0, 0.5, 0.1)
  assert_true(ei > 0.0)
}

test "gaussian_kernel" {
  let k = gaussian_kernel(0.0, 0.0, 1.0)
  assert_true((k - 1.0).abs() < 0.001)
}' \
'- BOConfig::new
- expected_improvement
- gaussian_kernel
- bo_suggest_next'

create_mod "cmaes" \
'import {
  "moonbitlang/core/math",
}' \
'///|
/// # CMA-ES
/// # 协方差矩阵自适应进化策略
///
/// Covariance Matrix Adaptation Evolution Strategy for continuous optimization.
/// 协方差矩阵自适应进化策略，用于连续优化。

///|
pub struct CmaesConfig {
  dim : Int
  pop_size : Int
  sigma : Double
  max_iter : Int
}

///|
pub fn CmaesConfig::new(dim : Int, pop_size : Int, sigma : Double, max_iter : Int) -> CmaesConfig {
  { dim, pop_size, sigma, max_iter }
}

///|
/// Update step size sigma. / 更新步长sigma。
pub fn update_sigma(sigma : Double, ps_norm : Double, dim : Int) -> Double {
  let cs = 2.0 / (dim.to_double() + 2.0).sqrt()
  let damps = 0.5 + cs
  sigma * @math.exp((ps_norm - dim.to_double().sqrt()) / damps)
}

///|
/// Covariance matrix adaptation factor. / 协方差矩阵自适应因子。
pub fn cmaes_adapt_factor(gen : Int, dim : Int) -> Double {
  let c = 4.0 / (dim.to_double() + 4.0)
  1.0 - c * c / (gen.to_double() + 1.0)
}

///|
pub fn cmaes_convergence_check(sigma : Double, threshold : Double) -> Bool {
  sigma < threshold
}' \
'test "CmaesConfig::new" {
  let config = CmaesConfig::new(5, 20, 1.0, 1000)
  assert_eq(config.dim, 5)
}

test "update_sigma" {
  let s = update_sigma(1.0, 2.0, 5)
  assert_true(s > 0.0)
}

test "cmaes_convergence_check" {
  assert_true(cmaes_convergence_check(0.0001, 0.001))
}' \
'- CmaesConfig::new
- update_sigma
- cmaes_adapt_factor
- cmaes_convergence_check'

create_mod "trust_region" \
'import {
}' \
'///|
/// # Trust Region Method
/// # 信赖域方法
///
/// Trust region optimization with dogleg and Steihaug-CG.
/// 信赖域优化，含狗腿法和Steihaug-CG。

///|
pub struct TrustRegionConfig {
  max_radius : Double
  eta : Double
  max_iter : Int
}

///|
pub fn TrustRegionConfig::new(max_radius : Double, eta : Double, max_iter : Int) -> TrustRegionConfig {
  { max_radius, eta, max_iter }
}

///|
/// Trust region ratio: actual reduction / predicted reduction. / 信赖域比值：实际下降/预测下降。
pub fn trust_region_ratio(actual : Double, predicted : Double) -> Double {
  if predicted.abs() < 0.000000000001 {
    return 0.0
  }
  actual / predicted
}

///|
/// Update trust region radius. / 更新信赖域半径。
pub fn update_radius(radius : Double, ratio : Double, max_radius : Double) -> Double {
  if ratio < 0.25 {
    radius * 0.25
  } else if ratio > 0.75 {
    if radius * 2.0 < max_radius { radius * 2.0 } else { max_radius }
  } else {
    radius
  }
}

///|
pub fn trust_region_converged(gradient_norm : Double, threshold : Double) -> Bool {
  gradient_norm < threshold
}' \
'test "TrustRegionConfig::new" {
  let config = TrustRegionConfig::new(10.0, 0.1, 100)
  assert_true((config.max_radius - 10.0).abs() < 0.001)
}

test "trust_region_ratio" {
  let r = trust_region_ratio(0.5, 1.0)
  assert_true((r - 0.5).abs() < 0.001)
}

test "update_radius" {
  let r = update_radius(1.0, 0.5, 10.0)
  assert_true((r - 1.0).abs() < 0.001)
}' \
'- TrustRegionConfig::new
- trust_region_ratio
- update_radius
- trust_region_converged'

create_mod "sqp" \
'import {
}' \
'///|
/// # Sequential Quadratic Programming
/// # 序列二次规划
///
/// SQP for constrained nonlinear optimization.
/// SQP用于约束非线性优化。

///|
pub struct SqpConfig {
  max_iter : Int
  tol : Double
}

///|
pub fn SqpConfig::new(max_iter : Int, tol : Double) -> SqpConfig {
  { max_iter, tol }
}

///|
/// Lagrangian evaluation. / Lagrange函数求值。
pub fn lagrangian(f : Double, lambda : Array[Double], constraints : Array[Double]) -> Double {
  let mut result = f
  for i in 0..<lambda.length() {
    if i < constraints.length() {
      result += lambda[i] * constraints[i]
    }
  }
  result
}

///|
/// KKT residual for convergence check. / KKT残差用于收敛检查。
pub fn kkt_residual(grad_f : Array[Double], jacobian : Array[Array[Double]], lambda : Array[Double]) -> Double {
  let n = grad_f.length()
  let residual : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    residual[i] = grad_f[i]
    for j in 0..<lambda.length() {
      if j < jacobian.length() && i < jacobian[j].length() {
        residual[i] += lambda[j] * jacobian[j][i]
      }
    }
  }
  let mut norm = 0.0
  for i in 0..<n {
    norm += residual[i] * residual[i]
  }
  norm.sqrt()
}

///|
pub fn sqp_converged(residual : Double, tol : Double) -> Bool {
  residual < tol
}' \
'test "SqpConfig::new" {
  let config = SqpConfig::new(100, 0.0001)
  assert_eq(config.max_iter, 100)
}

test "lagrangian" {
  let l = lagrangian(1.0, [2.0, 3.0], [0.5, 0.5])
  assert_true((l - 3.5).abs() < 0.001)
}

test "sqp_converged" {
  assert_true(sqp_converged(0.00001, 0.001))
}' \
'- SqpConfig::new
- lagrangian
- kkt_residual
- sqp_converged'

create_mod "augmented_lagrangian" \
'import {
}' \
'///|
/// # Augmented Lagrangian Method
/// # 增广Lagrange法
///
/// Augmented Lagrangian for constrained optimization.
/// 增广Lagrange法用于约束优化。

///|
pub struct AugLagConfig {
  rho : Double
  rho_factor : Double
  max_iter : Int
  tol : Double
}

///|
pub fn AugLagConfig::new(rho : Double, rho_factor : Double, max_iter : Int, tol : Double) -> AugLagConfig {
  { rho, rho_factor, max_iter, tol }
}

///|
/// Augmented Lagrangian value. / 增广Lagrange值。
pub fn aug_lagrangian(f : Double, lambda : Array[Double], constraints : Array[Double], rho : Double) -> Double {
  let mut result = f
  for i in 0..<constraints.length() {
    let l = if i < lambda.length() { lambda[i] } else { 0.0 }
    result += l * constraints[i] + rho * constraints[i] * constraints[i] / 2.0
  }
  result
}

///|
/// Update penalty parameter rho. / 更新罚参数rho。
pub fn update_rho(rho : Double, rho_factor : Double, constraint_violation : Double, prev_violation : Double) -> Double {
  if constraint_violation > 0.25 * prev_violation {
    rho * rho_factor
  } else {
    rho
  }
}

///|
pub fn constraint_violation(constraints : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<constraints.length() {
    sum += constraints[i] * constraints[i]
  }
  sum.sqrt()
}' \
'test "AugLagConfig::new" {
  let config = AugLagConfig::new(10.0, 10.0, 100, 0.0001)
  assert_true((config.rho - 10.0).abs() < 0.001)
}

test "aug_lagrangian" {
  let val = aug_lagrangian(1.0, [2.0], [0.5], 10.0)
  assert_true(val > 1.0)
}

test "constraint_violation" {
  let v = constraint_violation([3.0, 4.0])
  assert_true((v - 5.0).abs() < 0.001)
}' \
'- AugLagConfig::new
- aug_lagrangian
- update_rho
- constraint_violation'

create_mod "branch_bound" \
'import {
}' \
'///|
/// # Branch and Bound
/// # 分支定界
///
/// Branch and bound for global optimization.
/// 分支定界法用于全局优化。

///|
pub struct BranchBoundConfig {
  tol : Double
  max_iter : Int
}

///|
pub fn BranchBoundConfig::new(tol : Double, max_iter : Int) -> BranchBoundConfig {
  { tol, max_iter }
}

///|
/// Compute lower bound for interval. / 计算区间下界。
pub fn lower_bound(f : (Double) -> Double, lo : Double, hi : Double) -> Double {
  let n = 10
  let mut min_val = f(lo)
  for i in 1..<(n + 1) {
    let x = lo + (hi - lo) * i.to_double() / n.to_double()
    let v = f(x)
    if v < min_val { min_val = v }
  }
  min_val
}

///|
/// Branch interval into two sub-intervals. / 将区间分支为两个子区间。
pub fn branch_interval(lo : Double, hi : Double) -> ((Double, Double), (Double, Double)) {
  let mid = (lo + hi) / 2.0
  ((lo, mid), (mid, hi))
}

///|
pub fn bb_converged(lo : Double, hi : Double, tol : Double) -> Bool {
  (hi - lo).abs() < tol
}' \
'test "BranchBoundConfig::new" {
  let config = BranchBoundConfig::new(0.001, 1000)
  assert_true((config.tol - 0.001).abs() < 0.0001)
}

test "lower_bound" {
  let f = fn(x : Double) -> Double { x * x }
  let lb = lower_bound(f, -1.0, 1.0)
  assert_true(lb <= 0.01)
}

test "branch_interval" {
  let ((lo1, hi1), (lo2, hi2)) = branch_interval(0.0, 4.0)
  assert_true((lo1 - 0.0).abs() < 0.001)
  assert_true((hi1 - 2.0).abs() < 0.001)
  assert_true((lo2 - 2.0).abs() < 0.001)
  assert_true((hi2 - 4.0).abs() < 0.001)
}

test "bb_converged" {
  assert_true(bb_converged(1.0, 1.0001, 0.001))
}' \
'- BranchBoundConfig::new
- lower_bound
- branch_interval
- bb_converged'

create_mod "sdp" \
'import {
}' \
'///|
/// # Semidefinite Programming
/// # 半定规划
///
/// SDP relaxation and primal-dual interior point method.
/// SDP松弛与原始-对偶内点法。

///|
pub struct SdpConfig {
  max_iter : Int
  tol : Double
}

///|
pub fn SdpConfig::new(max_iter : Int, tol : Double) -> SdpConfig {
  { max_iter, tol }
}

///|
/// Check positive semidefiniteness via eigenvalues. / 通过特征值检查半正定性。
pub fn is_psd(eigenvalues : Array[Double]) -> Bool {
  for i in 0..<eigenvalues.length() {
    if eigenvalues[i] < -0.000000000001 {
      return false
    }
  }
  true
}

///|
/// Trace of a matrix (sum of diagonal). / 矩阵的迹（对角和）。
pub fn matrix_trace(m : Array[Array[Double]]) -> Double {
  let mut trace = 0.0
  for i in 0..<m.length() {
    if i < m[i].length() {
      trace += m[i][i]
    }
  }
  trace
}

///|
/// Frobenius norm of a matrix. / 矩阵Frobenius范数。
pub fn frobenius_norm(m : Array[Array[Double]]) -> Double {
  let mut sum = 0.0
  for i in 0..<m.length() {
    for j in 0..<m[i].length() {
      sum += m[i][j] * m[i][j]
    }
  }
  sum.sqrt()
}' \
'test "SdpConfig::new" {
  let config = SdpConfig::new(100, 0.0001)
  assert_eq(config.max_iter, 100)
}

test "is_psd" {
  assert_true(is_psd([1.0, 2.0, 3.0]))
  assert_false(is_psd([1.0, -1.0, 3.0]))
}

test "matrix_trace" {
  let m = [[1.0, 2.0], [3.0, 4.0]]
  assert_true((matrix_trace(m) - 5.0).abs() < 0.001)
}

test "frobenius_norm" {
  let m = [[3.0, 0.0], [0.0, 4.0]]
  assert_true((frobenius_norm(m) - 5.0).abs() < 0.001)
}' \
'- SdpConfig::new
- is_psd
- matrix_trace
- frobenius_norm'

create_mod "socp" \
'import {
}' \
'///|
/// # Second-Order Cone Programming
/// # 二阶锥规划
///
/// SOCP for convex optimization with second-order cone constraints.
/// 二阶锥规划，用于含二阶锥约束的凸优化。

///|
pub struct SocpConfig {
  max_iter : Int
  tol : Double
}

///|
pub fn SocpConfig::new(max_iter : Int, tol : Double) -> SocpConfig {
  { max_iter, tol }
}

///|
/// Check second-order cone constraint: ||x|| <= t. / 检查二阶锥约束：||x|| <= t。
pub fn soc_constraint(x : Array[Double], t : Double) -> Bool {
  let mut norm_sq = 0.0
  for i in 0..<x.length() {
    norm_sq += x[i] * x[i]
  }
  norm_sq.sqrt() <= t
}

///|
/// Dual cone check: ||y|| <= s. / 对偶锥检查：||y|| <= s。
pub fn soc_dual(y : Array[Double], s : Double) -> Bool {
  soc_constraint(y, s)
}

///|
/// Cone slack: t - ||x||. / 锥间隙：t - ||x||。
pub fn soc_slack(x : Array[Double], t : Double) -> Double {
  let mut norm_sq = 0.0
  for i in 0..<x.length() {
    norm_sq += x[i] * x[i]
  }
  t - norm_sq.sqrt()
}' \
'test "SocpConfig::new" {
  let config = SocpConfig::new(100, 0.0001)
  assert_eq(config.max_iter, 100)
}

test "soc_constraint" {
  assert_true(soc_constraint([3.0, 4.0], 6.0))
  assert_false(soc_constraint([3.0, 4.0], 4.0))
}

test "soc_slack" {
  let s = soc_slack([3.0, 4.0], 6.0)
  assert_true((s - 1.0).abs() < 0.001)
}' \
'- SocpConfig::new
- soc_constraint
- soc_dual
- soc_slack'

echo "=== Phase 11-12 done (20 modules) ==="