///|
pub type DxfEntity = @dxf_io.DxfEntity

///|
pub type DxfDocument = @dxf_io.DxfDocument

pub fn dxf_document_new() -> DxfDocument {
  @dxf_io.DxfDocument::new()
}

pub fn dxf_document_entity_count(d : DxfDocument) -> Int {
  @dxf_io.DxfDocument::entity_count(d)
}

pub fn dxf_write(doc : DxfDocument) -> String {
  @dxf_io.dxf_write(doc)
}

pub fn dxf_parse(text : String) -> DxfDocument {
  @dxf_io.dxf_parse(text)
}
// ---------------------------------------------------------------------------
// ray_tracing: Ray tracing / 光线追踪
// ---------------------------------------------------------------------------

///|
pub type Ray3 = @ray_tracing.Ray3

pub fn ray3_new(origin : Point3D, dir : Point3D) -> Ray3 {
  @ray_tracing.Ray3::new(origin, dir)
}

pub fn ray3_eval(r : Ray3, t : Double) -> Point3D {
  @ray_tracing.ray_eval(r, t)
}

pub fn ray_triangle_intersect(
  r : Ray3,
  v0 : Point3D,
  v1 : Point3D,
  v2 : Point3D,
) -> Double? {
  @ray_tracing.ray_triangle_intersect(r, v0, v1, v2)
}

pub fn ray_sphere_intersect(
  r : Ray3,
  center : Point3D,
  radius : Double,
) -> Double? {
  @ray_tracing.ray_sphere_intersect(r, center, radius)
}

pub fn ray_plane_intersect(
  r : Ray3,
  point : Point3D,
  normal : Point3D,
) -> Double? {
  @ray_tracing.ray_plane_intersect(r, point, normal)
}

pub fn point_in_shadow(
  point : Point3D,
  light : Point3D,
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> Bool {
  @ray_tracing.point_in_shadow(point, light, triangles)
}

pub fn ray_nearest_triangle(
  r : Ray3,
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> (Double, Int)? {
  @ray_tracing.ray_nearest_triangle(r, triangles)
}
// ---------------------------------------------------------------------------
// marching_cubes: Marching Cubes / 移动立方体
// ---------------------------------------------------------------------------

///|
pub type McGrid = @marching_cubes.McGrid

pub fn mc_grid_new(
  values : Array[Double],
  nx : Int,
  ny : Int,
  nz : Int,
) -> McGrid {
  @marching_cubes.McGrid::new(values, nx, ny, nz)
}

pub fn mc_grid_get(g : McGrid, i : Int, j : Int, k : Int) -> Double {
  @marching_cubes.McGrid::get(g, i, j, k)
}

pub fn marching_cubes(
  grid : McGrid,
  isolevel : Double,
) -> Array[(Point3D, Point3D, Point3D)] {
  @marching_cubes.marching_cubes(grid, isolevel)
}

pub fn marching_cubes_count(grid : McGrid, isolevel : Double) -> Int {
  @marching_cubes.marching_cubes_count(grid, isolevel)
}

pub fn cube_config_class(cube_idx : Int) -> Int {
  @marching_cubes.cube_config_class(cube_idx)
}

pub fn count_active_configs(grid : McGrid, isolevel : Double) -> Int {
  @marching_cubes.count_active_configs(grid, isolevel)
}
// ---------------------------------------------------------------------------
// hidden_line: Hidden line removal / 隐藏线消除
// ---------------------------------------------------------------------------

///|
pub type LineSeg3D = @hidden_line.LineSeg3D

pub fn line_seg_3d_new(start : Point3D, end : Point3D) -> LineSeg3D {
  @hidden_line.LineSeg3D::new(start, end)
}

pub fn project_to_2d(p : Point3D) -> Point2D {
  @hidden_line.project_to_2d(p)
}

pub fn project_segment(s : LineSeg3D) -> (Point2D, Point2D) {
  @hidden_line.project_segment(s)
}

pub fn point_in_triangle_2d(
  p : Point2D,
  a : Point2D,
  b : Point2D,
  c : Point2D,
) -> Bool {
  @hidden_line.point_in_triangle_2d(p, a, b, c)
}

pub fn triangle_z_at(
  tri : (Point3D, Point3D, Point3D),
  x : Double,
  y : Double,
) -> Double? {
  @hidden_line.triangle_z_at(tri, x, y)
}

pub fn hidden_line_remove(
  segments : Array[LineSeg3D],
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> Array[(Point2D, Point2D)] {
  @hidden_line.hidden_line_remove(segments, triangles)
}

pub fn count_visible(
  segments : Array[LineSeg3D],
  triangles : Array[(Point3D, Point3D, Point3D)],
) -> Int {
  @hidden_line.count_visible(segments, triangles)
}

pub fn back_face_cull(
  triangles : Array[(Point3D, Point3D, Point3D)],
  view_dir : Point3D,
) -> Array[(Point3D, Point3D, Point3D)] {
  @hidden_line.back_face_cull(triangles, view_dir)
}
// ---------------------------------------------------------------------------
// rasterization: Rasterization / 光栅化
// ---------------------------------------------------------------------------

///|
pub type RasterBuffer = @rasterization.RasterBuffer

pub fn raster_buffer_new(width : Int, height : Int) -> RasterBuffer {
  @rasterization.RasterBuffer::new(width, height)
}

pub fn clear_buffer(buf : RasterBuffer, color : Int, depth : Double) -> Unit {
  @rasterization.clear_buffer(buf, color, depth)
}

pub fn set_pixel(buf : RasterBuffer, x : Int, y : Int, color : Int) -> Unit {
  @rasterization.set_pixel(buf, x, y, color)
}

pub fn set_pixel_depth(
  buf : RasterBuffer,
  x : Int,
  y : Int,
  color : Int,
  depth : Double,
) -> Unit {
  @rasterization.set_pixel_depth(buf, x, y, color, depth)
}

pub fn get_pixel(buf : RasterBuffer, x : Int, y : Int) -> Int {
  @rasterization.get_pixel(buf, x, y)
}

pub fn get_depth(buf : RasterBuffer, x : Int, y : Int) -> Double {
  @rasterization.get_depth(buf, x, y)
}

pub fn raster_line(
  buf : RasterBuffer,
  x0 : Int,
  y0 : Int,
  x1 : Int,
  y1 : Int,
  color : Int,
) -> Unit {
  @rasterization.raster_line(buf, x0, y0, x1, y1, color)
}

pub fn raster_triangle(
  buf : RasterBuffer,
  v0 : Point3D,
  v1 : Point3D,
  v2 : Point3D,
  color : Int,
) -> Unit {
  @rasterization.raster_triangle(buf, v0, v1, v2, color)
}

pub fn count_filled(buf : RasterBuffer, bg : Int) -> Int {
  @rasterization.count_filled(buf, bg)
}

// ========== point_cloud ==========
pub fn point_cloud_centroid(points : Array[@core.Point3D]) -> @core.Point3D {
  @point_cloud.point_cloud_centroid(points)
}
pub fn point_cloud_aabb(points : Array[@core.Point3D]) -> (@core.Point3D, @core.Point3D) {
  @point_cloud.point_cloud_aabb(points)
}
pub fn voxel_downsample(points : Array[@core.Point3D], voxel_size : Double) -> Array[@core.Point3D] {
  @point_cloud.voxel_downsample(points, voxel_size)
}
pub fn avg_nearest_neighbor_dist(points : Array[@core.Point3D]) -> Double {
  @point_cloud.avg_nearest_neighbor_dist(points)
}
pub fn point_cloud_size(points : Array[@core.Point3D]) -> Int {
  @point_cloud.point_cloud_size(points)
}

// ========== voxel_grid ==========
pub type VoxelGrid = @voxel_grid.VoxelGrid
pub fn vg_voxel_index(grid : VoxelGrid, p : @core.Point3D) -> Int {
  @voxel_grid.voxel_index(grid, p)
}
pub fn voxel_set(grid : VoxelGrid, p : @core.Point3D) -> VoxelGrid {
  @voxel_grid.voxel_set(grid, p)
}
pub fn voxel_occupied(grid : VoxelGrid, p : @core.Point3D) -> Bool {
  @voxel_grid.voxel_occupied(grid, p)
}
pub fn voxel_count_occupied(grid : VoxelGrid) -> Int {
  @voxel_grid.voxel_count_occupied(grid)
}

// ========== normal_est ==========
pub fn pc_estimate_normal(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> @core.Point3D {
  @normal_est.estimate_normal(center, neighbors)
}
pub fn normalize_normal(n : @core.Point3D) -> @core.Point3D {
  @normal_est.normalize_normal(n)
}
pub fn orient_normal(normal : @core.Point3D, ref_dir : @core.Point3D) -> @core.Point3D {
  @normal_est.orient_normal(normal, ref_dir)
}

// ========== curvature_est ==========
pub fn estimate_mean_curvature(center : @core.Point3D, neighbors : Array[@core.Point3D], normals : Array[@core.Point3D], center_normal : @core.Point3D) -> Double {
  @curvature_est.estimate_mean_curvature(center, neighbors, normals, center_normal)
}
pub fn estimate_gaussian_curvature(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> Double {
  @curvature_est.estimate_gaussian_curvature(center, neighbors)
}
pub fn pc_principal_curvatures(k_gaussian : Double, k_mean : Double) -> (Double, Double) {
  @curvature_est.principal_curvatures(k_gaussian, k_mean)
}

// ========== pc_segment ==========
pub fn segment_by_height(points : Array[@core.Point3D], threshold : Double) -> (Array[Int], Array[Int]) {
  @pc_segment.segment_by_height(points, threshold)
}
pub fn segment_by_distance(points : Array[@core.Point3D], max_dist : Double) -> Array[Array[Int]] {
  @pc_segment.segment_by_distance(points, max_dist)
}
pub fn segment_count(clusters : Array[Array[Int]]) -> Int {
  @pc_segment.segment_count(clusters)
}

// ========== pc_feature ==========
pub fn local_density(points : Array[@core.Point3D], center : @core.Point3D, radius : Double) -> Int {
  @pc_feature.local_density(points, center, radius)
}
pub fn curvature_feature(eigenvalues : Array[Double]) -> Double {
  @pc_feature.curvature_feature(eigenvalues)
}
pub fn planarity_feature(eigenvalues : Array[Double]) -> Double {
  @pc_feature.planarity_feature(eigenvalues)
}
pub fn scattering_feature(eigenvalues : Array[Double]) -> Double {
  @pc_feature.scattering_feature(eigenvalues)
}

// ========== pc_filter ==========
pub fn statistical_filter(points : Array[@core.Point3D], k : Int, threshold : Double) -> Array[Int] {
  @pc_filter.statistical_filter(points, k, threshold)
}
pub fn radius_filter(points : Array[@core.Point3D], radius : Double, min_neighbors : Int) -> Array[Int] {
  @pc_filter.radius_filter(points, radius, min_neighbors)
}
pub fn removed_count(original : Int, kept : Int) -> Int {
  @pc_filter.removed_count(original, kept)
}

// ========== pc_transform ==========
pub fn translate_cloud(points : Array[@core.Point3D], dx : Double, dy : Double, dz : Double) -> Array[@core.Point3D] {
  @pc_transform.translate_cloud(points, dx, dy, dz)
}
pub fn scale_cloud(points : Array[@core.Point3D], factor : Double) -> Array[@core.Point3D] {
  @pc_transform.scale_cloud(points, factor)
}
pub fn rotate_z_cloud(points : Array[@core.Point3D], angle : Double) -> Array[@core.Point3D] {
  @pc_transform.rotate_z_cloud(points, angle)
}
pub fn center_cloud(points : Array[@core.Point3D]) -> Array[@core.Point3D] {
  @pc_transform.center_cloud(points)
}

// ========== simplicial_complex ==========
pub type SimplicialComplex = @simplicial_complex.SimplicialComplex
pub fn simplex_count(sc : SimplicialComplex) -> Int {
  @simplicial_complex.simplex_count(sc)
}
pub fn complex_dimension(sc : SimplicialComplex) -> Int {
  @simplicial_complex.complex_dimension(sc)
}
pub fn is_valid_complex(sc : SimplicialComplex) -> Bool {
  @simplicial_complex.is_valid_complex(sc)
}
pub fn add_simplex(sc : SimplicialComplex, vertices : Array[Int]) -> SimplicialComplex {
  @simplicial_complex.add_simplex(sc, vertices)
}

// ========== cech_complex ==========
pub fn cech_complex_simplices(n_points : Int, max_dim : Int) -> Array[Array[Int]] {
  @cech_complex.cech_complex_simplices(n_points, max_dim)
}
pub fn cech_nerve(balls : Int) -> Array[Array[Int]] {
  @cech_complex.cech_nerve(balls)
}
pub fn cech_dimension(max_dim : Int) -> Int {
  @cech_complex.cech_dimension(max_dim)
}

// ========== exact_predicates ==========
pub fn exact_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  @exact_predicates.exact_orientation(a, b, c)
}
pub fn exact_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  @exact_predicates.exact_incircle(a, b, c, d)
}
pub fn exact_left_turn(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  @exact_predicates.exact_left_turn(a, b, c)
}
pub fn exact_collinear(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Bool {
  @exact_predicates.exact_collinear(a, b, c)
}

// ========== interval_arithmetic ==========
pub type IAInterval = @interval_arithmetic.Interval
pub fn interval_add(a : IAInterval, b : IAInterval) -> IAInterval {
  @interval_arithmetic.interval_add(a, b)
}
pub fn interval_sub(a : IAInterval, b : IAInterval) -> IAInterval {
  @interval_arithmetic.interval_sub(a, b)
}
pub fn interval_mul(a : IAInterval, b : IAInterval) -> IAInterval {
  @interval_arithmetic.interval_mul(a, b)
}
pub fn ia_interval_contains(i : IAInterval, x : Double) -> Bool {
  @interval_arithmetic.interval_contains(i, x)
}
pub fn interval_width(i : IAInterval) -> Double {
  @interval_arithmetic.interval_width(i)
}
pub fn ia_interval_midpoint(i : IAInterval) -> Double {
  @interval_arithmetic.interval_midpoint(i)
}

// ========== filtered_predicates ==========
pub fn filtered_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  @filtered_predicates.filtered_orientation(a, b, c)
}
pub fn filtered_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  @filtered_predicates.filtered_incircle(a, b, c, d)
}
pub fn perturbation_orientation(det : Double, eps : Double) -> Int {
  @filtered_predicates.perturbation_orientation(det, eps)
}

// ========== perturbation ==========
pub fn sos_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, ia : Int, ib : Int, ic : Int) -> Int {
  @perturbation.sos_orientation(a, b, c, ia, ib, ic)
}
pub fn sos_sign(det : Double, perturbation_order : Int) -> Int {
  @perturbation.sos_sign(det, perturbation_order)
}
pub fn sos_compare(a : Double, b : Double, ia : Int, ib : Int) -> Int {
  @perturbation.sos_compare(a, b, ia, ib)
}

// ========== robust_construction ==========
pub fn robust_circumcenter(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> @core.Point2D {
  @robust_construction.robust_circumcenter(a, b, c)
}
pub fn robust_intersection(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> @core.Point2D {
  @robust_construction.robust_intersection(a, b, c, d)
}
pub fn robust_midpoint(a : @core.Point2D, b : @core.Point2D) -> @core.Point2D {
  @robust_construction.robust_midpoint(a, b)
}

// ========== big_rational ==========
pub type Rational = @big_rational.Rational
pub fn rational_add(a : Rational, b : Rational) -> Rational {
  @big_rational.rational_add(a, b)
}
pub fn rational_mul(a : Rational, b : Rational) -> Rational {
  @big_rational.rational_mul(a, b)
}
pub fn rational_to_double(r : Rational) -> Double {
  @big_rational.rational_to_double(r)
}
pub fn rational_equal(a : Rational, b : Rational) -> Bool {
  @big_rational.rational_equal(a, b)
}
pub fn rational_sub(a : Rational, b : Rational) -> Rational {
  @big_rational.rational_sub(a, b)
}

// ========== de9im ==========
pub fn de9im_intersects(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_intersects(a_bounds, b_bounds)
}
pub fn de9im_contains(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_contains(a_bounds, b_bounds)
}
pub fn de9im_disjoint(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_disjoint(a_bounds, b_bounds)
}
pub fn de9im_touches(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_touches(a_bounds, b_bounds)
}
pub fn de9im_within(a_bounds : (@core.Point2D, @core.Point2D), b_bounds : (@core.Point2D, @core.Point2D)) -> Bool {
  @de9im.de9im_within(a_bounds, b_bounds)
}

// ========== lazy_exact ==========
pub type LazyExact = @lazy_exact.LazyExact
pub fn lazy_value(le : LazyExact) -> Double {
  @lazy_exact.lazy_value(le)
}
pub fn lazy_approx(le : LazyExact) -> Double {
  @lazy_exact.lazy_approx(le)
}
pub fn lazy_error(le : LazyExact) -> Double {
  @lazy_exact.lazy_error(le)
}

// ========== rounded_geometry ==========
pub fn round_double(x : Double, precision : Int) -> Double {
  @rounded_geometry.round_double(x, precision)
}
pub fn rounded_area(points : Array[@core.Point2D], precision : Int) -> Double {
  @rounded_geometry.rounded_area(points, precision)
}
pub fn rounded_length(a : @core.Point2D, b : @core.Point2D, precision : Int) -> Double {
  @rounded_geometry.rounded_length(a, b, precision)
}

// ========== affine_arithmetic ==========
pub type AffineForm = @affine_arithmetic.AffineForm
pub fn affine_add(a : AffineForm, b : AffineForm) -> AffineForm {
  @affine_arithmetic.affine_add(a, b)
}
pub fn affine_to_interval(a : AffineForm) -> (Double, Double) {
  @affine_arithmetic.affine_to_interval(a)
}
pub fn affine_scale(a : AffineForm, s : Double) -> AffineForm {
  @affine_arithmetic.affine_scale(a, s)
}

// ========== rational_map ==========
pub type RationalMap = @rational_map.RationalMap
pub fn rational_eval(m : RationalMap, x : Double) -> Double {
  @rational_map.rational_eval(m, x)
}
pub fn rational_degree(m : RationalMap) -> Int {
  @rational_map.rational_degree(m)
}
pub fn rational_is_defined(m : RationalMap, x : Double) -> Bool {
  @rational_map.rational_is_defined(m, x)
}

// ========== discrete_curvature ==========
pub fn discrete_gaussian_curvature(angle_defect : Double) -> Double {
  @discrete_curvature.discrete_gaussian_curvature(angle_defect)
}
pub fn discrete_mean_curvature(area : Double, edge_lengths : Array[Double], dihedral_angles : Array[Double]) -> Double {
  @discrete_curvature.discrete_mean_curvature(area, edge_lengths, dihedral_angles)
}
pub fn angle_defect(angles : Array[Double]) -> Double {
  @discrete_curvature.angle_defect(angles)
}
pub fn voronoi_area(edge_len : Double) -> Double {
  @discrete_curvature.voronoi_area(edge_len)
}
pub fn mixed_area(a1 : Double, a2 : Double) -> Double {
  @discrete_curvature.mixed_area(a1, a2)
}

// ========== discrete_laplacian ==========
pub fn uniform_laplacian(values : Array[Double], neighbors : Array[Double]) -> Double {
  @discrete_laplacian.uniform_laplacian(values, neighbors)
}
pub fn cotangent_weight(cot_a : Double, cot_b : Double) -> Double {
  @discrete_laplacian.cotangent_weight(cot_a, cot_b)
}
pub fn cotangent_laplacian(center_val : Double, neighbor_vals : Array[Double], weights : Array[Double]) -> Double {
  @discrete_laplacian.cotangent_laplacian(center_val, neighbor_vals, weights)
}
pub fn laplacian_eigenvalue(mode : Int, area : Double) -> Double {
  @discrete_laplacian.laplacian_eigenvalue(mode, area)
}
pub fn is_harmonic(laplacian_val : Double, tol : Double) -> Bool {
  @discrete_laplacian.is_harmonic(laplacian_val, tol)
}

// ========== conformal_map ==========
pub fn conformal_factor(scale_x : Double, scale_y : Double) -> Double {
  @conformal_map.conformal_factor(scale_x, scale_y)
}
pub fn is_conformal(j11 : Double, j12 : Double, j21 : Double, j22 : Double, tol : Double) -> Bool {
  @conformal_map.is_conformal(j11, j12, j21, j22, tol)
}
pub fn conformal_energy(stretch_u : Double, stretch_v : Double) -> Double {
  @conformal_map.conformal_energy(stretch_u, stretch_v)
}
pub fn angle_distortion(theta_before : Double, theta_after : Double) -> Double {
  @conformal_map.angle_distortion(theta_before, theta_after)
}
pub fn cm_area_distortion(area_before : Double, area_after : Double) -> Double {
  @conformal_map.area_distortion(area_before, area_after)
}

// ========== persistence_diagram ==========
pub type PersistencePoint = @persistence_diagram.PersistencePoint
pub fn persistence(p : PersistencePoint) -> Double {
  @persistence_diagram.persistence(p)
}
pub fn is_essential(p : PersistencePoint) -> Bool {
  @persistence_diagram.is_essential(p)
}
pub fn diagram_dimension(diagram : Array[PersistencePoint]) -> Int {
  @persistence_diagram.diagram_dimension(diagram)
}
pub fn max_persistence(diagram : Array[PersistencePoint]) -> Double {
  @persistence_diagram.max_persistence(diagram)
}

// ========== finite_element ==========
pub fn element_stiffness(grad_u : (Double, Double), grad_v : (Double, Double), area : Double) -> Double {
  @finite_element.element_stiffness(grad_u, grad_v, area)
}
pub fn element_mass(u_val : Double, v_val : Double, area : Double) -> Double {
  @finite_element.element_mass(u_val, v_val, area)
}
pub fn assemble_stiffness(n : Int, elements : Array[(Int, Int, Int, Double)]) -> Array[Array[Double]] {
  @finite_element.assemble_stiffness(n, elements)
}
pub fn apply_dirichlet(k : Array[Array[Double]], boundary_nodes : Array[Int]) -> Array[Array[Double]] {
  @finite_element.apply_dirichlet(k, boundary_nodes)
}
pub fn fem_l2_error(exact : Array[Double], approx : Array[Double]) -> Double {
  @finite_element.fem_l2_error(exact, approx)
}

// ========== boundary_element ==========
pub fn fundamental_solution_2d(r : Double) -> Double {
  @boundary_element.fundamental_solution_2d(r)
}
pub fn boundary_integral_kernel(r : Double, normal_dist : Double) -> Double {
  @boundary_element.boundary_integral_kernel(r, normal_dist)
}
pub fn bem_matrix_entry(r : Double, weight : Double) -> Double {
  @boundary_element.bem_matrix_entry(r, weight)
}
pub fn bem_solve(matrix : Array[Array[Double]], rhs : Array[Double]) -> Array[Double] {
  @boundary_element.bem_solve(matrix, rhs)
}
pub fn bem_error(exact : Array[Double], approx : Array[Double]) -> Double {
  @boundary_element.bem_error(exact, approx)
}

// ========== level_set ==========
pub fn level_set_sign(phi : Double) -> Int {
  @level_set.level_set_sign(phi)
}
pub fn level_set_normal(grad_phi : (Double, Double)) -> (Double, Double) {
  @level_set.level_set_normal(grad_phi)
}
pub fn level_set_curvature(grad : (Double, Double), hessian : (Double, Double, Double)) -> Double {
  @level_set.level_set_curvature(grad, hessian)
}
pub fn reinitialize_step(phi : Double, dt : Double, s0 : Int) -> Double {
  @level_set.reinitialize_step(phi, dt, s0)
}
pub fn level_set_area(phi : Array[Double], dx : Double) -> Double {
  @level_set.level_set_area(phi, dx)
}

// ========== fast_marching ==========
pub fn solve_eikonal_2d(u_left : Double, u_down : Double, f : Double, h : Double) -> Double {
  @fast_marching.solve_eikonal_2d(u_left, u_down, f, h)
}
pub fn fast_marching_step(narrow_band : Array[(Int, Double)], f : Double, h : Double) -> Array[(Int, Double)] {
  @fast_marching.fast_marching_step(narrow_band, f, h)
}
pub fn is_far(value : Double) -> Bool {
  @fast_marching.is_far(value)
}
pub fn is_frozen(value : Double) -> Bool {
  @fast_marching.is_frozen(value)
}

// ========== fast_sweeping ==========
pub fn sweep_update(u_center : Double, u_neighbor1 : Double, u_neighbor2 : Double, f : Double, h : Double) -> Double {
  @fast_sweeping.sweep_update(u_center, u_neighbor1, u_neighbor2, f, h)
}
pub fn fast_sweeping_iterate(u : Array[Double], f : Array[Double], h : Double, nx : Int, ny : Int) -> Array[Double] {
  @fast_sweeping.fast_sweeping_iterate(u, f, h, nx, ny)
}
pub fn sweeping_converged(u_old : Array[Double], u_new : Array[Double], tol : Double) -> Bool {
  @fast_sweeping.sweeping_converged(u_old, u_new, tol)
}

// ========== ray_trace_ops ==========
pub fn reflect(incident : (Double, Double, Double), normal : (Double, Double, Double)) -> (Double, Double, Double) {
  @ray_trace_ops.reflect(incident, normal)
}
pub fn refract(incident : (Double, Double, Double), normal : (Double, Double, Double), eta : Double) -> (Double, Double, Double) {
  @ray_trace_ops.refract(incident, normal, eta)
}
pub fn fresnel_schlick(cos_theta : Double, f0 : Double) -> Double {
  @ray_trace_ops.fresnel_schlick(cos_theta, f0)
}
pub fn ray_plane_t(origin : (Double, Double, Double), dir : (Double, Double, Double), point : (Double, Double, Double), normal : (Double, Double, Double)) -> Double {
  @ray_trace_ops.ray_plane_t(origin, dir, point, normal)
}

// ========== raster_2d ==========
pub fn bresenham_line(x0 : Int, y0 : Int, x1 : Int, y1 : Int) -> Array[(Int, Int)] {
  @raster_2d.bresenham_line(x0, y0, x1, y1)
}
pub fn edge_function(a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Double {
  @raster_2d.edge_function(a, b, c)
}
pub fn barycentric_coord(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> (Double, Double, Double) {
  @raster_2d.barycentric_coord(p, a, b, c)
}
pub fn point_in_triangle(p : (Double, Double), a : (Double, Double), b : (Double, Double), c : (Double, Double)) -> Bool {
  @raster_2d.point_in_triangle(p, a, b, c)
}

// ========== gpu_geometry ==========
pub fn morton_code_2d(x : Int, y : Int) -> Int {
  @gpu_geometry.morton_code_2d(x, y)
}
pub fn hilbert_d2xy(d : Int, i : Int) -> (Int, Int) {
  @gpu_geometry.hilbert_d2xy(d, i)
}
pub fn vertex_cache_optimize(indices : Array[Int], cache_size_ : Int) -> Array[Int] {
  @gpu_geometry.vertex_cache_optimize(indices, cache_size_)
}
pub fn meshlet_bounds(verts : Array[(Double, Double, Double)]) -> ((Double, Double, Double), Double) {
  @gpu_geometry.meshlet_bounds(verts)
}

// ========== heat_equation ==========
pub fn he_heat_explicit_step(u : Array[Double], alpha : Double, dt : Double, dx : Double) -> Array[Double] {
  @heat_equation.heat_explicit_step(u, alpha, dt, dx)
}
pub fn heat_steady_state_1d(boundary_left : Double, boundary_right : Double, n : Int) -> Array[Double] {
  @heat_equation.heat_steady_state_1d(boundary_left, boundary_right, n)
}
pub fn heat_analytical_1d(x : Double, t : Double, alpha : Double, length : Double) -> Double {
  @heat_equation.heat_analytical_1d(x, t, alpha, length)
}

// ========== wave_equation ==========
pub fn we_wave_explicit_step(u_prev : Array[Double], u_curr : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @wave_equation.wave_explicit_step(u_prev, u_curr, c, dt, dx)
}
pub fn we_wave_damping(u : Double, damping : Double, dt : Double) -> Double {
  @wave_equation.wave_damping(u, damping, dt)
}
pub fn we_wave_energy(u : Array[Double], u_prev : Array[Double], dt : Double) -> Double {
  @wave_equation.wave_energy(u, u_prev, dt)
}

// ========== poisson_solver ==========
pub fn ps_poisson_jacobi(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  @poisson_solver.poisson_jacobi(u, f, h)
}
pub fn poisson_gauss_seidel(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  @poisson_solver.poisson_gauss_seidel(u, f, h)
}
pub fn ps_poisson_residual(u : Array[Double], f : Array[Double], h : Double) -> Double {
  @poisson_solver.poisson_residual(u, f, h)
}

// ========== navier_stokes ==========
pub fn ns_ns_advection(u : Array[Double], v : Array[Double], dx : Double, dy : Double) -> Array[Double] {
  @navier_stokes.ns_advection(u, v, dx, dy)
}
pub fn ns_diffusion(u : Array[Double], nu : Double, dx : Double) -> Array[Double] {
  @navier_stokes.ns_diffusion(u, nu, dx)
}
pub fn ns_pressure_gradient(p : Array[Double], dx : Double) -> Array[Double] {
  @navier_stokes.ns_pressure_gradient(p, dx)
}
pub fn ns_reynolds_number(rho : Double, v : Double, length : Double, mu : Double) -> Double {
  @navier_stokes.ns_reynolds_number(rho, v, length, mu)
}

// ========== advection_solver ==========
pub fn as_upwind_advection(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @advection_solver.upwind_advection(u, c, dt, dx)
}
pub fn lax_friedrichs(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @advection_solver.lax_friedrichs(u, c, dt, dx)
}
pub fn lax_wendroff(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  @advection_solver.lax_wendroff(u, c, dt, dx)
}

// ========== diffusion_solver ==========
pub fn crank_nicolson_coef(d : Double, dt : Double, dx : Double) -> Double {
  @diffusion_solver.crank_nicolson_coef(d, dt, dx)
}
pub fn ds_diffusion_2d_step(field : Array[Array[Double]], d : Double, dt : Double, dx : Double, dy : Double) -> Array[Array[Double]] {
  @diffusion_solver.diffusion_2d_step(field, d, dt, dx, dy)
}
pub fn ds_diffusion_stability_check(d : Double, dt : Double, dx : Double) -> Bool {
  @diffusion_solver.diffusion_stability_check(d, dt, dx)
}

// ========== geometric_algebra ==========
pub type Multivector = @geometric_algebra.Multivector
pub fn multivector_new(scalar : Double, e1 : Double, e2 : Double, e12 : Double) -> Multivector {
  @geometric_algebra.Multivector::new(scalar, e1, e2, e12)
}
pub fn multivector_add(self_val : Multivector, other : Multivector) -> Multivector {
  @geometric_algebra.Multivector::add(self_val, other)
}
pub fn multivector_mul(self_val : Multivector, other : Multivector) -> Multivector {
  @geometric_algebra.Multivector::mul(self_val, other)
}
pub fn multivector_reverse(self_val : Multivector) -> Multivector {
  @geometric_algebra.Multivector::reverse(self_val)
}
pub fn multivector_norm(self_val : Multivector) -> Double {
  @geometric_algebra.Multivector::norm(self_val)
}
pub fn ga_rotor(angle : Double) -> Multivector {
  @geometric_algebra.rotor(angle)
}
pub fn ga_rotate_vector(vx : Double, vy : Double, angle : Double) -> (Double, Double) {
  @geometric_algebra.rotate_vector(vx, vy, angle)
}

// ========== discrete_diff_geom ==========
pub fn discrete_connection(edges : Array[Double]) -> Double {
  @discrete_diff_geom.discrete_connection(edges)
}
pub fn ddg_holonomy(angles : Array[Double]) -> Double {
  @discrete_diff_geom.holonomy(angles)
}
pub fn ddg_parallel_transport(vx : Double, vy : Double, angle : Double) -> (Double, Double) {
  @discrete_diff_geom.parallel_transport(vx, vy, angle)
}
pub fn discrete_curvature2d(angles : Array[Double]) -> Double {
  @discrete_diff_geom.discrete_curvature2d(angles)
}
pub fn gauss_map_normals(angles : Array[Double]) -> Array[Double] {
  @discrete_diff_geom.gauss_map_normals(angles)
}

// ========== knot_theory ==========
pub fn crossing_number(crossings : Array[Int]) -> Int {
  @knot_theory.crossing_number(crossings)
}
pub fn writhe(signs : Array[Int]) -> Int {
  @knot_theory.writhe(signs)
}
pub fn jones_unknot(t : Double) -> Double {
  @knot_theory.jones_unknot(t)
}
pub fn jones_trefoil(t : Double) -> Double {
  @knot_theory.jones_trefoil(t)
}
pub fn jones_figure8(t : Double) -> Double {
  @knot_theory.jones_figure8(t)
}
pub fn linking_number(loop1 : Array[(Double, Double, Double)], loop2 : Array[(Double, Double, Double)]) -> Int {
  @knot_theory.linking_number(loop1, loop2)
}
pub fn unknotting_number(genus : Int) -> Int {
  @knot_theory.unknotting_number(genus)
}

// ========== geom_arrangement ==========
pub fn line_arrangement_count(n : Int) -> Int {
  @geom_arrangement.line_arrangement_count(n)
}
pub fn ga_line_intersection(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double) {
  @geom_arrangement.line_intersection(a1, b1, c1, a2, b2, c2)
}
pub fn ga_zone_complexity(n : Int) -> Int {
  @geom_arrangement.zone_complexity(n)
}
pub fn arrangement_faces(n : Int) -> Int {
  @geom_arrangement.arrangement_faces(n)
}
pub fn hyperplane_arrangement_regions(n : Int, d : Int) -> Int {
  @geom_arrangement.hyperplane_arrangement_regions(n, d)
}
pub fn is_simple_arrangement(slopes : Array[Double]) -> Bool {
  @geom_arrangement.is_simple_arrangement(slopes)
}

// ========== exact_pred ==========
pub fn ep_exact_orientation(x_a : Double, y_a : Double, x_b : Double, y_b : Double, x_c : Double, y_c : Double) -> Int {
  @exact_pred.exact_orientation(x_a, y_a, x_b, y_b, x_c, y_c)
}
pub fn ep_exact_incircle(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double, dx : Double, dy : Double) -> Int {
  @exact_pred.exact_incircle(ax, ay, bx, by, cx, cy, dx, dy)
}
pub fn exact_left_of_line(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  @exact_pred.exact_left_of_line(px, py, ax, ay, bx, by)
}
pub fn ep_exact_collinear(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Bool {
  @exact_pred.exact_collinear(ax, ay, bx, by, cx, cy)
}

// ========== robust_arith ==========
pub fn two_sum(a : Double, b : Double) -> (Double, Double) {
  @robust_arith.two_sum(a, b)
}
pub fn two_prod(a : Double, b : Double) -> (Double, Double) {
  @robust_arith.two_prod(a, b)
}
pub fn fast_two_sum(a : Double, b : Double) -> (Double, Double) {
  @robust_arith.fast_two_sum(a, b)
}
pub fn grow_expansion(e : Array[Double], b : Double) -> Array[Double] {
  @robust_arith.grow_expansion(e, b)
}
pub fn expansion_sum(e : Array[Double]) -> Double {
  @robust_arith.expansion_sum(e)
}

// ========== filtered_pred ==========
pub fn static_filter_bound(coords : Array[Double]) -> Double {
  @filtered_pred.static_filter_bound(coords)
}
pub fn fp_filtered_orientation(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  @filtered_pred.filtered_orientation(ax, ay, bx, by, cx, cy)
}
pub fn dynamic_filter(a : Double, b : Double, eps : Double) -> Bool {
  @filtered_pred.dynamic_filter(a, b, eps)
}
pub fn filter_result(det : Double, bound : Double) -> Int {
  @filtered_pred.filter_result(det, bound)
}

// ========== interval_arith ==========
pub type GeoInterval = @interval_arith.GeoInterval
pub fn geo_interval_new(center : Double, radius : Double) -> GeoInterval {
  @interval_arith.GeoInterval::new(center, radius)
}
pub fn geo_interval_add(self_val : GeoInterval, other : GeoInterval) -> GeoInterval {
  @interval_arith.GeoInterval::add(self_val, other)
}
pub fn geo_interval_sub(self_val : GeoInterval, other : GeoInterval) -> GeoInterval {
  @interval_arith.GeoInterval::sub(self_val, other)
}
pub fn geo_interval_mul(self_val : GeoInterval, other : GeoInterval) -> GeoInterval {
  @interval_arith.GeoInterval::mul(self_val, other)
}
pub fn geo_interval_contains(self_val : GeoInterval, val : Double) -> Bool {
  @interval_arith.GeoInterval::contains(self_val, val)
}
pub fn geo_interval_overlaps(self_val : GeoInterval, other : GeoInterval) -> Bool {
  @interval_arith.GeoInterval::overlaps(self_val, other)
}

// ========== adaptive_pred ==========
pub fn adaptive_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  @adaptive_pred.adaptive_orient2d(ax, ay, bx, by, cx, cy)
}
pub fn adaptive_incircle(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double, dx : Double, dy : Double) -> Int {
  @adaptive_pred.adaptive_incircle(ax, ay, bx, by, cx, cy, dx, dy)
}
pub fn precision_level(det : Double, bound : Double) -> Int {
  @adaptive_pred.precision_level(det, bound)
}

// ========== expansion_arith ==========
pub fn scale_expansion(e : Array[Double], b : Double) -> Array[Double] {
  @expansion_arith.scale_expansion(e, b)
}
pub fn compress_expansion(e : Array[Double]) -> Array[Double] {
  @expansion_arith.compress_expansion(e)
}
pub fn expansion_length(e : Array[Double]) -> Int {
  @expansion_arith.expansion_length(e)
}
pub fn expansion_norm(e : Array[Double]) -> Double {
  @expansion_arith.expansion_norm(e)
}
pub fn expansion_negate(e : Array[Double]) -> Array[Double] {
  @expansion_arith.expansion_negate(e)
}

// ========== robust_inter ==========
pub fn robust_segment_intersect(a1x : Double, a1y : Double, a2x : Double, a2y : Double, b1x : Double, b1y : Double, b2x : Double, b2y : Double) -> (Double, Double, Bool) {
  @robust_inter.robust_segment_intersect(a1x, a1y, a2x, a2y, b1x, b1y, b2x, b2y)
}
pub fn robust_line_line(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double, Bool) {
  @robust_inter.robust_line_line(a1, b1, c1, a2, b2, c2)
}
pub fn robust_point_on_segment(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  @robust_inter.robust_point_on_segment(px, py, ax, ay, bx, by)
}

// ========== robust_orient ==========
pub fn robust_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  @robust_orient.robust_orient2d(ax, ay, bx, by, cx, cy)
}
pub fn robust_orient3d(ax : Double, ay : Double, az : Double, bx : Double, by : Double, bz : Double, cx : Double, cy : Double, cz : Double, dx : Double, dy : Double, dz : Double) -> Int {
  @robust_orient.robust_orient3d(ax, ay, az, bx, by, bz, cx, cy, cz, dx, dy, dz)
}
pub fn robust_sign(val : Double, tol : Double) -> Int {
  @robust_orient.robust_sign(val, tol)
}
pub fn robust_compare(a : Double, b : Double, tol : Double) -> Int {
  @robust_orient.robust_compare(a, b, tol)
}

// ========== isoperimetric ==========
pub fn isoperimetric_ratio(perimeter : Double, area : Double) -> Double {
  @isoperimetric.isoperimetric_ratio(perimeter, area)
}
pub fn isoperimetric_deficit(perimeter : Double, area : Double) -> Double {
  @isoperimetric.isoperimetric_deficit(perimeter, area)
}
pub fn circle_area_from_perimeter(p : Double) -> Double {
  @isoperimetric.circle_area_from_perimeter(p)
}
pub fn circle_perimeter_from_area(a : Double) -> Double {
  @isoperimetric.circle_perimeter_from_area(a)
}
pub fn optimal_shape_area(perimeter : Double) -> Double {
  @isoperimetric.optimal_shape_area(perimeter)
}
pub fn is_isoperimetric_optimal(perimeter : Double, area : Double) -> Bool {
  @isoperimetric.is_isoperimetric_optimal(perimeter, area)
}

// ========== geom_prob ==========
pub fn buffon_needle_probability(needle_length : Double, line_spacing : Double) -> Double {
  @geom_prob.buffon_needle_probability(needle_length, line_spacing)
}
pub fn bertrand_probability(mode : Int) -> Double {
  @geom_prob.bertrand_probability(mode)
}
pub fn random_chord_length(radius : Double) -> Double {
  @geom_prob.random_chord_length(radius)
}
pub fn geometric_probability_hit(area_target : Double, area_total : Double) -> Double {
  @geom_prob.geometric_probability_hit(area_target, area_total)
}
pub fn expected_distance_unit_square() -> Double {
  @geom_prob.expected_distance_unit_square()
}
pub fn coverage_probability(n : Int, area_ratio : Double) -> Double {
  @geom_prob.coverage_probability(n, area_ratio)
}

// ========== random_geom_graph ==========
pub fn connectivity_threshold(n : Int, area : Double) -> Double {
  @random_geom_graph.connectivity_threshold(n, area)
}
pub fn percolation_threshold_2d() -> Double {
  @random_geom_graph.percolation_threshold_2d()
}
pub fn coverage_threshold(n : Int, area : Double) -> Double {
  @random_geom_graph.coverage_threshold(n, area)
}
pub fn expected_degree(n : Int, radius : Double, area : Double) -> Double {
  @random_geom_graph.expected_degree(n, radius, area)
}
pub fn isolation_probability(n : Int, radius : Double, area : Double) -> Double {
  @random_geom_graph.isolation_probability(n, radius, area)
}

// ========== geom_hash ==========
pub fn hash_point_2d(x : Double, y : Double, grid_size : Double) -> (Int, Int) {
  @geom_hash.hash_point_2d(x, y, grid_size)
}
pub fn hash_basis_invariant(p1x : Double, p1y : Double, p2x : Double, p2y : Double, p3x : Double, p3y : Double) -> (Double, Double) {
  @geom_hash.hash_basis_invariant(p1x, p1y, p2x, p2y, p3x, p3y)
}
pub fn hash_key(x : Double, y : Double, bins : Int) -> Int {
  @geom_hash.hash_key(x, y, bins)
}
pub fn similarity_score(h1 : Array[Int], h2 : Array[Int]) -> Double {
  @geom_hash.similarity_score(h1, h2)
}

// ========== fractal_gen ==========
pub fn mandelbrot_escape(cx : Double, cy : Double, max_iter : Int) -> Int {
  @fractal_gen.mandelbrot_escape(cx, cy, max_iter)
}
pub fn julia_escape(zx : Double, zy : Double, cx : Double, cy : Double, max_iter : Int) -> Int {
  @fractal_gen.julia_escape(zx, zy, cx, cy, max_iter)
}
pub fn ifs_contractive_factor(scales : Array[Double]) -> Double {
  @fractal_gen.ifs_contractive_factor(scales)
}
pub fn fractal_dimension_box(counts : Array[(Double, Int)]) -> Double {
  @fractal_gen.fractal_dimension_box(counts)
}
pub fn koch_curve_length(iteration : Int, base_length : Double) -> Double {
  @fractal_gen.koch_curve_length(iteration, base_length)
}

