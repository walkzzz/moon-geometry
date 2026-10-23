///|
/// Watershed result. / 分水岭结果。
pub type WatershedResult = @watershed.WatershedResult

pub fn marker_watershed(
  cols : Int,
  rows : Int,
  dem : Array[Double],
  markers : Array[Int],
) -> WatershedResult {
  @watershed.marker_watershed(cols, rows, dem, markers)
}

pub fn d8_flow_directions(
  cols : Int,
  rows : Int,
  dem : Array[Double],
) -> Array[Int] {
  @watershed.d8_flow_directions(cols, rows, dem)
}

pub fn basin_cell_counts(r : WatershedResult) -> Array[(Int, Int)] {
  @watershed.basin_cell_counts(r)
}

pub fn fill_depressions(
  cols : Int,
  rows : Int,
  dem : Array[Double],
) -> Array[Double] {
  @watershed.fill_depressions(cols, rows, dem)
}

pub fn watershed_result_cols(r : WatershedResult) -> Int {
  @watershed.WatershedResult::cols(r)
}

pub fn watershed_result_rows(r : WatershedResult) -> Int {
  @watershed.WatershedResult::rows(r)
}

pub fn watershed_result_get(r : WatershedResult, col : Int, row : Int) -> Int {
  @watershed.WatershedResult::get(r, col, row)
}

// ---------------------------------------------------------------------------
// delaunay_terrain: Terrain Delaunay / 地形 Delaunay
// ---------------------------------------------------------------------------


///|
/// Terrain from Delaunay triangulation. / Delaunay 三角剖分地形。
pub type Terrain = @delaunay_terrain.Terrain

pub fn build_terrain(points : Array[Point3D]) -> Terrain {
  @delaunay_terrain.build_terrain(points)
}

pub fn build_constrained_terrain(
  points : Array[Point3D],
  constraints : Array[(Int, Int)],
) -> Terrain {
  @delaunay_terrain.build_constrained_terrain(points, constraints)
}

pub fn terrain_point_count(t : Terrain) -> Int {
  @delaunay_terrain.Terrain::point_count(t)
}

pub fn terrain_triangle_count(t : Terrain) -> Int {
  @delaunay_terrain.Terrain::triangle_count(t)
}

pub fn terrain_average_slope(t : Terrain) -> Double {
  @delaunay_terrain.Terrain::average_slope(t)
}

pub fn terrain_aspect_at(t : Terrain, p : Point2D) -> Double? {
  @delaunay_terrain.Terrain::aspect_at(t, p)
}

pub fn terrain_slope_at(t : Terrain, p : Point2D) -> Double? {
  @delaunay_terrain.Terrain::slope_at(t, p)
}

pub fn terrain_surface_area(t : Terrain) -> Double {
  @delaunay_terrain.Terrain::surface_area(t)
}

pub fn terrain_constraint_count(t : Terrain) -> Int {
  @delaunay_terrain.Terrain::constraint_count(t)
}

// ---------------------------------------------------------------------------
// Phase 4: Shape Analysis & Descriptors / 形状分析与描述子
// ---------------------------------------------------------------------------


///|
/// === Phase 4: Shape Analysis & Descriptors ===

// --- shape_context ---

pub fn shape_context(
  points : Array[Point2D],
  n_r_bins : Int,
  n_theta_bins : Int,
) -> Array[Array[Double]] {
  @shape_context.shape_context(points, n_r_bins, n_theta_bins)
}

pub fn shape_context_distance(
  h1 : Array[Double],
  h2 : Array[Double],
) -> Double {
  @shape_context.shape_context_distance(h1, h2)
}

pub fn shape_context_cost(
  sc1 : Array[Array[Double]],
  sc2 : Array[Array[Double]],
) -> Array[Array[Double]] {
  @shape_context.shape_context_cost(sc1, sc2)
}

pub fn shape_context_match(
  source : Array[Point2D],
  target : Array[Point2D],
  n_r_bins : Int,
  n_theta_bins : Int,
) -> Array[Int] {
  @shape_context.shape_context_match(source, target, n_r_bins, n_theta_bins)
}

// --- fourier_descriptor ---

pub fn fourier_descriptors(points : Array[Point2D]) -> Array[(Double, Double)] {
  @fourier_descriptor.fourier_descriptors(points)
}

pub fn fourier_invariant(points : Array[Point2D]) -> Array[Double] {
  @fourier_descriptor.fourier_invariant(points)
}

pub fn fourier_reconstruct(
  coeffs : Array[(Double, Double)],
  n : Int,
) -> Array[Point2D] {
  @fourier_descriptor.fourier_reconstruct(coeffs, n)
}

pub fn fourier_truncate(
  coeffs : Array[(Double, Double)],
  k : Int,
) -> Array[(Double, Double)] {
  @fourier_descriptor.fourier_truncate(coeffs, k)
}

// --- moment_invariants ---

pub fn raw_moment(points : Array[Point2D], p : Int, q : Int) -> Double {
  @moment_invariants.raw_moment(points, p, q)
}

pub fn moment_centroid(points : Array[Point2D]) -> (Point2D, Double) {
  @moment_invariants.centroid(points)
}

pub fn central_moment(points : Array[Point2D], p : Int, q : Int) -> Double {
  @moment_invariants.central_moment(points, p, q)
}

pub fn normalized_moment(points : Array[Point2D], p : Int, q : Int) -> Double {
  @moment_invariants.normalized_moment(points, p, q)
}

pub fn hu_moments(points : Array[Point2D]) -> Array[Double] {
  @moment_invariants.hu_moments(points)
}

pub fn zernike_moment(
  points : Array[Point2D],
  n : Int,
  m : Int,
) -> (Double, Double) {
  @moment_invariants.zernike_moment(points, n, m)
}

pub fn zernike_magnitude(points : Array[Point2D], n : Int, m : Int) -> Double {
  @moment_invariants.zernike_magnitude(points, n, m)
}

// --- skeleton_3d ---

pub fn voxel_index(x : Int, y : Int, z : Int, nx : Int, ny : Int) -> Int {
  @skeleton_3d.voxel_index(x, y, z, nx, ny)
}

pub fn count_6_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  @skeleton_3d.count_6_neighbors(voxels, x, y, z, nx, ny, nz)
}

pub fn count_26_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  @skeleton_3d.count_26_neighbors(voxels, x, y, z, nx, ny, nz)
}

pub fn is_boundary_voxel(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  @skeleton_3d.is_boundary(voxels, x, y, z, nx, ny, nz)
}

pub fn skeleton_3d(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  @skeleton_3d.skeleton_3d(voxels, nx, ny, nz)
}

pub fn skeleton_volume(voxels : Array[Bool]) -> Int {
  @skeleton_3d.skeleton_volume(voxels)
}

pub fn skeleton_endpoints(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  @skeleton_3d.skeleton_endpoints(voxels, nx, ny, nz)
}

pub fn skeleton_field(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  @skeleton_3d.skeleton_field(voxels, nx, ny, nz)
}

// --- medial_axis_3d ---


///|
/// Medial ball in 3D. / 三维中轴球。
pub type MedialBall3D = @medial_axis_3d.MedialBall3D

pub fn medial_ball_3d_new(center : Point3D, radius : Double) -> MedialBall3D {
  @medial_axis_3d.MedialBall3D::new(center, radius)
}

pub fn medial_ball_3d_center(ball : MedialBall3D) -> Point3D {
  @medial_axis_3d.MedialBall3D::center(ball)
}

pub fn medial_ball_3d_radius(ball : MedialBall3D) -> Double {
  @medial_axis_3d.MedialBall3D::radius(ball)
}

pub fn medial_axis_from_pairs(points : Array[Point3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_from_pairs(points)
}

pub fn medial_axis_from_triples(points : Array[Point3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_from_triples(points)
}

pub fn medial_axis_3d(points : Array[Point3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_3d(points)
}

pub fn medial_axis_filter(
  balls : Array[MedialBall3D],
  r_min : Double,
  r_max : Double,
) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_filter(balls, r_min, r_max)
}

pub fn medial_axis_sort(balls : Array[MedialBall3D]) -> Array[MedialBall3D] {
  @medial_axis_3d.medial_axis_sort(balls)
}

// --- shape_matching ---

pub fn hungarian(cost : Array[Array[Double]]) -> Array[Int] {
  @shape_matching.hungarian(cost)
}

pub fn shape_matching_icp(
  source : Array[Point2D],
  target : Array[Point2D],
  max_iter : Int,
) -> Array[Int] {
  @shape_matching.shape_matching_icp(source, target, max_iter)
}

pub fn shape_matching_hungarian(
  source : Array[Point2D],
  target : Array[Point2D],
) -> Array[Int] {
  @shape_matching.shape_matching_hungarian(source, target)
}

pub fn shape_matching_score(
  source : Array[Point2D],
  target : Array[Point2D],
) -> Double {
  @shape_matching.shape_matching_score(source, target)
}

// --- curvature_scale ---

pub fn gaussian_smooth(points : Array[Point2D], sigma : Double) -> Array[Point2D] {
  @curvature_scale.gaussian_smooth(points, sigma)
}

pub fn css_curvature(points : Array[Point2D], sigma : Double) -> Array[Double] {
  @curvature_scale.css_curvature(points, sigma)
}

pub fn css_inflection_points(
  points : Array[Point2D],
  sigma : Double,
) -> Array[Int] {
  @curvature_scale.css_inflection_points(points, sigma)
}

pub fn css_image(
  points : Array[Point2D],
  n_sigmas : Int,
) -> Array[(Double, Int)] {
  @curvature_scale.css_image(points, n_sigmas)
}

pub fn css_maxima(points : Array[Point2D], n_sigmas : Int) -> Array[Double] {
  @curvature_scale.css_maxima(points, n_sigmas)
}

// --- bend_energy ---

pub fn bend_energy(points : Array[Point2D]) -> Double {
  @bend_energy.bend_energy(points)
}

pub fn bend_energy_open(points : Array[Point2D]) -> Double {
  @bend_energy.bend_energy_open(points)
}

pub fn total_curvature_energy(points : Array[Point2D]) -> Double {
  @bend_energy.total_curvature_energy(points)
}

pub fn elastic_energy(points : Array[Point2D], tension : Double) -> Double {
  @bend_energy.elastic_energy(points, tension)
}

pub fn curve_length(points : Array[Point2D]) -> Double {
  @bend_energy.curve_length(points)
}

pub fn normalized_bend_energy(points : Array[Point2D]) -> Double {
  @bend_energy.normalized_bend_energy(points)
}

// --- procrustes ---


///|
/// Procrustes alignment result. / Procrustes 对齐结果。
pub type ProcrustesResult = @procrustes.ProcrustesResult

pub fn procrustes_result_new(
  rotation : Double,
  tx : Double,
  ty : Double,
  scale : Double,
  error : Double,
) -> ProcrustesResult {
  @procrustes.ProcrustesResult::new(rotation, tx, ty, scale, error)
}

pub fn procrustes_result_rotation(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::rotation(r)
}

pub fn procrustes_result_tx(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::tx(r)
}

pub fn procrustes_result_ty(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::ty(r)
}

pub fn procrustes_result_scale(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::scale(r)
}

pub fn procrustes_result_error(r : ProcrustesResult) -> Double {
  @procrustes.ProcrustesResult::error(r)
}

pub fn procrustes(src : Array[Point2D], tgt : Array[Point2D]) -> ProcrustesResult {
  @procrustes.procrustes(src, tgt)
}

pub fn procrustes_apply(
  src : Array[Point2D],
  result : ProcrustesResult,
) -> Array[Point2D] {
  @procrustes.procrustes_apply(src, result)
}

pub fn procrustes_error(src : Array[Point2D], tgt : Array[Point2D]) -> Double {
  @procrustes.procrustes_error(src, tgt)
}

pub fn procrustes_analyze(
  shapes : Array[Array[Point2D]],
  max_iter : Int,
) -> Array[Array[Point2D]] {
  @procrustes.procrustes_analyze(shapes, max_iter)
}

// --- icp ---


///|
/// ICP registration result. / ICP 配准结果。
pub type IcpResult = @icp.IcpResult

pub fn icp_result_new(
  rotation : Array[Double],
  translation : Point3D,
  error : Double,
  iterations : Int,
) -> IcpResult {
  @icp.IcpResult::new(rotation, translation, error, iterations)
}

pub fn icp_result_rotation(r : IcpResult) -> Array[Double] {
  @icp.IcpResult::rotation(r)
}

pub fn icp_result_translation(r : IcpResult) -> Point3D {
  @icp.IcpResult::translation(r)
}

pub fn icp_result_error(r : IcpResult) -> Double {
  @icp.IcpResult::error(r)
}

pub fn icp_result_iterations(r : IcpResult) -> Int {
  @icp.IcpResult::iterations(r)
}

pub fn icp_point_to_point(
  source : Array[Point3D],
  target : Array[Point3D],
  max_iter : Int,
) -> IcpResult {
  @icp.icp_point_to_point(source, target, max_iter)
}

pub fn icp_point_to_plane(
  source : Array[Point3D],
  target : Array[Point3D],
  normals : Array[Point3D],
  max_iter : Int,
) -> IcpResult {
  @icp.icp_point_to_plane(source, target, normals, max_iter)
}

pub fn icp_apply(points : Array[Point3D], result : IcpResult) -> Array[Point3D] {
  @icp.icp_apply(points, result)
}

pub fn icp_rms_error(
  source : Array[Point3D],
  target : Array[Point3D],
) -> Double {
  @icp.icp_rms_error(source, target)
}
// ---------------------------------------------------------------------------
// quadratic_prog: Quadratic programming / 二次规划
// ---------------------------------------------------------------------------

///|
pub type QPResult = @quadratic_prog.QPResult