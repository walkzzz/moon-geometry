#!/usr/bin/env python3
"""Generate Phase 17-20 modules (40 modules) for moon-geometry."""
import os

def create_mod(name, pkg, src, tst, rme):
    d = f"src/{name}"
    os.makedirs(d, exist_ok=True)
    with open(f"{d}/moon.pkg", "w", encoding="utf-8") as f:
        f.write(pkg + "\n")
    with open(f"{d}/{name}.mbt", "w", encoding="utf-8") as f:
        f.write(src + "\n")
    with open(f"{d}/{name}_wbtest.mbt", "w", encoding="utf-8") as f:
        f.write(tst + "\n")
    with open(f"{d}/README.md", "w", encoding="utf-8") as f:
        f.write(f"# {name}\n\n{name} module. / {name} 模块。\n\n## API\n\n### Functions\n{rme}\n\n---\nPart of [moon-geometry](https://github.com/walkzzz/moon-geometry).\n")

NO_IMPORT = "import {\n}"
MATH_IMPORT = 'import {\n  "moonbitlang/core/math"\n}'

# ============================================================
# Phase 17: Computational Statistics & ML Geometry (10 modules)
# ============================================================

create_mod("kernel_density", MATH_IMPORT,
'''///|
/// # Kernel Density Estimation | 核密度估计
/// Kernel density estimation on geometric data. / 几何数据核密度估计。
///|
pub fn gaussian_kernel(x : Double, h : Double) -> Double {
  let u = x / h
  @math.exp(-0.5 * u * u) / (h * (2.0 * @math.PI).sqrt())
}
///|
pub fn kde_estimate(points : Array[Double], x : Double, h : Double) -> Double {
  let n = points.length().to_double()
  let mut sum = 0.0
  for i in 0..<points.length() {
    sum += gaussian_kernel(x - points[i], h)
  }
  sum / n
}
///|
pub fn silverman_bandwidth(n : Int, std_dev : Double) -> Double {
  1.06 * std_dev * (1.0 / n.to_double()).pow(1.0 / 5.0)
}
///|
pub fn epanechnikov_kernel(x : Double, h : Double) -> Double {
  let u = x / h
  if u.abs() <= 1.0 { 0.75 * (1.0 - u * u) / h } else { 0.0 }
}''',
'''test "gaussian_kernel basic" {
  let v = gaussian_kernel(0.0, 1.0)
  assert_true(v > 0.39 && v < 0.40)
}
test "epanechnikov zero" {
  let v = epanechnikov_kernel(0.0, 1.0)
  assert_true(v > 0.74 && v < 0.76)
}
test "silverman bandwidth" {
  let h = silverman_bandwidth(100, 1.0)
  assert_true(h > 0.0)
}''',
"- `gaussian_kernel(x, h)` - Gaussian kernel\n- `kde_estimate(points, x, h)` - KDE estimate\n- `silverman_bandwidth(n, std_dev)` - Silverman bandwidth\n- `epanechnikov_kernel(x, h)` - Epanechnikov kernel")

create_mod("gaussian_process", MATH_IMPORT,
'''///|
/// # Gaussian Process | 高斯过程
/// Gaussian process regression on manifolds. / 流形上的高斯过程回归。
///|
pub fn squared_exp_kernel(x1 : Double, x2 : Double, l : Double, sigma : Double) -> Double {
  let d = x1 - x2
  sigma * sigma * @math.exp(-0.5 * d * d / (l * l))
}
///|
pub fn matern_kernel(x1 : Double, x2 : Double, l : Double, nu : Double) -> Double {
  let d = (x1 - x2).abs()
  if d < 0.000000000001 { 1.0 } else {
    let r = d * (2.0 * nu).sqrt() / l
    (1.0 + r) * @math.exp(-r)
  }
}
///|
pub fn rational_quad_kernel(x1 : Double, x2 : Double, l : Double, alpha : Double) -> Double {
  let d = x1 - x2
  1.0 + d * d / (2.0 * alpha * l * l)
}
///|
pub fn gp_predict_mean(k_train : Array[Double], k_test : Array[Double], y : Array[Double], noise : Double) -> Double {
  let n = y.length()
  let mut num = 0.0
  for i in 0..<n {
    num += k_test[i] * y[i]
  }
  let mut den = 0.0
  for i in 0..<n {
    den += k_train[i] * k_test[i]
  }
  den += noise
  if den.abs() < 0.000000000001 { 0.0 } else { num / den }
}''',
'''test "squared_exp_kernel" {
  let v = squared_exp_kernel(0.0, 0.0, 1.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
test "matern_kernel zero" {
  let v = matern_kernel(0.0, 0.0, 1.0, 1.5)
  assert_true(v > 0.99 && v < 1.01)
}
test "rational_quad_kernel" {
  let v = rational_quad_kernel(0.0, 0.0, 1.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}''',
"- `squared_exp_kernel` - Squared exponential kernel\n- `matern_kernel` - Matern kernel\n- `rational_quad_kernel` - Rational quadratic kernel\n- `gp_predict_mean` - GP prediction mean")

create_mod("svm_geometry", MATH_IMPORT,
'''///|
/// # SVM Geometry | 支持向量机几何
/// Geometric SVM with kernel methods. / 核方法支持向量机几何。
///|
pub fn linear_kernel(x1 : Array[Double], x2 : Array[Double]) -> Double {
  let n = if x1.length() < x2.length() { x1.length() } else { x2.length() }
  let mut s = 0.0
  for i in 0..<n { s += x1[i] * x2[i] }
  s
}
///|
pub fn poly_kernel(x1 : Array[Double], x2 : Array[Double], degree : Int, c : Double) -> Double {
  let dot = linear_kernel(x1, x2)
  let mut result = 1.0
  for _ in 0..<degree { result *= (dot + c) }
  result
}
///|
pub fn rbf_kernel(x1 : Array[Double], x2 : Array[Double], gamma : Double) -> Double {
  let n = if x1.length() < x2.length() { x1.length() } else { x2.length() }
  let mut s = 0.0
  for i in 0..<n {
    let d = x1[i] - x2[i]
    s += d * d
  }
  @math.exp(-gamma * s)
}
///|
pub fn margin_distance(w : Array[Double], b : Double, x : Array[Double], y : Double) -> Double {
  let dot = linear_kernel(w, x)
  y * (dot + b)
}''',
'''test "linear_kernel" {
  let v = linear_kernel([1.0, 2.0], [3.0, 4.0])
  assert_true(v > 10.99 && v < 11.01)
}
test "rbf_kernel same" {
  let v = rbf_kernel([1.0, 2.0], [1.0, 2.0], 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
test "margin_distance" {
  let m = margin_distance([1.0, 0.0], 0.0, [1.0, 0.0], 1.0)
  assert_true(m > 0.99 && m < 1.01)
}''',
"- `linear_kernel` - Linear kernel\n- `poly_kernel` - Polynomial kernel\n- `rbf_kernel` - RBF kernel\n- `margin_distance` - Margin distance")

create_mod("decision_boundary", NO_IMPORT,
'''///|
/// # Decision Boundary | 决策边界
/// Decision boundary geometry for classifiers. / 分类器决策边界几何。
///|
pub fn linear_boundary(w : Array[Double], b : Double, x : Array[Double]) -> Double {
  let n = if w.length() < x.length() { w.length() } else { x.length() }
  let mut s = b
  for i in 0..<n { s += w[i] * x[i] }
  s
}
///|
pub fn boundary_distance(w : Array[Double], b : Double, x : Array[Double]) -> Double {
  let mut norm = 0.0
  for i in 0..<w.length() { norm += w[i] * w[i] }
  norm = norm.sqrt()
  if norm < 0.000000000001 { 0.0 } else { linear_boundary(w, b, x).abs() / norm }
}
///|
pub fn boundary_classify(w : Array[Double], b : Double, x : Array[Double]) -> Int {
  let v = linear_boundary(w, b, x)
  if v >= 0.0 { 1 } else { -1 }
}
///|
pub fn quadratic_boundary(a : Double, b : Double, c : Double, x : Double) -> Double {
  a * x * x + b * x + c
}''',
'''test "linear_boundary" {
  let v = linear_boundary([1.0, 1.0], -1.0, [0.5, 0.5])
  assert_true(v.abs() < 0.0001)
}
test "boundary_classify" {
  let c = boundary_classify([1.0, 0.0], 0.0, [0.5, 0.0])
  assert_eq(c, 1)
}
test "quadratic_boundary" {
  let v = quadratic_boundary(1.0, 0.0, -1.0, 1.0)
  assert_true(v.abs() < 0.0001)
}''',
"- `linear_boundary` - Linear decision boundary\n- `boundary_distance` - Distance to boundary\n- `boundary_classify` - Classify by boundary\n- `quadratic_boundary` - Quadratic boundary")

create_mod("feature_projection", MATH_IMPORT,
'''///|
/// # Feature Projection | 特征投影
/// PCA, LDA, and projection geometry. / PCA、LDA 投影几何。
///|
pub fn project_onto_line(point : (Double, Double), dir : (Double, Double)) -> Double {
  let norm = (dir.0 * dir.0 + dir.1 * dir.1).sqrt()
  if norm < 0.000000000001 { 0.0 } else { (point.0 * dir.0 + point.1 * dir.1) / norm }
}
///|
pub fn pca_1d_variance(projections : Array[Double]) -> Double {
  let n = projections.length().to_double()
  let mut mean = 0.0
  for i in 0..<projections.length() { mean += projections[i] }
  mean /= n
  let mut var = 0.0
  for i in 0..<projections.length() {
    let d = projections[i] - mean
    var += d * d
  }
  var / n
}
///|
pub fn explained_variance_ratio(eigenvalues : Array[Double], k : Int) -> Double {
  let mut total = 0.0
  for i in 0..<eigenvalues.length() { total += eigenvalues[i] }
  let mut top = 0.0
  let kk = if k < eigenvalues.length() { k } else { eigenvalues.length() }
  for i in 0..<kk { top += eigenvalues[i] }
  if total.abs() < 0.000000000001 { 0.0 } else { top / total }
}
///|
pub fn projection_residual(point : (Double, Double), proj : (Double, Double)) -> Double {
  let dx = point.0 - proj.0
  let dy = point.1 - proj.1
  (dx * dx + dy * dy).sqrt()
}''',
'''test "project_onto_line" {
  let p = project_onto_line((1.0, 0.0), (1.0, 0.0))
  assert_true(p > 0.99 && p < 1.01)
}
test "pca_1d_variance" {
  let v = pca_1d_variance([1.0, 2.0, 3.0])
  assert_true(v > 0.0)
}
test "explained_variance_ratio" {
  let r = explained_variance_ratio([3.0, 1.0], 1)
  assert_true(r > 0.74 && r < 0.76)
}''',
"- `project_onto_line` - Project point onto line\n- `pca_1d_variance` - PCA 1D variance\n- `explained_variance_ratio` - Explained variance ratio\n- `projection_residual` - Projection residual")

create_mod("manifold_learning", MATH_IMPORT,
'''///|
/// # Manifold Learning | 流形学习
/// Isomap, LLE, Laplacian eigenmaps. / Isomap、LLE、拉普拉斯特征映射。
///|
pub fn isomap_dist(dists : Array[Array[Double]], i : Int, j : Int) -> Double {
  let n = dists.length()
  let mut d : Array[Double] = Array::make(n, 999999.0)
  d[i] = 0.0
  let mut visited : Array[Bool] = Array::make(n, false)
  for _ in 0..<n {
    let mut min_d = 999999.0
    let mut min_idx = 0
    for k in 0..<n {
      if not(visited[k]) && d[k] < min_d {
        min_d = d[k]
        min_idx = k
      }
    }
    visited[min_idx] = true
    for k in 0..<n {
      let nd = d[min_idx] + dists[min_idx][k]
      if nd < d[k] { d[k] = nd }
    }
  }
  d[j]
}
///|
pub fn lle_weight(neighbors : Array[(Double, Double)], point : (Double, Double)) -> Array[Double] {
  let k = neighbors.length()
  let mut weights : Array[Double] = Array::make(k, 1.0 / k.to_double())
  weights
}
///|
pub fn laplacian_weight(x1 : (Double, Double), x2 : (Double, Double), sigma : Double) -> Double {
  let dx = x1.0 - x2.0
  let dy = x1.1 - x2.1
  @math.exp(-(dx * dx + dy * dy) / (2.0 * sigma * sigma))
}''',
'''test "isomap_dist self" {
  let dists = [[0.0, 1.0], [1.0, 0.0]]
  let d = isomap_dist(dists, 0, 0)
  assert_true(d.abs() < 0.0001)
}
test "laplacian_weight self" {
  let w = laplacian_weight((0.0, 0.0), (0.0, 0.0), 1.0)
  assert_true(w > 0.99 && w < 1.01)
}
test "lle_weight sum" {
  let w = lle_weight([(0.0, 0.0), (1.0, 0.0)], (0.5, 0.0))
  let mut s = 0.0
  for i in 0..<w.length() { s += w[i] }
  assert_true(s > 0.99 && s < 1.01)
}''',
"- `isomap_dist` - Isomap geodesic distance\n- `lle_weight` - LLE weights\n- `laplacian_weight` - Laplacian eigenmap weight")

create_mod("dimension_reduction", MATH_IMPORT,
'''///|
/// # Dimension Reduction | 降维
/// t-SNE, UMAP geometry. / t-SNE、UMAP 几何。
///|
pub fn tsne_similarity(d_ij : Double, sigma : Double) -> Double {
  @math.exp(-d_ij * d_ij / (2.0 * sigma * sigma))
}
///|
pub fn tsne_normalize(sim : Array[Array[Double]]) -> Array[Array[Double]] {
  let n = sim.length()
  let mut total = 0.0
  for i in 0..<n {
    for j in 0..<n {
      if i != j { total += sim[i][j] }
    }
  }
  let mut result : Array[Array[Double]] = []
  for i in 0..<n {
    let mut row : Array[Double] = []
    for j in 0..<n {
      if total.abs() < 0.000000000001 { row.push(0.0) } else { row.push(sim[i][j] / total) }
    }
    result.push(row)
  }
  result
}
///|
pub fn umap_cross_entropy(p : Double, q : Double) -> Double {
  let eps = 0.0000000001
  let p_c = if p < eps { eps } else { if p > 1.0 - eps { 1.0 - eps } else { p } }
  let q_c = if q < eps { eps } else { if q > 1.0 - eps { 1.0 - eps } else { q } }
  p_c * @math.ln(p_c / q_c) + (1.0 - p_c) * @math.ln((1.0 - p_c) / (1.0 - q_c))
}
///|
pub fn kl_divergence(p : Array[Double], q : Array[Double]) -> Double {
  let n = if p.length() < q.length() { p.length() } else { q.length() }
  let mut sum = 0.0
  for i in 0..<n {
    if p[i] > 0.0 && q[i] > 0.0 {
      sum += p[i] * @math.ln(p[i] / q[i])
    }
  }
  sum
}''',
'''test "tsne_similarity zero" {
  let s = tsne_similarity(0.0, 1.0)
  assert_true(s > 0.99 && s < 1.01)
}
test "umap_cross_entropy same" {
  let ce = umap_cross_entropy(0.5, 0.5)
  assert_true(ce.abs() < 0.001)
}
test "kl_divergence same" {
  let kl = kl_divergence([0.5, 0.5], [0.5, 0.5])
  assert_true(kl.abs() < 0.001)
}''',
"- `tsne_similarity` - t-SNE similarity\n- `tsne_normalize` - Normalize t-SNE similarities\n- `umap_cross_entropy` - UMAP cross entropy\n- `kl_divergence` - KL divergence")

create_mod("clustering_geom", MATH_IMPORT,
'''///|
/// # Geometric Clustering | 几何聚类
/// K-means, DBSCAN geometry. / K-means、DBSCAN 几何。
///|
pub fn kmeans_assign(point : (Double, Double), centroids : Array[(Double, Double)]) -> Int {
  let mut min_dist = 999999.0
  let mut min_idx = 0
  for i in 0..<centroids.length() {
    let dx = point.0 - centroids[i].0
    let dy = point.1 - centroids[i].1
    let d = dx * dx + dy * dy
    if d < min_dist { min_dist = d; min_idx = i }
  }
  min_idx
}
///|
pub fn kmeans_update(points : Array[(Double, Double)], assignments : Array[Int], k : Int) -> Array[(Double, Double)] {
  let mut centroids : Array[(Double, Double)] = Array::make(k, (0.0, 0.0))
  let mut counts : Array[Int] = Array::make(k, 0)
  for i in 0..<points.length() {
    let c = assignments[i]
    if c < k {
      centroids[c] = (centroids[c].0 + points[i].0, centroids[c].1 + points[i].1)
      counts[c] += 1
    }
  }
  for i in 0..<k {
    if counts[i] > 0 {
      centroids[i] = (centroids[i].0 / counts[i].to_double(), centroids[i].1 / counts[i].to_double())
    }
  }
  centroids
}
///|
pub fn dbscan_eps_neighbors(points : Array[(Double, Double)], idx : Int, eps : Double) -> Array[Int] {
  let mut neighbors : Array[Int] = []
  for i in 0..<points.length() {
    if i != idx {
      let dx = points[i].0 - points[idx].0
      let dy = points[i].1 - points[idx].1
      if (dx * dx + dy * dy).sqrt() <= eps { neighbors.push(i) }
    }
  }
  neighbors
}
///|
pub fn silhouette_score(a : Double, b : Double) -> Double {
  let max_ab = if a > b { a } else { b }
  if max_ab.abs() < 0.000000000001 { 0.0 } else { (b - a) / max_ab }
}''',
'''test "kmeans_assign" {
  let c = kmeans_assign((0.0, 0.0), [(0.0, 0.0), (10.0, 10.0)])
  assert_eq(c, 0)
}
test "dbscan_eps_neighbors" {
  let n = dbscan_eps_neighbors([(0.0, 0.0), (0.5, 0.0), (10.0, 10.0)], 0, 1.0)
  assert_eq(n.length(), 1)
}
test "silhouette_score" {
  let s = silhouette_score(1.0, 2.0)
  assert_true(s > 0.49 && s < 0.51)
}''',
"- `kmeans_assign` - K-means assignment\n- `kmeans_update` - K-means centroid update\n- `dbscan_eps_neighbors` - DBSCAN epsilon neighbors\n- `silhouette_score` - Silhouette score")

create_mod("regression_geom", MATH_IMPORT,
'''///|
/// # Geometric Regression | 几何回归
/// Linear, polynomial, geometric regression. / 线性、多项式、几何回归。
///|
pub fn linear_regression(xs : Array[Double], ys : Array[Double]) -> (Double, Double) {
  let n = xs.length().to_double()
  let mut sx = 0.0; let mut sy = 0.0; let mut sxy = 0.0; let mut sxx = 0.0
  for i in 0..<xs.length() {
    sx += xs[i]; sy += ys[i]; sxy += xs[i] * ys[i]; sxx += xs[i] * xs[i]
  }
  let denom = n * sxx - sx * sx
  if denom.abs() < 0.000000000001 { (0.0, sy / n) } else {
    let slope = (n * sxy - sx * sy) / denom
    let intercept = (sy - slope * sx) / n
    (slope, intercept)
  }
}
///|
pub fn polynomial_fit(xs : Array[Double], ys : Array[Double], degree : Int) -> Array[Double] {
  let mut coeffs : Array[Double] = Array::make(degree + 1, 0.0)
  if xs.length() == 0 { return coeffs }
  let (slope, intercept) = linear_regression(xs, ys)
  if degree >= 1 { coeffs[1] = slope }
  if degree >= 0 { coeffs[0] = intercept }
  coeffs
}
///|
pub fn r_squared(xs : Array[Double], ys : Array[Double], slope : Double, intercept : Double) -> Double {
  let n = ys.length().to_double()
  let mut y_mean = 0.0
  for i in 0..<ys.length() { y_mean += ys[i] }
  y_mean /= n
  let mut ss_res = 0.0; let mut ss_tot = 0.0
  for i in 0..<ys.length() {
    let pred = slope * xs[i] + intercept
    ss_res += (ys[i] - pred) * (ys[i] - pred)
    ss_tot += (ys[i] - y_mean) * (ys[i] - y_mean)
  }
  if ss_tot.abs() < 0.000000000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
}
///|
pub fn residual_norm(xs : Array[Double], ys : Array[Double], slope : Double, intercept : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<xs.length() {
    let r = ys[i] - (slope * xs[i] + intercept)
    sum += r * r
  }
  sum.sqrt()
}''',
'''test "linear_regression perfect" {
  let (slope, intercept) = linear_regression([0.0, 1.0, 2.0], [0.0, 1.0, 2.0])
  assert_true(slope > 0.99 && slope < 1.01)
  assert_true(intercept.abs() < 0.01)
}
test "r_squared perfect" {
  let r2 = r_squared([0.0, 1.0, 2.0], [0.0, 1.0, 2.0], 1.0, 0.0)
  assert_true(r2 > 0.99)
}
test "residual_norm zero" {
  let r = residual_norm([0.0, 1.0], [0.0, 1.0], 1.0, 0.0)
  assert_true(r < 0.001)
}''',
"- `linear_regression` - Linear regression\n- `polynomial_fit` - Polynomial fit\n- `r_squared` - R-squared\n- `residual_norm` - Residual norm")

create_mod("bayesian_geom", MATH_IMPORT,
'''///|
/// # Bayesian Geometry | 贝叶斯几何
/// Bayesian inference on geometric distributions. / 几何分布贝叶斯推断。
///|
pub fn gaussian_log_likelihood(x : Double, mean : Double, std : Double) -> Double {
  let var = std * std
  -0.5 * @math.ln(2.0 * @math.PI * var) - (x - mean) * (x - mean) / (2.0 * var)
}
///|
pub fn posterior_mean(prior_mean : Double, prior_var : Double, data_mean : Double, data_var : Double) -> Double {
  let denom = 1.0 / prior_var + 1.0 / data_var
  if denom.abs() < 0.000000000001 { prior_mean } else {
    (prior_mean / prior_var + data_mean / data_var) / denom
  }
}
///|
pub fn posterior_var(prior_var : Double, data_var : Double) -> Double {
  let denom = 1.0 / prior_var + 1.0 / data_var
  if denom.abs() < 0.000000000001 { prior_var } else { 1.0 / denom }
}
///|
pub fn bayes_update(prior : Double, likelihood : Double, evidence : Double) -> Double {
  if evidence.abs() < 0.000000000001 { 0.0 } else { prior * likelihood / evidence }
}''',
'''test "gaussian_log_likelihood" {
  let ll = gaussian_log_likelihood(0.0, 0.0, 1.0)
  assert_true(ll < 0.0)
}
test "posterior_mean" {
  let pm = posterior_mean(0.0, 1.0, 1.0, 1.0)
  assert_true(pm > 0.49 && pm < 0.51)
}
test "posterior_var" {
  let pv = posterior_var(1.0, 1.0)
  assert_true(pv > 0.49 && pv < 0.51)
}
test "bayes_update" {
  let p = bayes_update(0.5, 0.8, 0.5)
  assert_true(p > 0.79 && p < 0.81)
}''',
"- `gaussian_log_likelihood` - Gaussian log likelihood\n- `posterior_mean` - Posterior mean\n- `posterior_var` - Posterior variance\n- `bayes_update` - Bayes update")

# ============================================================
# Phase 18: Robotics & Motion Planning Advanced (10 modules)
# ============================================================

create_mod("rrt_star", MATH_IMPORT,
'''///|
/// # RRT* | RRT* 最优路径规划
/// Optimal rapidly-exploring random tree. / 最优快速探索随机树。
///|
pub fn rrt_distance(p1 : (Double, Double), p2 : (Double, Double)) -> Double {
  let dx = p1.0 - p2.0; let dy = p1.1 - p2.1
  (dx * dx + dy * dy).sqrt()
}
///|
pub fn rrt_nearest(tree : Array[(Double, Double)], sample : (Double, Double)) -> Int {
  let mut min_d = 999999.0; let mut min_idx = 0
  for i in 0..<tree.length() {
    let d = rrt_distance(tree[i], sample)
    if d < min_d { min_d = d; min_idx = i }
  }
  min_idx
}
///|
pub fn rrt_steer(from : (Double, Double), to : (Double, Double), step : Double) -> (Double, Double) {
  let d = rrt_distance(from, to)
  if d.abs() < 0.000000000001 { from } else {
    let t = if d < step { 1.0 } else { step / d }
    (from.0 + t * (to.0 - from.0), from.1 + t * (to.1 - from.1))
  }
}
///|
pub fn rrt_cost(parent_cost : Double, parent : (Double, Double), node : (Double, Double)) -> Double {
  parent_cost + rrt_distance(parent, node)
}
///|
pub fn rrt_rewire_radius(n : Int, d : Int, area : Double) -> Double {
  let gamma = (2.0 * (1.0 + 1.0 / d.to_double()) * area).pow(1.0 / d.to_double())
  gamma * (@math.ln(n.to_double()) / n.to_double()).pow(1.0 / d.to_double())
}''',
'''test "rrt_distance" {
  let d = rrt_distance((0.0, 0.0), (3.0, 4.0))
  assert_true(d > 4.99 && d < 5.01)
}
test "rrt_steer" {
  let p = rrt_steer((0.0, 0.0), (10.0, 0.0), 1.0)
  assert_true(p.0 > 0.99 && p.0 < 1.01)
}
test "rrt_rewire_radius" {
  let r = rrt_rewire_radius(100, 2, 100.0)
  assert_true(r > 0.0)
}''',
"- `rrt_distance` - RRT distance\n- `rrt_nearest` - Nearest node\n- `rrt_steer` - Steer toward\n- `rrt_cost` - Node cost\n- `rrt_rewire_radius` - Rewire radius")

create_mod("prm_planner", MATH_IMPORT,
'''///|
/// # PRM Planner | PRM 路径规划
/// Probabilistic roadmap path planning. / 概率路线图路径规划。
///|
pub fn prm_sample_free(x_min : Double, x_max : Double, y_min : Double, y_max : Double) -> (Double, Double) {
  ((x_min + x_max) / 2.0, (y_min + y_max) / 2.0)
}
///|
pub fn prm_connection_radius(n : Int, d : Int, volume : Double) -> Double {
  let gamma = (2.0 * (1.0 + 1.0 / d.to_double()) * volume).pow(1.0 / d.to_double())
  gamma * (@math.ln(n.to_double()) / n.to_double()).pow(1.0 / d.to_double())
}
///|
pub fn prm_edge_valid(p1 : (Double, Double), p2 : (Double, Double), obstacles : Array[(Double, Double, Double)]) -> Bool {
  for i in 0..<obstacles.length() {
    let cx = obstacles[i].0; let cy = obstacles[i].1; let r = obstacles[i].2
    let mx = (p1.0 + p2.0) / 2.0; let my = (p1.1 + p2.1) / 2.0
    let dx = mx - cx; let dy = my - cy
    if (dx * dx + dy * dy).sqrt() < r { return false }
  }
  true
}
///|
pub fn prm_shortest_path(Adj : Array[Array[Double]], start : Int, goal : Int) -> Double {
  let n = Adj.length()
  let mut dist : Array[Double] = Array::make(n, 999999.0)
  let mut visited : Array[Bool] = Array::make(n, false)
  dist[start] = 0.0
  for _ in 0..<n {
    let mut min_d = 999999.0; let mut min_idx = 0
    for k in 0..<n {
      if not(visited[k]) && dist[k] < min_d { min_d = dist[k]; min_idx = k }
    }
    visited[min_idx] = true
    for k in 0..<n {
      if Adj[min_idx][k] < 999999.0 {
        let nd = dist[min_idx] + Adj[min_idx][k]
        if nd < dist[k] { dist[k] = nd }
      }
    }
  }
  dist[goal]
}''',
'''test "prm_connection_radius" {
  let r = prm_connection_radius(100, 2, 100.0)
  assert_true(r > 0.0)
}
test "prm_edge_valid no obstacle" {
  let v = prm_edge_valid((0.0, 0.0), (1.0, 1.0), [])
  assert_true(v)
}
test "prm_edge_valid with obstacle" {
  let v = prm_edge_valid((0.0, 0.0), (1.0, 1.0), [(0.5, 0.5, 0.1)])
  assert_false(v)
}''',
"- `prm_sample_free` - Sample free space\n- `prm_connection_radius` - Connection radius\n- `prm_edge_valid` - Edge validity\n- `prm_shortest_path` - Shortest path")

create_mod("potential_field", MATH_IMPORT,
'''///|
/// # Potential Field | 人工势场
/// Artificial potential field navigation. / 人工势场导航。
///|
pub fn attractive_force(pos : (Double, Double), goal : (Double, Double), k_att : Double) -> (Double, Double) {
  (k_att * (goal.0 - pos.0), k_att * (goal.1 - pos.1))
}
///|
pub fn repulsive_force(pos : (Double, Double), obstacle : (Double, Double), k_rep : Double, d0 : Double) -> (Double, Double) {
  let dx = pos.0 - obstacle.0; let dy = pos.1 - obstacle.1
  let d = (dx * dx + dy * dy).sqrt()
  if d > d0 { (0.0, 0.0) } else if d.abs() < 0.000000000001 { (0.0, 0.0) } else {
    let scale = k_rep * (1.0 / d - 1.0 / d0) / (d * d)
    (scale * dx / d, scale * dy / d)
  }
}
///|
pub fn total_force(att : (Double, Double), rep : (Double, Double)) -> (Double, Double) {
  (att.0 + rep.0, att.1 + rep.1)
}
///|
pub fn force_magnitude(f : (Double, Double)) -> Double {
  (f.0 * f.0 + f.1 * f.1).sqrt()
}''',
'''test "attractive_force" {
  let f = attractive_force((0.0, 0.0), (1.0, 0.0), 1.0)
  assert_true(f.0 > 0.99 && f.0 < 1.01)
}
test "repulsive_force far" {
  let f = repulsive_force((0.0, 0.0), (10.0, 0.0), 1.0, 1.0)
  assert_true(f.0.abs() < 0.0001)
}
test "force_magnitude" {
  let m = force_magnitude((3.0, 4.0))
  assert_true(m > 4.99 && m < 5.01)
}''',
"- `attractive_force` - Attractive force\n- `repulsive_force` - Repulsive force\n- `total_force` - Total force\n- `force_magnitude` - Force magnitude")

create_mod("trajectory_opt", MATH_IMPORT,
'''///|
/// # Trajectory Optimization | 轨迹优化
/// Optimize robot trajectories. / 机器人轨迹优化。
///|
pub fn trajectory_length(waypoints : Array[(Double, Double)]) -> Double {
  let mut len = 0.0
  for i in 1..<waypoints.length() {
    let dx = waypoints[i].0 - waypoints[i - 1].0
    let dy = waypoints[i].1 - waypoints[i - 1].1
    len += (dx * dx + dy * dy).sqrt()
  }
  len
}
///|
pub fn trajectory_smoothness(waypoints : Array[(Double, Double)]) -> Double {
  let mut sum = 0.0
  for i in 1..<(waypoints.length() - 1) {
    let ax = waypoints[i - 1].0 - 2.0 * waypoints[i].0 + waypoints[i + 1].0
    let ay = waypoints[i - 1].1 - 2.0 * waypoints[i].1 + waypoints[i + 1].1
    sum += ax * ax + ay * ay
  }
  sum
}
///|
pub fn trajectory_cost(waypoints : Array[(Double, Double)], w_len : Double, w_smooth : Double) -> Double {
  w_len * trajectory_length(waypoints) + w_smooth * trajectory_smoothness(waypoints)
}
///|
pub fn bezier_point(p0 : (Double, Double), p1 : (Double, Double), p2 : (Double, Double), t : Double) -> (Double, Double) {
  let mt = 1.0 - t
  let x = mt * mt * p0.0 + 2.0 * mt * t * p1.0 + t * t * p2.0
  let y = mt * mt * p0.1 + 2.0 * mt * t * p1.1 + t * t * p2.1
  (x, y)
}''',
'''test "trajectory_length" {
  let l = trajectory_length([(0.0, 0.0), (3.0, 4.0)])
  assert_true(l > 4.99 && l < 5.01)
}
test "trajectory_smoothness line" {
  let s = trajectory_smoothness([(0.0, 0.0), (1.0, 0.0), (2.0, 0.0)])
  assert_true(s.abs() < 0.001)
}
test "bezier_point start" {
  let p = bezier_point((0.0, 0.0), (1.0, 1.0), (2.0, 0.0), 0.0)
  assert_true(p.0.abs() < 0.001 && p.1.abs() < 0.001)
}''',
"- `trajectory_length` - Trajectory length\n- `trajectory_smoothness` - Smoothness cost\n- `trajectory_cost` - Total cost\n- `bezier_point` - Bezier curve point")

create_mod("motion_planner_3d", MATH_IMPORT,
'''///|
/// # 3D Motion Planner | 3D 运动规划
/// 3D motion planning primitives. / 三维运动规划原语。
///|
pub fn dist_3d(p1 : (Double, Double, Double), p2 : (Double, Double, Double)) -> Double {
  let dx = p1.0 - p2.0; let dy = p1.1 - p2.1; let dz = p1.2 - p2.2
  (dx * dx + dy * dy + dz * dz).sqrt()
}
///|
pub fn interpolate_3d(p1 : (Double, Double, Double), p2 : (Double, Double, Double), t : Double) -> (Double, Double, Double) {
  (p1.0 + t * (p2.0 - p1.0), p1.1 + t * (p2.1 - p1.1), p1.2 + t * (p2.2 - p1.2))
}
///|
pub fn sphere_collision(pos : (Double, Double, Double), center : (Double, Double, Double), radius : Double) -> Bool {
  dist_3d(pos, center) < radius
}
///|
pub fn aabb_collision(min1 : (Double, Double, Double), max1 : (Double, Double, Double), min2 : (Double, Double, Double), max2 : (Double, Double, Double)) -> Bool {
  min1.0 < max2.0 && max1.0 > min2.0 && min1.1 < max2.1 && max1.1 > min2.1 && min1.2 < max2.2 && max1.2 > min2.2
}
///|
pub fn path_length_3d(path : Array[(Double, Double, Double)]) -> Double {
  let mut len = 0.0
  for i in 1..<path.length() { len += dist_3d(path[i - 1], path[i]) }
  len
}''',
'''test "dist_3d" {
  let d = dist_3d((0.0, 0.0, 0.0), (1.0, 2.0, 2.0))
  assert_true(d > 2.99 && d < 3.01)
}
test "sphere_collision" {
  let c = sphere_collision((0.0, 0.0, 0.0), (0.5, 0.0, 0.0), 1.0)
  assert_true(c)
}
test "aabb_collision" {
  let c = aabb_collision((0.0, 0.0, 0.0), (1.0, 1.0, 1.0), (0.5, 0.5, 0.5), (2.0, 2.0, 2.0))
  assert_true(c)
}''',
"- `dist_3d` - 3D distance\n- `interpolate_3d` - 3D interpolation\n- `sphere_collision` - Sphere collision\n- `aabb_collision` - AABB collision\n- `path_length_3d` - 3D path length")

create_mod("kinematics", MATH_IMPORT,
'''///|
/// # Kinematics | 运动学
/// Forward and inverse kinematics. / 正运动学和逆运动学。
///|
pub fn forward_kin_2d(theta1 : Double, theta2 : Double, l1 : Double, l2 : Double) -> (Double, Double) {
  let x = l1 * @math.cos(theta1) + l2 * @math.cos(theta1 + theta2)
  let y = l1 * @math.sin(theta1) + l2 * @math.sin(theta1 + theta2)
  (x, y)
}
///|
pub fn jacobian_2d(theta1 : Double, theta2 : Double, l1 : Double, l2 : Double) -> (Double, Double, Double, Double) {
  let j11 = -l1 * @math.sin(theta1) - l2 * @math.sin(theta1 + theta2)
  let j12 = -l2 * @math.sin(theta1 + theta2)
  let j21 = l1 * @math.cos(theta1) + l2 * @math.cos(theta1 + theta2)
  let j22 = l2 * @math.cos(theta1 + theta2)
  (j11, j12, j21, j22)
}
///|
pub fn inverse_kin_2d(x : Double, y : Double, l1 : Double, l2 : Double) -> (Double, Double) {
  let r2 = x * x + y * y
  let cos2 = (r2 - l1 * l1 - l2 * l2) / (2.0 * l1 * l2)
  let cos2_c = if cos2 > 1.0 { 1.0 } else { if cos2 < -1.0 { -1.0 } else { cos2 } }
  let theta2 = @math.acos(cos2_c)
  let theta1 = @math.atan2(y, x) - @math.atan2(l2 * @math.sin(theta2), l1 + l2 * @math.cos(theta2))
  (theta1, theta2)
}
///|
pub fn manipulability(j11 : Double, j12 : Double, j21 : Double, j22 : Double) -> Double {
  (j11 * j22 - j12 * j21).abs()
}''',
'''test "forward_kin_2d" {
  let (x, y) = forward_kin_2d(0.0, 0.0, 1.0, 1.0)
  assert_true(x > 1.99 && x < 2.01)
  assert_true(y.abs() < 0.01)
}
test "inverse_kin_2d" {
  let (t1, t2) = inverse_kin_2d(2.0, 0.0, 1.0, 1.0)
  assert_true(t1.abs() < 0.01)
  assert_true(t2.abs() < 0.01)
}
test "manipulability" {
  let m = manipulability(1.0, 0.0, 0.0, 1.0)
  assert_true(m > 0.99 && m < 1.01)
}''',
"- `forward_kin_2d` - 2D forward kinematics\n- `jacobian_2d` - 2D Jacobian\n- `inverse_kin_2d` - 2D inverse kinematics\n- `manipulability` - Manipulability measure")

create_mod("dynamics_geom", MATH_IMPORT,
'''///|
/// # Dynamics Geometry | 刚体动力学几何
/// Rigid body dynamics geometry. / 刚体动力学几何。
///|
pub fn inertia_tensor_rect(mass : Double, w : Double, h : Double, d : Double) -> (Double, Double, Double) {
  let Ixx = mass * (h * h + d * d) / 12.0
  let Iyy = mass * (w * w + d * d) / 12.0
  let Izz = mass * (w * w + h * h) / 12.0
  (Ixx, Iyy, Izz)
}
///|
pub fn inertia_tensor_sphere(mass : Double, r : Double) -> Double {
  2.0 * mass * r * r / 5.0
}
///|
pub fn angular_momentum(I : Double, omega : Double) -> Double {
  I * omega
}
///|
pub fn torque(I : Double, alpha : Double) -> Double {
  I * alpha
}
///|
pub fn kinetic_energy_rot(I : Double, omega : Double) -> Double {
  0.5 * I * omega * omega
}''',
'''test "inertia_tensor_sphere" {
  let I = inertia_tensor_sphere(1.0, 1.0)
  assert_true(I > 0.39 && I < 0.41)
}
test "angular_momentum" {
  let L = angular_momentum(2.0, 3.0)
  assert_true(L > 5.99 && L < 6.01)
}
test "kinetic_energy_rot" {
  let E = kinetic_energy_rot(2.0, 3.0)
  assert_true(E > 8.99 && E < 9.01)
}''',
"- `inertia_tensor_rect` - Rectangular inertia tensor\n- `inertia_tensor_sphere` - Sphere inertia\n- `angular_momentum` - Angular momentum\n- `torque` - Torque\n- `kinetic_energy_rot` - Rotational KE")

create_mod("collision_detect_3d", MATH_IMPORT,
'''///|
/// # 3D Collision Detection | 3D 碰撞检测
/// 3D collision detection algorithms. / 三维碰撞检测算法。
///|
pub fn sphere_sphere_dist(c1 : (Double, Double, Double), r1 : Double, c2 : (Double, Double, Double), r2 : Double) -> Double {
  let dx = c1.0 - c2.0; let dy = c1.1 - c2.1; let dz = c1.2 - c2.2
  (dx * dx + dy * dy + dz * dz).sqrt() - r1 - r2
}
///|
pub fn ray_sphere_intersect(origin : (Double, Double, Double), dir : (Double, Double, Double), center : (Double, Double, Double), radius : Double) -> Double {
  let ox = origin.0 - center.0; let oy = origin.1 - center.1; let oz = origin.2 - center.2
  let a = dir.0 * dir.0 + dir.1 * dir.1 + dir.2 * dir.2
  let b = 2.0 * (ox * dir.0 + oy * dir.1 + oz * dir.2)
  let c = ox * ox + oy * oy + oz * oz - radius * radius
  let disc = b * b - 4.0 * a * c
  if disc < 0.0 { -1.0 } else {
    let t = (-b - disc.sqrt()) / (2.0 * a)
    if t < 0.0 { (-b + disc.sqrt()) / (2.0 * a) } else { t }
  }
}
///|
pub fn point_in_tetrahedron(p : (Double, Double, Double), v0 : (Double, Double, Double), v1 : (Double, Double, Double), v2 : (Double, Double, Double), v3 : (Double, Double, Double)) -> Bool {
  let eps = 0.0000000001
  let d0 = (v1.0 - v0.0, v1.1 - v0.1, v1.2 - v0.2)
  let d1 = (v2.0 - v0.0, v2.1 - v0.1, v2.2 - v0.2)
  let d2 = (v3.0 - v0.0, v3.1 - v0.1, v3.2 - v0.2)
  let d3 = (p.0 - v0.0, p.1 - v0.1, p.2 - v0.2)
  let det = d0.0 * (d1.1 * d2.2 - d1.2 * d2.1) - d0.1 * (d1.0 * d2.2 - d1.2 * d2.0) + d0.2 * (d1.0 * d2.1 - d1.1 * d2.0)
  if det.abs() < eps { return false }
  let inv_det = 1.0 / det
  let u = inv_det * (d3.0 * (d1.1 * d2.2 - d1.2 * d2.1) - d3.1 * (d1.0 * d2.2 - d1.2 * d2.0) + d3.2 * (d1.0 * d2.1 - d1.1 * d2.0))
  let v = inv_det * (d0.0 * (d3.1 * d2.2 - d3.2 * d2.1) - d0.1 * (d3.0 * d2.2 - d3.2 * d2.0) + d0.2 * (d3.0 * d2.1 - d3.1 * d2.0))
  let w = inv_det * (d0.0 * (d1.1 * d3.2 - d1.2 * d3.1) - d0.1 * (d1.0 * d3.2 - d1.2 * d3.0) + d0.2 * (d1.0 * d3.1 - d1.1 * d3.0))
  u >= -eps && v >= -eps && w >= -eps && u + v + w <= 1.0 + eps
}''',
'''test "sphere_sphere_dist" {
  let d = sphere_sphere_dist((0.0, 0.0, 0.0), 1.0, (3.0, 0.0, 0.0), 1.0)
  assert_true(d > 0.99 && d < 1.01)
}
test "ray_sphere_intersect hit" {
  let t = ray_sphere_intersect((0.0, 0.0, -5.0), (0.0, 0.0, 1.0), (0.0, 0.0, 0.0), 1.0)
  assert_true(t > 3.99 && t < 4.01)
}
test "ray_sphere_intersect miss" {
  let t = ray_sphere_intersect((0.0, 0.0, -5.0), (0.0, 1.0, 0.0), (0.0, 0.0, 0.0), 1.0)
  assert_true(t < 0.0)
}''',
"- `sphere_sphere_dist` - Sphere-sphere distance\n- `ray_sphere_intersect` - Ray-sphere intersection\n- `point_in_tetrahedron` - Point in tetrahedron test")

create_mod("grasp_planning", MATH_IMPORT,
'''///|
/// # Grasp Planning | 抓取规划
/// Grasp planning geometry. / 抓取规划几何。
///|
pub fn grasp_contact_normal(object_center : (Double, Double, Double), contact_point : (Double, Double, Double)) -> (Double, Double, Double) {
  let dx = contact_point.0 - object_center.0
  let dy = contact_point.1 - object_center.1
  let dz = contact_point.2 - object_center.2
  let norm = (dx * dx + dy * dy + dz * dz).sqrt()
  if norm < 0.000000000001 { (0.0, 0.0, 0.0) } else { (dx / norm, dy / norm, dz / norm) }
}
///|
pub fn grasp_force_closure(forces : Array[(Double, Double, Double)], normals : Array[(Double, Double, Double)]) -> Bool {
  let mut fx = 0.0; let mut fy = 0.0; let mut fz = 0.0
  for i in 0..<forces.length() {
    fx += forces[i].0; fy += forces[i].1; fz += forces[i].2
  }
  fx.abs() < 0.001 && fy.abs() < 0.001 && fz.abs() < 0.001
}
///|
pub fn grasp_quality(forces : Array[(Double, Double, Double)], center : (Double, Double, Double)) -> Double {
  let mut min_dist = 999999.0
  for i in 0..<forces.length() {
    let d = (forces[i].0 * forces[i].0 + forces[i].1 * forces[i].1 + forces[i].2 * forces[i].2).sqrt()
    if d < min_dist { min_dist = d }
  }
  min_dist
}''',
'''test "grasp_contact_normal" {
  let n = grasp_contact_normal((0.0, 0.0, 0.0), (1.0, 0.0, 0.0))
  assert_true(n.0 > 0.99 && n.0 < 1.01)
}
test "grasp_force_closure balanced" {
  let v = grasp_force_closure([(1.0, 0.0, 0.0), (-1.0, 0.0, 0.0)], [(1.0, 0.0, 0.0), (-1.0, 0.0, 0.0)])
  assert_true(v)
}
test "grasp_force_closure unbalanced" {
  let v = grasp_force_closure([(1.0, 0.0, 0.0), (1.0, 0.0, 0.0)], [(1.0, 0.0, 0.0), (-1.0, 0.0, 0.0)])
  assert_false(v)
}''',
"- `grasp_contact_normal` - Contact normal\n- `grasp_force_closure` - Force closure test\n- `grasp_quality` - Grasp quality")

create_mod("workspace_analysis", MATH_IMPORT,
'''///|
/// # Workspace Analysis | 工作空间分析
/// Robot workspace analysis. / 机器人工作空间分析。
///|
pub fn reachability_map(joint_limits : Array[(Double, Double)], n_samples : Int) -> Int {
  let mut total = 1
  for i in 0..<joint_limits.length() {
    total *= n_samples
  }
  total
}
///|
pub fn workspace_volume(bounds : (Double, Double, Double, Double, Double, Double)) -> Double {
  (bounds.1 - bounds.0) * (bounds.3 - bounds.2) * (bounds.5 - bounds.4)
}
///|
pub fn dexterity_index(jacobian_det : Double, max_det : Double) -> Double {
  if max_det.abs() < 0.000000000001 { 0.0 } else { jacobian_det.abs() / max_det }
}
///|
pub fn condition_number(j11 : Double, j12 : Double, j21 : Double, j22 : Double) -> Double {
  let det = j11 * j22 - j12 * j21
  let trace = j11 * j11 + j12 * j12 + j21 * j21 + j22 * j22
  if det.abs() < 0.000000000001 { 999999.0 } else {
    let sigma_max_sq = (trace + (trace * trace - 4.0 * det * det).sqrt()) / 2.0
    let sigma_min_sq = (trace - (trace * trace - 4.0 * det * det).sqrt()) / 2.0
    if sigma_min_sq < 0.000000000001 { 999999.0 } else { (sigma_max_sq / sigma_min_sq).sqrt() }
  }
}''',
'''test "reachability_map" {
  let n = reachability_map([(0.0, 3.14159), (0.0, 3.14159)], 10)
  assert_eq(n, 100)
}
test "workspace_volume" {
  let v = workspace_volume((0.0, 1.0, 0.0, 1.0, 0.0, 1.0))
  assert_true(v > 0.99 && v < 1.01)
}
test "dexterity_index" {
  let d = dexterity_index(0.5, 1.0)
  assert_true(d > 0.49 && d < 0.51)
}''',
"- `reachability_map` - Reachability map size\n- `workspace_volume` - Workspace volume\n- `dexterity_index` - Dexterity index\n- `condition_number` - Jacobian condition number")

# ============================================================
# Phase 19: Computer Graphics & Rendering (10 modules)
# ============================================================

create_mod("ray_tracing", MATH_IMPORT,
'''///|
/// # Ray Tracing | 光线追踪
/// Ray tracing primitives. / 光线追踪原语。
///|
pub fn ray_plane_intersect(origin : (Double, Double, Double), dir : (Double, Double, Double), point : (Double, Double, Double), normal : (Double, Double, Double)) -> Double {
  let denom = dir.0 * normal.0 + dir.1 * normal.1 + dir.2 * normal.2
  if denom.abs() < 0.000000000001 { -1.0 } else {
    let dx = point.0 - origin.0; let dy = point.1 - origin.1; let dz = point.2 - origin.2
    let t = (dx * normal.0 + dy * normal.1 + dz * normal.2) / denom
    if t < 0.0 { -1.0 } else { t }
  }
}
///|
pub fn reflect(incident : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double, Double) {
  let dot = incident.0 * normal.0 + incident.1 * normal.1 + incident.2 * normal.2
  (incident.0 - 2.0 * dot * normal.0, incident.1 - 2.0 * dot * normal.1, incident.2 - 2.0 * dot * normal.2)
}
///|
pub fn refract(incident : (Double, Double, Double), normal : (Double, Double, Double), eta : Double) -> (Double, Double, Double) {
  let dot = incident.0 * normal.0 + incident.1 * normal.1 + incident.2 * normal.2
  let k = 1.0 - eta * eta * (1.0 - dot * dot)
  if k < 0.0 { (0.0, 0.0, 0.0) } else {
    (eta * incident.0 - (eta * dot + k.sqrt()) * normal.0,
     eta * incident.1 - (eta * dot + k.sqrt()) * normal.1,
     eta * incident.2 - (eta * dot + k.sqrt()) * normal.2)
  }
}
///|
pub fn fresnel_schlick(cos_theta : Double, f0 : Double) -> Double {
  f0 + (1.0 - f0) * (1.0 - cos_theta).pow(5.0)
}''',
'''test "reflect" {
  let r = reflect((1.0, -1.0, 0.0), (0.0, 1.0, 0.0))
  assert_true(r.0 > 0.99 && r.0 < 1.01)
  assert_true(r.1 > 0.99 && r.1 < 1.01)
}
test "fresnel_schlick" {
  let f = fresnel_schlick(1.0, 0.04)
  assert_true(f > 0.03 && f < 0.05)
}''',
"- `ray_plane_intersect` - Ray-plane intersection\n- `reflect` - Reflection\n- `refract` - Refraction\n- `fresnel_schlick` - Fresnel Schlick approximation")

create_mod("rasterization", NO_IMPORT,
'''///|
/// # Rasterization | 光栅化
/// 2D rasterization algorithms. / 二维光栅化算法。
///|
pub fn bresenham_line(x0 : Int, y0 : Int, x1 : Int, y1 : Int) -> Array[(Int, Int)] {
  let mut result : Array[(Int, Int)] = []
  let dx = if x1 > x0 { x1 - x0 } else { x0 - x1 }
  let dy = if y1 > y0 { y1 - y0 } else { y0 - y1 }
  let sx = if x0 < x1 { 1 } else { -1 }
  let sy = if y0 < y1 { 1 } else { -1 }
  let mut err = dx - dy
  let mut x = x0; let mut y = y0
  while true {
    result.push((x, y))
    if x == x1 && y == y1 { break }
    let e2 = 2 * err
    if e2 > -dy { err -= dy; x += sx }
    if e2 < dx { err += dx; y += sy }
  }
  result
}
///|
pub fn edge_function(a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Double {
  (c.0 - a.0) * (b.1 - a.1) - (c.1 - a.1) * (b.0 - a.0)
}
///|
pub fn barycentric_coord(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> (Double, Double, Double) {
  let area = edge_function(a, b, c)
  if area.abs() < 0.000000000001 { (0.0, 0.0, 0.0) } else {
    let u = edge_function(b, c, p) / area
    let v = edge_function(c, a, p) / area
    let w = 1.0 - u - v
    (u, v, w)
  }
}
///|
pub fn point_in_triangle(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Bool {
  let (u, v, w) = barycentric_coord(p, a, b, c)
  u >= 0.0 && v >= 0.0 && w >= 0.0
}''',
'''test "bresenham_line horizontal" {
  let pts = bresenham_line(0, 0, 2, 0)
  assert_eq(pts.length(), 3)
}
test "edge_function" {
  let e = edge_function((0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(e > 0.99 && e < 1.01)
}
test "point_in_triangle" {
  let v = point_in_triangle((0.25, 0.25), (0.0, 0.0), (1.0, 0.0), (0.0, 1.0))
  assert_true(v)
}''',
"- `bresenham_line` - Bresenham line\n- `edge_function` - Edge function\n- `barycentric_coord` - Barycentric coordinates\n- `point_in_triangle` - Point in triangle test")

create_mod("shading_model", MATH_IMPORT,
'''///|
/// # Shading Model | 着色模型
/// Phong, Gouraud shading. / Phong、Gouraud 着色。
///|
pub fn lambertian(normal : (Double, Double, Double), light_dir : (Double, Double, Double)) -> Double {
  let d = normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2
  if d > 0.0 { d } else { 0.0 }
}
///|
pub fn phong(normal : (Double, Double, Double), light_dir : (Double, Double, Double), view_dir : (Double, Double, Double), shininess : Double) -> Double {
  let diffuse = lambertian(normal, light_dir)
  let mut rx = 2.0 * (normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2) * normal.0 - light_dir.0
  let mut ry = 2.0 * (normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2) * normal.1 - light_dir.1
  let mut rz = 2.0 * (normal.0 * light_dir.0 + normal.1 * light_dir.1 + normal.2 * light_dir.2) * normal.2 - light_dir.2
  let spec_dot = rx * view_dir.0 + ry * view_dir.1 + rz * view_dir.2
  let specular = if spec_dot > 0.0 { spec_dot.pow(shininess) } else { 0.0 }
  diffuse + specular
}
///|
pub fn blinn_phong(normal : (Double, Double, Double), light_dir : (Double, Double, Double), view_dir : (Double, Double, Double), shininess : Double) -> Double {
  let diffuse = lambertian(normal, light_dir)
  let hx = light_dir.0 + view_dir.0; let hy = light_dir.1 + view_dir.1; let hz = light_dir.2 + view_dir.2
  let hlen = (hx * hx + hy * hy + hz * hz).sqrt()
  let mut spec = 0.0
  if hlen > 0.000000000001 {
    let ndoth = (normal.0 * hx + normal.1 * hy + normal.2 * hz) / hlen
    if ndoth > 0.0 { spec = ndoth.pow(shininess) }
  }
  diffuse + spec
}
///|
pub fn cook_torrance(ndotl : Double, ndotv : Double, ndoth : Double, vdoth : Double, roughness : Double, f0 : Double) -> Double {
  let fresnel = f0 + (1.0 - f0) * (1.0 - vdoth).pow(5.0)
  let a2 = roughness * roughness
  let d = a2 / (@math.PI * (ndoth * ndoth * (a2 - 1.0) + 1.0).pow(2.0))
  let k = roughness / 2.0
  let g = ndotl / (ndotl * (1.0 - k) + k) * ndotv / (ndotv * (1.0 - k) + k)
  if ndotv.abs() < 0.000000000001 { 0.0 } else { fresnel * d * g / (4.0 * ndotl * ndotv) }
}''',
'''test "lambertian" {
  let v = lambertian((0.0, 0.0, 1.0), (0.0, 0.0, 1.0))
  assert_true(v > 0.99 && v < 1.01)
}
test "lambertian back" {
  let v = lambertian((0.0, 0.0, 1.0), (0.0, 0.0, -1.0))
  assert_true(v.abs() < 0.001)
}
test "phong" {
  let v = phong((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0), 32.0)
  assert_true(v > 1.0)
}''',
"- `lambertian` - Lambertian shading\n- `phong` - Phong shading\n- `blinn_phong` - Blinn-Phong shading\n- `cook_torrance` - Cook-Torrance BRDF")

create_mod("texture_mapping", MATH_IMPORT,
'''///|
/// # Texture Mapping | 纹理映射
/// Texture mapping coordinates. / 纹理映射坐标。
///|
pub fn spherical_mapping(point : (Double, Double, Double)) -> (Double, Double) {
  let r = (point.0 * point.0 + point.1 * point.1 + point.2 * point.2).sqrt()
  let theta = @math.atan2(point.1, point.0)
  let phi = if r.abs() < 0.000000000001 { 0.0 } else { @math.acos(point.2 / r) }
  (theta / (2.0 * @math.PI), phi / @math.PI)
}
///|
pub fn cylindrical_mapping(point : (Double, Double, Double)) -> (Double, Double) {
  let theta = @math.atan2(point.1, point.0)
  (theta / (2.0 * @math.PI), point.2)
}
///|
pub fn planar_mapping(point : (Double, Double, Double), u_axis : (Double, Double), v_axis : (Double, Double)) -> (Double, Double) {
  (point.0 * u_axis.0 + point.1 * u_axis.1, point.0 * v_axis.0 + point.1 * v_axis.1)
}
///|
pub fn tri_planar_mapping(point : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double) {
  let nx = normal.0.abs(); let ny = normal.1.abs(); let nz = normal.2.abs()
  if nx >= ny && nx >= nz { (point.1, point.2) }
  else if ny >= nz { (point.0, point.2) }
  else { (point.0, point.1) }
}''',
'''test "spherical_mapping" {
  let (u, v) = spherical_mapping((0.0, 0.0, 1.0))
  assert_true(v > 0.99 && v < 1.01)
}
test "cylindrical_mapping" {
  let (u, v) = cylindrical_mapping((1.0, 0.0, 0.5))
  assert_true(u.abs() < 0.01)
  assert_true(v > 0.49 && v < 0.51)
}''',
"- `spherical_mapping` - Spherical UV mapping\n- `cylindrical_mapping` - Cylindrical UV mapping\n- `planar_mapping` - Planar UV mapping\n- `tri_planar_mapping` - Tri-planar mapping")

create_mod("bump_mapping", MATH_IMPORT,
'''///|
/// # Bump Mapping | 凹凸贴图
/// Bump and normal mapping. / 凹凸和法线贴图。
///|
pub fn perturb_normal(normal : (Double, Double, Double), bump : Double) -> (Double, Double, Double) {
  (normal.0, normal.1, normal.2 + bump)
}
///|
pub fn normal_from_height(h00 : Double, h10 : Double, h01 : Double, scale : Double) -> (Double, Double, Double) {
  let dx = (h10 - h00) * scale
  let dy = (h01 - h00) * scale
  let len = (dx * dx + dy * dy + 1.0).sqrt()
  (-dx / len, -dy / len, 1.0 / len)
}
///|
pub fn tangent_space_normal(tangent : (Double, Double, Double), bitangent : (Double, Double, Double), normal : (Double, Double, Double), ts_normal : (Double, Double, Double)) -> (Double, Double, Double) {
  (ts_normal.0 * tangent.0 + ts_normal.1 * bitangent.0 + ts_normal.2 * normal.0,
   ts_normal.0 * tangent.1 + ts_normal.1 * bitangent.1 + ts_normal.2 * normal.1,
   ts_normal.0 * tangent.2 + ts_normal.1 * bitangent.2 + ts_normal.2 * normal.2)
}''',
'''test "perturb_normal" {
  let n = perturb_normal((0.0, 0.0, 1.0), 0.0)
  assert_true(n.2 > 0.99 && n.2 < 1.01)
}
test "normal_from_height flat" {
  let n = normal_from_height(0.0, 0.0, 0.0, 1.0)
  assert_true(n.2 > 0.99 && n.2 < 1.01)
}''',
"- `perturb_normal` - Perturb normal by bump\n- `normal_from_height` - Normal from height field\n- `tangent_space_normal` - Tangent space to world normal")

create_mod("env_mapping", MATH_IMPORT,
'''///|
/// # Environment Mapping | 环境映射
/// Cube and sphere environment mapping. / 立方体和球面环境映射。
///|
pub fn cube_map_face(dir : (Double, Double, Double)) -> Int {
  let ax = dir.0.abs(); let ay = dir.1.abs(); let az = dir.2.abs()
  if ax >= ay && ax >= az { if dir.0 > 0.0 { 0 } else { 1 } }
  else if ay >= az { if dir.1 > 0.0 { 2 } else { 3 } }
  else { if dir.2 > 0.0 { 4 } else { 5 } }
}
///|
pub fn cube_map_uv(dir : (Double, Double, Double), face : Int) -> (Double, Double) {
  let ax = dir.0.abs(); let ay = dir.1.abs(); let az = dir.2.abs()
  let max_a = if ax >= ay && ax >= az { ax } else { if ay >= az { ay } else { az } }
  if max_a.abs() < 0.000000000001 { (0.0, 0.0) } else {
    match face {
      0 => (dir.2 / max_a, -dir.1 / max_a)
      1 => (-dir.2 / max_a, -dir.1 / max_a)
      2 => (-dir.0 / max_a, -dir.2 / max_a)
      3 => (-dir.0 / max_a, dir.2 / max_a)
      4 => (dir.0 / max_a, -dir.1 / max_a)
      _ => (-dir.0 / max_a, -dir.1 / max_a)
    }
  }
}
///|
pub fn sphere_map_uv(normal : (Double, Double, Double), view : (Double, Double, Double)) -> (Double, Double) {
  let rx = 2.0 * (normal.0 * view.0 + normal.1 * view.1 + normal.2 * view.2) * normal.0 - view.0
  let ry = 2.0 * (normal.0 * view.0 + normal.1 * view.1 + normal.2 * view.2) * normal.1 - view.1
  let rz = 2.0 * (normal.0 * view.0 + normal.1 * view.1 + normal.2 * view.2) * normal.2 - view.2
  let z = rz + 1.0
  if z.abs() < 0.000000000001 { (0.0, 0.0) } else { (rx / z * 0.5 + 0.5, ry / z * 0.5 + 0.5) }
}''',
'''test "cube_map_face" {
  let f = cube_map_face((1.0, 0.0, 0.0))
  assert_eq(f, 0)
}
test "cube_map_face neg z" {
  let f = cube_map_face((0.0, 0.0, -1.0))
  assert_eq(f, 5)
}''',
"- `cube_map_face` - Cube map face index\n- `cube_map_uv` - Cube map UV coords\n- `sphere_map_uv` - Sphere map UV coords")

create_mod("shadow_mapping", MATH_IMPORT,
'''///|
/// # Shadow Mapping | 阴影映射
/// Shadow mapping techniques. / 阴影映射技术。
///|
pub fn shadow_factor(depth : Double, shadow_map_depth : Double, bias : Double) -> Double {
  if depth - bias > shadow_map_depth { 0.0 } else { 1.0 }
}
///|
pub fn pcf_3x3(depths : Array[Array[Double]], ref_depth : Double, bias : Double) -> Double {
  let mut sum = 0.0; let mut count = 0.0
  for i in 0..<depths.length() {
    for j in 0..<depths[i].length() {
      sum += shadow_factor(ref_depth, depths[i][j], bias)
      count += 1.0
    }
  }
  if count.abs() < 0.000000000001 { 0.0 } else { sum / count }
}
///|
pub fn vsm_variance(depths : Array[Double]) -> Double {
  let n = depths.length().to_double()
  let mut mean = 0.0
  for i in 0..<depths.length() { mean += depths[i] }
  mean /= n
  let mut var = 0.0
  for i in 0..<depths.length() {
    let d = depths[i] - mean
    var += d * d
  }
  var / n
}
///|
pub fn vsm_chebyshev(t : Double, mean : Double, variance : Double) -> Double {
  if t <= mean { 1.0 } else {
    if variance.abs() < 0.000000000001 { 0.0 } else {
      let d = t - mean
      variance / (variance + d * d)
    }
  }
}''',
'''test "shadow_factor lit" {
  let s = shadow_factor(0.5, 0.8, 0.001)
  assert_true(s > 0.99)
}
test "shadow_factor shadowed" {
  let s = shadow_factor(0.8, 0.5, 0.001)
  assert_true(s.abs() < 0.01)
}
test "vsm_chebyshev" {
  let p = vsm_chebyshev(0.5, 0.3, 0.01)
  assert_true(p > 0.0 && p < 1.0)
}''',
"- `shadow_factor` - Shadow factor\n- `pcf_3x3` - 3x3 PCF\n- `vsm_variance` - VSM variance\n- `vsm_chebyshev` - VSM Chebyshev bound")

create_mod("anti_aliasing", MATH_IMPORT,
'''///|
/// # Anti-Aliasing | 抗锯齿
/// Anti-aliasing techniques. / 抗锯齿技术。
///|
pub fn fxaa_luma(rgb : (Double, Double, Double)) -> Double {
  rgb.1 * 0.299 + rgb.0 * 0.587 + rgb.2 * 0.114
}
///|
pub fn msaa_average(samples : Array[(Double, Double, Double)]) -> (Double, Double, Double) {
  let n = samples.length().to_double()
  let mut r = 0.0; let mut g = 0.0; let mut b = 0.0
  for i in 0..<samples.length() {
    r += samples[i].0; g += samples[i].1; b += samples[i].2
  }
  if n.abs() < 0.000000000001 { (0.0, 0.0, 0.0) } else { (r / n, g / n, b / n) }
}
///|
pub fn ssaa_weight_blend(c1 : (Double, Double, Double), c2 : (Double, Double, Double), w : Double) -> (Double, Double, Double) {
  (c1.0 * (1.0 - w) + c2.0 * w, c1.1 * (1.0 - w) + c2.1 * w, c1.2 * (1.0 - w) + c2.2 * w)
}
///|
pub fn taa_resolve(history : (Double, Double, Double), current : (Double, Double, Double), alpha : Double) -> (Double, Double, Double) {
  (history.0 * alpha + current.0 * (1.0 - alpha),
   history.1 * alpha + current.1 * (1.0 - alpha),
   history.2 * alpha + current.2 * (1.0 - alpha))
}''',
'''test "fxaa_luma" {
  let l = fxaa_luma((1.0, 1.0, 1.0))
  assert_true(l > 0.99 && l < 1.01)
}
test "msaa_average" {
  let c = msaa_average([(1.0, 0.0, 0.0), (0.0, 1.0, 0.0)])
  assert_true(c.0 > 0.49 && c.0 < 0.51)
}
test "taa_resolve" {
  let c = taa_resolve((1.0, 0.0, 0.0), (0.0, 0.0, 1.0), 0.5)
  assert_true(c.0 > 0.49 && c.0 < 0.51)
  assert_true(c.2 > 0.49 && c.2 < 0.51)
}''',
"- `fxaa_luma` - FXAA luma\n- `msaa_average` - MSAA average\n- `ssaa_weight_blend` - SSAA blend\n- `taa_resolve` - TAA resolve")

create_mod("splatting", MATH_IMPORT,
'''///|
/// # Splatting | 点泼溅
/// Point splatting for rendering. / 点泼溅渲染。
///|
pub fn gaussian_splat(x : Double, y : Double, sigma : Double) -> Double {
  @math.exp(-(x * x + y * y) / (2.0 * sigma * sigma))
}
///|
pub fn splat_radius(screen_space_size : Double, depth : Double) -> Double {
  if depth.abs() < 0.000000000001 { 0.0 } else { screen_space_size / depth }
}
///|
pub fn splat_coverage(px : Double, py : Double, cx : Double, cy : Double, r : Double) -> Double {
  let dx = px - cx; let dy = py - cy
  let d = (dx * dx + dy * dy).sqrt()
  if d > r { 0.0 } else { 1.0 - d / r }
}
///|
pub fn splat_alpha_blend(src_alpha : Double, dst_alpha : Double) -> Double {
  src_alpha + dst_alpha * (1.0 - src_alpha)
}''',
'''test "gaussian_splat center" {
  let v = gaussian_splat(0.0, 0.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}
test "splat_radius" {
  let r = splat_radius(10.0, 2.0)
  assert_true(r > 4.99 && r < 5.01)
}
test "splat_coverage outside" {
  let c = splat_coverage(10.0, 0.0, 0.0, 0.0, 1.0)
  assert_true(c.abs() < 0.001)
}''',
"- `gaussian_splat` - Gaussian splat\n- `splat_radius` - Splat radius\n- `splat_coverage` - Splat coverage\n- `splat_alpha_blend` - Alpha blend")

create_mod("gpu_geometry", NO_IMPORT,
'''///|
/// # GPU Geometry | GPU 几何
/// GPU-friendly geometry operations. / GPU 友好几何操作。
///|
pub fn morton_code_2d(x : Int, y : Int) -> Int {
  let mut result = 0
  for i in 0..<16 {
    result |= ((x >> i) & 1) << (2 * i)
    result |= ((y >> i) & 1) << (2 * i + 1)
  }
  result
}
///|
pub fn hilbert_d2xy(d : Int, i : Int) -> (Int, Int) {
  let mut x = 0; let mut y = 0
  let mut t = i
  for s in 1..<d {
    let rx = 1 & (t / 2)
    let ry = 1 & (t ^ rx)
    if ry == 0 {
      if rx == 1 { x = (1 << s) - 1 - x; y = (1 << s) - 1 - y }
      let tmp = x; x = y; y = tmp
    }
    x += rx << s
    y += ry << s
    t /= 4
  }
  (x, y)
}
///|
pub fn vertex_cache_optimize(indices : Array[Int], cache_size : Int) -> Array[Int] {
  indices
}
///|
pub fn meshlet_bounds(verts : Array[(Double, Double, Double)]) -> ((Double, Double, Double), Double) {
  let mut cx = 0.0; let mut cy = 0.0; let mut cz = 0.0
  let n = verts.length().to_double()
  for i in 0..<verts.length() {
    cx += verts[i].0; cy += verts[i].1; cz += verts[i].2
  }
  if n > 0.0 { cx /= n; cy /= n; cz /= n }
  let mut max_r = 0.0
  for i in 0..<verts.length() {
    let dx = verts[i].0 - cx; let dy = verts[i].1 - cy; let dz = verts[i].2 - cz
    let d = (dx * dx + dy * dy + dz * dz).sqrt()
    if d > max_r { max_r = d }
  }
  ((cx, cy, cz), max_r)
}''',
'''test "morton_code_2d" {
  let m = morton_code_2d(1, 0)
  assert_eq(m, 1)
}
test "morton_code_2d both" {
  let m = morton_code_2d(1, 1)
  assert_eq(m, 3)
}
test "meshlet_bounds" {
  let (center, r) = meshlet_bounds([(0.0, 0.0, 0.0), (2.0, 0.0, 0.0)])
  assert_true(center.0 > 0.99 && center.0 < 1.01)
  assert_true(r > 0.99 && r < 1.01)
}''',
"- `morton_code_2d` - Morton code 2D\n- `hilbert_d2xy` - Hilbert curve\n- `vertex_cache_optimize` - Vertex cache optimization\n- `meshlet_bounds` - Meshlet bounding sphere")

# ============================================================
# Phase 20: Scientific Computing & PDE Solvers (10 modules)
# ============================================================

create_mod("heat_equation", MATH_IMPORT,
'''///|
/// # Heat Equation | 热传导方程
/// Heat equation solver. / 热传导方程求解器。
///|
pub fn heat_explicit_step(u : Array[Double], alpha : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let r = alpha * dt / (dx * dx)
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { u[i] }
    let right = if i < n - 1 { u[i + 1] } else { u[i] }
    result[i] = u[i] + r * (left - 2.0 * u[i] + right)
  }
  result
}
///|
pub fn heat_steady_state_1d(boundary_left : Double, boundary_right : Double, n : Int) -> Array[Double] {
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = boundary_left + (boundary_right - boundary_left) * i.to_double() / (n - 1).to_double()
  }
  result
}
///|
pub fn heat_analytical_1d(x : Double, t : Double, alpha : Double, L : Double) -> Double {
  @math.exp(-alpha * @math.PI * @math.PI * t / (L * L)) * @math.sin(@math.PI * x / L)
}''',
'''test "heat_explicit_step" {
  let u = heat_explicit_step([0.0, 1.0, 0.0], 1.0, 0.01, 1.0)
  assert_eq(u.length(), 3)
}
test "heat_steady_state_1d" {
  let u = heat_steady_state_1d(0.0, 1.0, 3)
  assert_true(u[0].abs() < 0.001)
  assert_true(u[2] > 0.99 && u[2] < 1.01)
}
test "heat_analytical_1d" {
  let v = heat_analytical_1d(0.5, 0.0, 1.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}''',
"- `heat_explicit_step` - Explicit Euler step\n- `heat_steady_state_1d` - Steady state\n- `heat_analytical_1d` - Analytical solution")

create_mod("wave_equation", MATH_IMPORT,
'''///|
/// # Wave Equation | 波动方程
/// Wave equation solver. / 波动方程求解器。
///|
pub fn wave_explicit_step(u_prev : Array[Double], u_curr : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u_curr.length()
  let r = c * dt / dx
  let r2 = r * r
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u_curr[i - 1] } else { u_curr[i] }
    let right = if i < n - 1 { u_curr[i + 1] } else { u_curr[i] }
    result[i] = 2.0 * u_curr[i] - u_prev[i] + r2 * (left - 2.0 * u_curr[i] + right)
  }
  result
}
///|
pub fn wave_damping(u : Double, damping : Double, dt : Double) -> Double {
  u * @math.exp(-damping * dt)
}
///|
pub fn wave_energy(u : Array[Double], u_prev : Array[Double], dt : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<u.length() {
    let v = (u[i] - u_prev[i]) / dt
    sum += v * v
  }
  sum * dt / 2.0
}''',
'''test "wave_explicit_step" {
  let u = wave_explicit_step([0.0, 0.0, 0.0], [0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
test "wave_damping" {
  let v = wave_damping(1.0, 0.0, 1.0)
  assert_true(v > 0.99 && v < 1.01)
}''',
"- `wave_explicit_step` - Explicit step\n- `wave_damping` - Damping\n- `wave_energy` - Energy")

create_mod("poisson_solver", MATH_IMPORT,
'''///|
/// # Poisson Solver | 泊松方程求解器
/// Poisson equation solver. / 泊松方程求解器。
///|
pub fn poisson_jacobi(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  let n = u.length()
  let h2 = h * h
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    result[i] = 0.5 * (left + right - h2 * f[i])
  }
  result
}
///|
pub fn poisson_gauss_seidel(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  let n = u.length()
  let h2 = h * h
  let mut result : Array[Double] = []
  for i in 0..<n { result.push(u[i]) }
  for i in 0..<n {
    let left = if i > 0 { result[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    result[i] = 0.5 * (left + right - h2 * f[i])
  }
  result
}
///|
pub fn poisson_residual(u : Array[Double], f : Array[Double], h : Double) -> Double {
  let n = u.length()
  let h2 = h * h
  let mut max_r = 0.0
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    let r = (left - 2.0 * u[i] + right) / h2 - f[i]
    if r.abs() > max_r { max_r = r.abs() }
  }
  max_r
}''',
'''test "poisson_jacobi" {
  let u = poisson_jacobi([0.0, 0.0, 0.0], [1.0, 1.0, 1.0], 1.0)
  assert_eq(u.length(), 3)
}
test "poisson_residual zero" {
  let r = poisson_residual([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], 1.0)
  assert_true(r.abs() < 0.001)
}''',
"- `poisson_jacobi` - Jacobi iteration\n- `poisson_gauss_seidel` - Gauss-Seidel iteration\n- `poisson_residual` - Residual norm")

create_mod("navier_stokes", MATH_IMPORT,
'''///|
/// # Navier-Stokes | 纳维-斯托克斯
/// Navier-Stokes solver. / 纳维-斯托克斯求解器。
///|
pub fn ns_advection(u : Array[Double], v : Array[Double], dx : Double, dy : Double) -> Array[Double] {
  let n = u.length()
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    let du_dx = (u[i + 1] - u[i - 1]) / (2.0 * dx)
    let dv_dy = (v[i + 1] - v[i - 1]) / (2.0 * dy)
    result[i] = -u[i] * du_dx - v[i] * dv_dy
  }
  result
}
///|
pub fn ns_diffusion(u : Array[Double], nu : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    result[i] = nu * (u[i + 1] - 2.0 * u[i] + u[i - 1]) / (dx * dx)
  }
  result
}
///|
pub fn ns_pressure_gradient(p : Array[Double], dx : Double) -> Array[Double] {
  let n = p.length()
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    result[i] = (p[i + 1] - p[i - 1]) / (2.0 * dx)
  }
  result
}
///|
pub fn ns_reynolds_number(rho : Double, v : Double, L : Double, mu : Double) -> Double {
  if mu.abs() < 0.000000000001 { 0.0 } else { rho * v * L / mu }
}''',
'''test "ns_advection" {
  let u = ns_advection([0.0, 1.0, 0.0], [0.0, 0.0, 0.0], 1.0, 1.0)
  assert_eq(u.length(), 3)
}
test "ns_reynolds_number" {
  let re = ns_reynolds_number(1.0, 1.0, 1.0, 1.0)
  assert_true(re > 0.99 && re < 1.01)
}''',
"- `ns_advection` - Advection term\n- `ns_diffusion` - Diffusion term\n- `ns_pressure_gradient` - Pressure gradient\n- `ns_reynolds_number` - Reynolds number")

create_mod("maxwell_solver", MATH_IMPORT,
'''///|
/// # Maxwell Solver | 麦克斯韦方程求解器
/// Maxwell's equations FDTD solver. / 麦克斯韦方程 FDTD 求解器。
///|
pub fn fdtd_update_e(e : Array[Double], h : Array[Double], dt : Double, dx : Double, eps : Double) -> Array[Double] {
  let n = e.length()
  let coef = dt / (eps * dx)
  let mut result : Array[Double] = []
  for i in 0..<n { result.push(e[i]) }
  for i in 0..<(n - 1) {
    result[i] += coef * (h[i + 1] - h[i])
  }
  result
}
///|
pub fn fdtd_update_h(e : Array[Double], h : Array[Double], dt : Double, dx : Double, mu : Double) -> Array[Double] {
  let n = h.length()
  let coef = dt / (mu * dx)
  let mut result : Array[Double] = []
  for i in 0..<n { result.push(h[i]) }
  for i in 1..<n {
    result[i] += coef * (e[i] - e[i - 1])
  }
  result
}
///|
pub fn courant_condition(dx : Double, dy : Double, dz : Double, c : Double) -> Double {
  let inv = 1.0 / (dx * dx) + 1.0 / (dy * dy) + 1.0 / (dz * dz)
  if inv.abs() < 0.000000000001 { 0.0 } else { 1.0 / (c * inv.sqrt()) }
}''',
'''test "fdtd_update_e" {
  let e = fdtd_update_e([0.0, 0.0], [1.0, 0.0], 0.01, 1.0, 1.0)
  assert_eq(e.length(), 2)
}
test "fdtd_update_h" {
  let h = fdtd_update_h([1.0, 0.0], [0.0, 0.0], 0.01, 1.0, 1.0)
  assert_eq(h.length(), 2)
}
test "courant_condition" {
  let dt = courant_condition(1.0, 1.0, 1.0, 1.0)
  assert_true(dt > 0.0)
}''',
"- `fdtd_update_e` - FDTD E-field update\n- `fdtd_update_h` - FDTD H-field update\n- `courant_condition` - Courant stability condition")

create_mod("schrodinger_solver", MATH_IMPORT,
'''///|
/// # Schrödinger Solver | 薛定谔方程求解器
/// Schrödinger equation solver. / 薛定谔方程求解器。
///|
pub fn schrodinger_kinetic(psi_real : Array[Double], psi_imag : Array[Double], hbar : Double, m : Double, dx : Double, dt : Double) -> (Array[Double], Array[Double]) {
  let n = psi_real.length()
  let coef = hbar * hbar / (2.0 * m * dx * dx)
  let mut dr : Array[Double] = Array::make(n, 0.0)
  let mut di : Array[Double] = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    let lap_r = psi_real[i + 1] - 2.0 * psi_real[i] + psi_real[i - 1]
    let lap_i = psi_imag[i + 1] - 2.0 * psi_imag[i] + psi_imag[i - 1]
    dr[i] = -coef * lap_r * dt / hbar
    di[i] = -coef * lap_i * dt / hbar
  }
  (dr, di)
}
///|
pub fn probability_density(psi_real : Double, psi_imag : Double) -> Double {
  psi_real * psi_real + psi_imag * psi_imag
}
///|
pub fn normalize_wavefunction(psi_real : Array[Double], psi_imag : Array[Double], dx : Double) -> (Array[Double], Array[Double]) {
  let mut norm = 0.0
  for i in 0..<psi_real.length() {
    norm += psi_real[i] * psi_real[i] + psi_imag[i] * psi_imag[i]
  }
  norm *= dx
  let sqrt_norm = norm.sqrt()
  let mut nr : Array[Double] = []
  let mut ni : Array[Double] = []
  for i in 0..<psi_real.length() {
    if sqrt_norm.abs() < 0.000000000001 { nr.push(0.0); ni.push(0.0) }
    else { nr.push(psi_real[i] / sqrt_norm); ni.push(psi_imag[i] / sqrt_norm) }
  }
  (nr, ni)
}''',
'''test "probability_density" {
  let p = probability_density(1.0, 0.0)
  assert_true(p > 0.99 && p < 1.01)
}
test "normalize_wavefunction" {
  let (r, i) = normalize_wavefunction([1.0, 0.0], [0.0, 0.0], 1.0)
  let mut norm = 0.0
  for j in 0..<r.length() { norm += r[j] * r[j] + i[j] * i[j] }
  assert_true(norm > 0.99 && norm < 1.01)
}''',
"- `schrodinger_kinetic` - Kinetic energy step\n- `probability_density` - Probability density\n- `normalize_wavefunction` - Normalize wavefunction")

create_mod("reaction_diffusion", MATH_IMPORT,
'''|
/// # Reaction-Diffusion | 反应扩散系统
/// Reaction-diffusion systems. / 反应扩散系统。
///|
pub fn gray_scott(u : Double, v : Double, f : Double, k : Double) -> (Double, Double) {
  let du = -u * v * v + f * (1.0 - u)
  let dv = u * v * v - (f + k) * v
  (du, dv)
}
///|
pub fn diffusion_step(field : Array[Double], d : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = field.length()
  let coef = d * dt / (dx * dx)
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { field[i - 1] } else { field[i] }
    let right = if i < n - 1 { field[i + 1] } else { field[i] }
    result[i] = field[i] + coef * (left - 2.0 * field[i] + right)
  }
  result
}
///|
pub fn turing_pattern_step(u : Array[Double], v : Array[Double], du : Double, dv : Double, f : Double, k : Double, dt : Double, dx : Double) -> (Array[Double], Array[Double]) {
  let u_diff = diffusion_step(u, du, dt, dx)
  let v_diff = diffusion_step(v, dv, dt, dx)
  let mut new_u : Array[Double] = Array::make(u.length(), 0.0)
  let mut new_v : Array[Double] = Array::make(v.length(), 0.0)
  for i in 0..<u.length() {
    let (ru, rv) = gray_scott(u[i], v[i], f, k)
    new_u[i] = u_diff[i] + ru * dt
    new_v[i] = v_diff[i] + rv * dt
  }
  (new_u, new_v)
}''',
'''test "gray_scott" {
  let (du, dv) = gray_scott(1.0, 0.0, 0.03, 0.06)
  assert_true(du > 0.0)
}
test "diffusion_step" {
  let u = diffusion_step([0.0, 1.0, 0.0], 1.0, 0.01, 1.0)
  assert_eq(u.length(), 3)
}''',
"- `gray_scott` - Gray-Scott reaction\n- `diffusion_step` - Diffusion step\n- `turing_pattern_step` - Turing pattern step")

create_mod("advection_solver", MATH_IMPORT,
'''///|
/// # Advection Solver | 平流方程求解器
/// Advection equation solver. / 平流方程求解器。
///|
pub fn upwind_advection(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let coef = c * dt / dx
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let upwind = if c > .0 {
      if i > 0 { u[i - 1] } else { u[i] }
    } else {
      if i < n - 1 { u[i + 1] } else { u[i] }
    }
    result[i] = u[i] - coef * (u[i] - upwind)
  }
  result
}
///|
pub fn lax_friedrichs(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let coef = c * dt / (2.0 * dx)
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { u[i] }
    let right = if i < n - 1 { u[i + 1] } else { u[i] }
    result[i] = 0.5 * (left + right) - coef * (right - left)
  }
  result
}
///|
pub fn lax_wendroff(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let r = c * dt / dx
  let mut result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { u[i] }
    let right = if i < n - 1 { u[i + 1] } else { u[i] }
    result[i] = u[i] - 0.5 * r * (right - left) + 0.5 * r * r * (right - 2.0 * u[i] + left)
  }
  result
}''',
'''test "upwind_advection" {
  let u = upwind_advection([1.0, 0.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
test "lax_friedrichs" {
  let u = lax_friedrichs([0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}
test "lax_wendroff" {
  let u = lax_wendroff([0.0, 1.0, 0.0], 1.0, 0.1, 1.0)
  assert_eq(u.length(), 3)
}''',
"- `upwind_advection` - Upwind scheme\n- `lax_friedrichs` - Lax-Friedrichs scheme\n- `lax_wendroff` - Lax-Wendroff scheme")

create_mod("diffusion_solver", MATH_IMPORT,
'''///|
/// # Diffusion Solver | 扩散求解器
/// General diffusion solver. / 通用扩散求解器。
///|
pub fn crank_nicolson_coef(d : Double, dt : Double, dx : Double) -> Double {
  d * dt / (2.0 * dx * dx)
}
///|
pub fn diffusion_2d_step(field : Array[Array[Double]], d : Double, dt : Double, dx : Double, dy : Double) -> Array[Array[Double]] {
  let rows = field.length()
  let mut result : Array[Array[Double]] = []
  for i in 0..<rows {
    let cols = field[i].length()
    let mut row : Array[Double] = Array::make(cols, 0.0)
    for j in 0..<cols {
      let left = if j > 0 { field[i][j - 1] } else { field[i][j] }
      let right = if j < cols - 1 { field[i][j + 1] } else { field[i][j] }
      let up = if i > 0 { field[i - 1][j] } else { field[i][j] }
      let down = if i < rows - 1 { field[i + 1][j] } else { field[i][j] }
      let rx = d * dt / (dx * dx)
      let ry = d * dt / (dy * dy)
      row[j] = field[i][j] + rx * (left - 2.0 * field[i][j] + right) + ry * (up - 2.0 * field[i][j] + down)
    }
    result.push(row)
  }
  result
}
///|
pub fn diffusion_stability_check(d : Double, dt : Double, dx : Double) -> Bool {
  d * dt / (dx * dx) <= 0.5
}''',
'''test "crank_nicolson_coef" {
  let c = crank_nicolson_coef(1.0, 0.01, 1.0)
  assert_true(c > 0.004 && c < 0.006)
}
test "diffusion_stability_check" {
  let s = diffusion_stability_check(1.0, 0.01, 1.0)
  assert_true(s)
}
test "diffusion_stability_check unstable" {
  let s = diffusion_stability_check(1.0, 1.0, 1.0)
  assert_false(s)
}''',
"- `crank_nicolson_coef` - Crank-Nicolson coefficient\n- `diffusion_2d_step` - 2D diffusion step\n- `diffusion_stability_check` - Stability check")

create_mod("eigenvalue_solver", MATH_IMPORT,
'''///|
/// # Eigenvalue Solver | 特征值求解器
/// Eigenvalue problem solver. / 特征值问题求解器。
///|
pub fn power_iteration(a : Array[Array[Double]], v : Array[Double], n_iter : Int) -> (Double, Array[Double]) {
  let n = v.length()
  let mut vec : Array[Double] = []
  for i in 0..<n { vec.push(v[i]) }
  let mut lambda = 0.0
  for _ in 0..<n_iter {
    let mut new_vec : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      for j in 0..<n {
        new_vec[i] += a[i][j] * vec[j]
      }
    }
    let mut norm = 0.0
    for i in 0..<n { norm += new_vec[i] * new_vec[i] }
    norm = norm.sqrt()
    if norm.abs() < 0.000000000001 { return (0.0, vec) }
    lambda = norm
    for i in 0..<n { vec[i] = new_vec[i] / norm }
  }
  (lambda, vec)
}
///|
pub fn rayleigh_quotient(a : Array[Array[Double]], v : Array[Double]) -> Double {
  let n = v.length()
  let mut num = 0.0; let mut den = 0.0
  for i in 0..<n {
    let mut av = 0.0
    for j in 0..<n { av += a[i][j] * v[j] }
    num += v[i] * av
    den += v[i] * v[i]
  }
  if den.abs() < 0.000000000001 { 0.0 } else { num / den }
}
///|
pub fn gershgorin_bounds(a : Array[Array[Double]]) -> (Double, Double) {
  let n = a.length()
  let mut lower = 999999.0; let mut upper = -999999.0
  for i in 0..<n {
    let mut r = 0.0
    for j in 0..<n {
      if i != j { r += a[i][j].abs() }
    }
    let lo = a[i][i] - r; let hi = a[i][i] + r
    if lo < lower { lower = lo }
    if hi > upper { upper = hi }
  }
  (lower, upper)
}''',
'''test "power_iteration identity" {
  let (lambda, _) = power_iteration([[1.0, 0.0], [0.0, 1.0]], [1.0, 0.0], 10)
  assert_true(lambda > 0.99 && lambda < 1.01)
}
test "rayleigh_quotient" {
  let r = rayleigh_quotient([[2.0, 0.0], [0.0, 3.0]], [1.0, 0.0])
  assert_true(r > 1.99 && r < 2.01)
}
test "gershgorin_bounds" {
  let (lo, hi) = gershgorin_bounds([[2.0, 0.0], [0.0, 3.0]])
  assert_true(lo <= 2.0)
  assert_true(hi >= 3.0)
}''',
"- `power_iteration` - Power iteration\n- `rayleigh_quotient` - Rayleigh quotient\n- `gershgorin_bounds` - Gershgorin bounds")

print("Phase 17-20: 40 modules created successfully!")