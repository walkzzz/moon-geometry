# Moon Geometry

> 纯 MoonBit 计算几何库 | 2026 MoonBit 十月赛参赛项目
> Pure MoonBit computational geometry library | 2026 MoonBit October Hackathon entry

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MoonBit](https://img.shields.io/badge/MoonBit-0.1.20260920-blue.svg)](https://moonbitlang.com)
[![Tests](https://img.shields.io/badge/tests-2518-brightgreen.svg)]()
[![Targets](https://img.shields.io/badge/targets-native%20%7C%20wasm--gc%20%7C%20js%20%7C%20wasm-green.svg)]()

Moon Geometry 是一个**纯 MoonBit** 实现的计算几何库，**零 C FFI 依赖**，四目标（native / wasm-gc / js / wasm）原生支持。为 CAD、碰撞检测、GIS、路径规划、图像处理等场景提供可复用的几何算法基础组件。

Moon Geometry is a **pure MoonBit** computational geometry library with **zero C FFI dependencies**, supporting all four backends natively. It provides reusable geometric algorithm primitives for CAD, collision detection, GIS, path planning, and image processing.

## 特性 | Features

- **基础几何类型 | Basic types**: `Point2D` / `Point3D` / `Segment` / `Line` / `Polygon` / `Triangle` / `Circle` / `Rectangle`
- **凸包 | Convex hull**: Graham scan, Andrew's monotone chain (O(n log n)) | Graham 扫描法、Andrew 单调链法
- **多边形操作 | Polygon ops**: area (Shoelace), perimeter, centroid, point-in-polygon, convexity, orientation, Douglas-Peucker | 面积、周长、质心、点在多边形内、凸性判断、方向判定、Douglas-Peucker 简化
- **Delaunay 三角剖分 | Delaunay triangulation**: Bowyer-Watson incremental insertion (O(n²) expected) | Bowyer-Watson 增量插入法
- **Voronoi 图 | Voronoi diagram**: Delaunay duality, circumcenters as vertices | Delaunay 对偶，外心为顶点
- **几何变换 | Transforms**: translate, rotate, scale, affine, mirror, shear | 平移、旋转、缩放、仿射、镜像、剪切
- **距离计算 | Distance**: point-to-segment/polygon, segment-to-segment, polygon-to-polygon | 点到线段/多边形、线段间、多边形间
- **包围体 | Bounding**: AABB, min-area bounding rect (rotating calipers), bounding circle | 轴对齐包围盒、最小面积包围矩形、包围圆
- **圆相交 | Circle intersection**: circle-segment, circle-circle, circle-line, circle-polygon | 圆与线段/圆/直线/多边形相交
- **多边形三角剖分 | Polygon triangulation**: ear clipping for simple polygons | ear clipping 简单多边形三角剖分
- **Minkowski 运算 | Minkowski ops**: sum/difference of convex polygons, collision detection | 凸多边形 Minkowski 和/差、碰撞检测
- **旋转卡壳 | Rotating calipers**: convex polygon diameter, width, farthest pair, min-perimeter rect | 凸多边形直径、宽度、最远点对、最小周长矩形
- **椭圆几何 | Ellipse**: area, perimeter, eccentricity, foci, contains, line intersection | 面积、周长、离心率、焦点、包含、直线相交
- **贝塞尔曲线 | Bezier**: quadratic/cubic eval, derivative, length, bbox, subdivide | 二次/三次求值、导数、弧长、包围盒、细分
- **几何拟合 | Fitting**: least-squares line/circle fit, orthogonal regression, centroid | 最小二乘直线/圆拟合、正交回归、质心
- **扫描线 | Sweep line**: segment intersection detection, simple polygon test | 线段相交检测、简单多边形检测
- **凸多边形操作 | Convex polygon**: O(log n) point query, tangent, SAT intersect, support function | O(log n) 点查询、切线、SAT 相交、支持函数
- **统一导入 | Unified import**: `import "walkzzz/moon-geometry"` re-exports all APIs | 单包导入重导出全部 API
- **纯 MoonBit 零依赖 | Pure MoonBit, zero deps**: no C FFI, single codebase for all targets | 无 C FFI，四目标共用代码库
- **退化情况全覆盖 | Full degenerate coverage**: collinear, coincident, empty, single/two-point | 共线点、重合点、空输入、单点/两点退化

## 安装 | Installation

```bash
moon add walkzzz/moon-geometry
```

## 项目结构 | Project Structure

283 个模块按 24 个领域分类组织 | 283 modules organized into 24 domain categories：

```
src/
  base/          # (30) 基础类型与鲁棒算术 | Core types & robust arithmetic
                  #   core, vector, matrix, matrix3d, angle, constants, interval,
                  #   hash, compare, sort_search, random_gen, polynomial, linalg, root_find,
                  #   robust_arith, robust_orient, robust_inter, robust_construction,
                  #   exact_pred, exact_predicates, filtered_pred, filtered_predicates,
                  #   adaptive_pred, expansion_arith, affine_arithmetic, interval_arith,
                  #   interval_arithmetic, lazy_exact, big_rational, perturbation
  shapes/        # (2)  基本形状 | Basic shapes: ray, plane
  hull/          # (18) 凸包 | Convex hull & convex geometry
                  #   hull, convex_polygon, convex_hull3d, convex_hull_3d_dynamic,
                  #   convex_hull_approx, convex_hull_dynamic, convex_layers,
                  #   concave_hull, convex_width, convex_diameter, convex_center,
                  #   convex_intersection, convex_clip, convex_sum, convex_decomp,
                  #   polar_dual, support, separating
  polygon/       # (26) 多边形算法 | Polygon algorithms
                  #   polygon, boolean, de9im, ear_clip, monotone, half_plane,
                  #   minkowski, rotating_calipers, sweep_line, triangulate, overlay, zone,
                  #   polygon_offset, polygon_holes, polygon_kernel, polygon_skeleton,
                  #   polygon_medial, polygon_simplify, polygon_round, polygon_evolve,
                  #   polygon_morph, polygon_decomp_opt, polygon_triangulate_fast,
                  #   polygon_symmetry, polygon_cover, isoperimetric
  arrangement/   # (12) 平面细分 | Planar subdivision & triangulation
                  #   arrangement, geom_arrangement, dcel, planar_graph, triangulation,
                  #   voronoi_adv, voronoi_3d, delaunay_3d, constrained_delaunay,
                  #   power_diagram, centroidal_voronoi, delaunay_terrain
  transform/     # (14) 几何变换 | Geometric transforms
                  #   transform, affine2, rigid, similarity, homography, perspective,
                  #   stereographic, inversion, conformal_map, rational_map, procrustes,
                  #   registration, coordinate_convert, datum_transform
  distance/      # (11) 距离度量 | Distance metrics
                  #   distance, nearest, hausdorff, frechet, chamfer, emd, bottleneck,
                  #   bottleneck_dist, dtw, geodesic_dist, wasserstein_dist
  spatial/       # (22) 空间数据结构 | Spatial data structures
                  #   bounding, aabb_tree, aabb3d, bounding_sphere, obb, bvh,
                  #   kdtree, quadtree, octree, rtree, ball_tree, vp_tree, cover_tree,
                  #   metric_tree, interval_tree, grid_index, range_tree, spatial_hash,
                  #   bucket_pr, skip_quadtree, loose_octree, voxel_grid
  curves/        # (24) 曲线与样条 | Curves & splines
                  #   circle_ops, ellipse, bezier, bezier_clipping, bezier_surface,
                  #   bspline, nurbs, catmull_rom, hermite, lagrange, spline, polyline,
                  #   arc_length, curve_arc, curve_intersect, curvature, curvature_est,
                  #   curvature_scale, implicit_curve, interpolation, dubins, reed_shepp,
                  #   path_smooth, l_system
  mesh/          # (25) 网格与曲面 | Mesh & surface processing
                  #   mesh_data, mesh_simplify, mesh_smooth, mesh_normal, mesh_subdiv,
                  #   mesh_quality, mesh_repair, mesh_param, mesh_boolean, polyhedron,
                  #   polyhedron_boolean, face_extract, marching_cubes, skeleton_3d,
                  #   medial_axis_3d, reconstruction, watershed, surface_mesh, surface_param,
                  #   surface_recon, surface_loft, surface_revolve, surface_sweep,
                  #   surface_trim, surface_ricci
  topology/      # (27) 拓扑数据分析 | Topological data analysis
                  #   alpha_complex, betti_numbers, persistent_homology, persistence_diagram,
                  #   persistence_image, persistence_landscape, reeb_graph, morse_complex,
                  #   discrete_morse, euler_char, simplicial_complex, chain_complex,
                  #   boundary_operator, cohomology, homology_group, filtration, cech_complex,
                  #   nerve_theorem, witness_complex, zigzag_persistence, multidim_persistence,
                  #   tda_features, mapper_algo, knot_theory, sheaf_theory, chow_ring,
                  #   hilbert_function
  optim/         # (25) 数值优化 | Numerical optimization
                  #   optim, linear_prog, quadratic_prog, simplex_method, interior_point,
                  #   gradient_descent, newton_method, levenberg_marquardt, conjugate_gradient,
                  #   trust_region, sqp, sdp, socp, eigen, eigenvalue_solver,
                  #   simulated_annealing, genetic_algorithm, pso, cmaes, bayesian_opt,
                  #   branch_bound, nsga2, pareto_front, augmented_lagrangian, geom_opt
  robotics/      # (20) 机器人与运动规划 | Robotics & motion planning
                  #   rrt, rrt_star, prm, prm_planner, a_star, shortest_path,
                  #   visibility_graph, motion_plan, motion_planner_3d, collision_detect,
                  #   collision_detect_3d, gjk, sat, config_space, kinematics,
                  #   grasp_planning, contact_geom, potential_field, trajectory_opt,
                  #   workspace_analysis
  pde/           # (20) 偏微分方程 | Partial differential equations
                  #   poisson_solver, heat_equation, wave_equation, diffusion_solver,
                  #   advection_solver, navier_stokes, schrodinger_solver, maxwell_solver,
                  #   reaction_diffusion, level_set, fast_marching, fast_sweeping,
                  #   finite_element, boundary_element, spectral_method, meshfree_method,
                  #   discontinuous_galerkin, lattice_boltzmann, harmonic_map, minimal_surface
  ml/            # (19) 机器学习几何 | ML geometry
                  #   clustering, clustering_geom, manifold_learning, dimension_reduction,
                  #   feature_projection, spectral_geom, kernel_density, gaussian_process,
                  #   regression_geom, svm_geometry, decision_boundary, ransac, matching,
                  #   shape_context, shape_matching, icp, graph_color, graph_cut,
                  #   stochastic_geom
  graphics/      # (18) 图形与渲染 | Graphics & rendering
                  #   ray_tracing, ray_trace_ops, rasterization, raster_2d, raster_ops,
                  #   hidden_line, contour_line, svg_out, hough_transform, fractal_gen,
                  #   shading_model, shadow_mapping, env_mapping, bump_mapping,
                  #   texture_mapping, anti_aliasing, splatting, gpu_geometry
  differential/  # (14) 微分几何 | Differential geometry
                  #   geodesic, conformal_geom, discrete_curvature, discrete_diff_geom,
                  #   discrete_laplacian, discrete_yamabe, gauss_bonnet, info_geom,
                  #   quantum_geom, symplectic_geom, symplectic_int, topological_quantum,
                  #   bend_energy, willmore_energy
  algebraic/     # (12) 代数几何 | Algebraic geometry
                  #   conic_section, quadric_surface, implicit_surface, resultant,
                  #   geometric_algebra, grobner_basis, polynomial_ideal, elimination_ideal,
                  #   algebraic_variety, intersection_theory, multiplicity, bezout_theorem
  computational/ # (18) 计算几何理论 | Computational geometry theory
                  #   art_gallery, visibility, euler_tour, spanning_tree, covering, packing,
                  #   geom_prob, geom_measure, geom_inequal, geom_hash, geom_coding,
                  #   chaos_geom, lattice_geom, crystal_geom, fractal_dimension,
                  #   hausdorff_dimension, ifs, rounded_geometry
  stats/         # (11) 统计与分子几何 | Statistical & molecular geometry
                  #   fourier_descriptor, moment_invariants, pmatch, random_geom_graph,
                  #   bayesian_geom, dynamics_geom, geom_mechanics, molecular_geom,
                  #   protein_geom, drug_design, tin
  pointcloud/    # (7)  点云处理 | Point cloud processing
                  #   point_cloud, sampling, pc_filter, pc_transform, pc_feature,
                  #   pc_segment, normal_est
  io/            # (7)  文件输入输出 | File I/O
                  #   obj_io, stl_io, ply_io, gltf_io, geojson_io, dxf_io, json_out
  testing/       # (5)  测试基础设施 | Testing infrastructure
                  #   formal_properties, formal_invariants, mock_geometric,
                  #   e2e_workflows, ai_property_tests
  misc/          # (14) 杂项工具 | Miscellaneous utilities
                  #   intersect, fitting, project3d, gis_projection, gis_buffer,
                  #   delaunay_refine, trapezoidal, integration, differentiation,
                  #   radial_basis, wavelet_geom, dynamic_filter, static_filter,
                  #   ground_detect
```

## 快速示例 | Quick Example

```moonbit
// Import core types and algorithm packages
// 导入核心类型和算法包
// import { "walkzzz/moon-geometry/src/core" as geom }
// import { "walkzzz/moon-geometry/src/hull" }

let points = [
  @geom.Point2D::new(0.0, 0.0),
  @geom.Point2D::new(4.0, 0.0),
  @geom.Point2D::new(4.0, 4.0),
  @geom.Point2D::new(0.0, 4.0),
  @geom.Point2D::new(2.0, 2.0),  // 内部点 | interior point
]
let hull = @hull.convex_hull_andrew(points)  // 凸包顶点（逆时针）| hull vertices (CCW)
```

## API 概览 | API Overview

| 模块 | Module | 主要 API | Key APIs |
|------|--------|---------|----------|
| 点 | Points | `Point2D::new/dist/dot/cross/add/sub/mul` | `Point3D` 同构 |
| 线段/直线 | Segment/Line | `Segment::length/midpoint` | `Line::from_points/point_distance` |
| 多边形 | Polygon | `polygon_area/perimeter/centroid` | `is_convex`, `point_in_polygon`, `simplify_polygon` |
| 凸包 | Convex hull | `convex_hull_andrew`, `convex_hull_graham` | `ccw` |
| 相交 | Intersection | `segments_intersect`, `segment_intersection` | `line_segment_intersection` |
| 最近点对 | Closest pair | `closest_pair` | 分治 O(n log n) |
| 布尔运算 | Boolean ops | `clip_polygon`, `polygon_intersection` | `polygon_union_area`, `polygon_difference_area` |
| 三角剖分 | Triangulation | `delaunay_triangulation` | `voronoi_diagram` |
| 变换 | Transform | `translate`, `rotate`, `scale` | `affine_transform`, `mirror_line`, `shear` |
| 距离 | Distance | `point_to_segment_distance`, `polygon_to_polygon_distance` | `segment_to_segment_distance` |
| 包围体 | Bounding | `aabb`, `aabb_polygon` | `min_area_bounding_rect`, `bounding_circle` |
| 圆相交 | Circle ops | `circle_segment_intersect`, `circle_circle_intersect` | `circle_line_intersect`, `circle_polygon_intersect` |
| 三角剖分 | Triangulate | `triangulate_polygon` | ear clipping |
| Minkowski | Minkowski | `minkowski_sum_convex`, `minkowski_difference_convex` | `convex_polygons_collide` |
| 旋转卡壳 | Rotating calipers | `convex_polygon_diameter`, `convex_polygon_width` | `farthest_point_pair` |
| 椭圆 | Ellipse | `ellipse_new`, `ellipse_area`, `ellipse_perimeter` | `ellipse_contains`, `ellipse_foci` |
| 贝塞尔 | Bezier | `bezier2_new`, `bezier2_eval`, `bezier3_new` | `bezier2_length`, `bezier3_subdivide` |
| 拟合 | Fitting | `fit_line`, `fit_circle`, `fit_line_orthogonal` | `centroid` |
| 扫描线 | Sweep line | `has_any_intersection`, `count_intersections` | `is_simple_polygon_chain` |
| 凸多边形 | Convex polygon | `point_in_convex_polygon`, `convex_polygons_intersect` | `tangent_from_point`, `support_function` |
| 向量 | Vector | `vec_normalize`, `vec_reflect`, `vec_project` | `vec_lerp`, `vec_perp`, `vec_angle_between` |
| 矩阵 | Matrix | `mat2_new`, `mat2_det`, `mat2_mul`, `mat2_inverse` | `mat2_rotation`, `mat2_scaling`, `mat2_trace` |
| 角度 | Angle | `deg_to_rad`, `rad_to_deg`, `normalize_angle` | `normalize_angle_signed`, `angle_diff`, `angle_bisector` |
| 常数 | Constants | `pi`, `two_pi`, `half_pi`, `euler_e` | `sqrt2`, `sqrt3`, `golden_ratio`, `geom_eps` |
| 区间 | Interval | `interval_new`, `interval_contains`, `interval_intersect` | `interval_union`, `interval_overlaps`, `interval_length` |
| AABB树 | AABB tree | `build_aabb_tree`, `query_aabb`, `query_point_aabb` | `count_leaves` |
| 哈希 | Hash | `cell_index`, `cell_hash`, `segment_hash` | `cell_index_3d`, `hash_combine` |
| 比较 | Compare | `robust_orientation`, `robust_left_turn`, `compare_points` | `robust_collinear`, `points_equal` |
| 射线 | Ray | `ray_new`, `ray_segment_intersect`, `ray_polygon_contains` | `ray_line_intersect`, `ray_polygon_intersect` |
| 平面 | Plane | `plane_from_normal_point`, `plane_distance`, `plane_project` | `plane_from_three_points`, `plane_line_intersect` |
| K-d树 | K-d tree | `build_kdtree`, `kdtree_nearest`, `kdtree_range_query` | 最近邻搜索 |
| 四叉树 | Quadtree | `build_quadtree`, `quadtree_range_query` | `quadtree_count` |
| 网格索引 | Grid index | `build_grid_index`, `grid_query_radius`, `grid_query_rect` | `grid_query_cell`, `grid_size` |
| 范围树 | Range tree | `build_range_tree`, `range_query` | `range_query_x`, `range_query_y` |
| 有序搜索 | Sort search | `binary_search`, `lower_bound`, `upper_bound` | `unique_sorted`, `kth_element`, `merge_sorted` |
| 桶PR树 | Bucket PR | `build_bucket_pr`, `bucket_pr_nearest` | `bucket_pr_count` |
| 空间哈希 | Spatial hash | `build_spatial_hash`, `spatial_hash_query_radius` | `spatial_hash_nearby`, `spatial_hash_size` |
| 层次包围体 | BVH | `build_bvh`, `bvh_query`, `bvh_query_point` | `bvh_count_leaves` |
| 半平面 | Half-plane | `HalfPlane`, `half_plane_contains`, `half_plane_intersect` | `half_plane_eval` |
| 凸裁剪 | Convex clip | `clip_convex_by_line`, `clip_convex_by_half_plane` | `convex_area` |
| 点集运算 | Convex sum | `point_set_sum`, `point_set_difference`, `point_set_scale` | `point_set_centroid`, `point_set_equal` |
| 极对偶 | Polar dual | `polar_dual_point`, `polar_dual` | `origin_inside`, `dual_area` |
| 线性规划 | Linear prog | `LPResult`, `linear_program_2d`, `is_feasible` | `find_feasible_point` |
| 三维凸包 | 3D convex hull | `HullFace`, `convex_hull_3d`, `hull_face_count` | `hull_volume` |
| 支持函数 | Support | `support_point_set`, `support_circle`, `support_value` | `support_segment`, `width_in_direction` |
| 分离轴 | Separating | `find_separating_axis`, `separating_distance` | `are_separated` |
| 多边形偏移 | Polygon offset | `polygon_offset_outward`, `polygon_offset_inward` | `polygon_offset_area`, `polygon_offset_valid` |
| 带孔多边形 | Polygon holes | `PolygonWithHoles`, `polygon_with_holes_area` | `polygon_with_holes_contains`, `polygon_with_holes_perimeter` |
| 可见性 | Visibility | `is_visible`, `visibility_polygon` | `visibility_polygon_convex`, `visible_vertex_count` |
| 美术馆 | Art gallery | `art_gallery_guard_count`, `art_gallery_place_guards` | `art_gallery_covers_vertices`, `art_gallery_estimate` |
| 多边形核 | Polygon kernel | `polygon_kernel`, `is_star_shaped` | `polygon_kernel_area`, `kernel_point` |
| 凸分解 | Convex decomp | `convex_decomposition`, `convex_decomp_count` | `convex_decomp_lower_bound`, `convex_decomp_area` |
| 多边形对称 | Polygon symmetry | `has_reflection_symmetry`, `has_rotation_symmetry` | `polygon_symmetry_order`, `has_any_symmetry` |
| 多边形覆盖 | Polygon cover | `cover_by_rectangles`, `cover_by_triangles` | `cover_area_rectangles`, `cover_area_triangles` |
| 耳裁剪 | Ear clip | `is_ear`, `find_ear`, `ear_clip_triangulate` | `ear_clip_count`, `ear_clip_area` |
| 单调剖分 | Monotone | `is_y_monotone`, `is_x_monotone` | `triangulate_monotone`, `monotone_triangulate_count` |
| Catmull-Rom | Catmull-Rom | `catmull_rom_eval`, `catmull_rom_points` | `catmull_rom_derivative` |
| Hermite | Hermite | `hermite_eval`, `hermite_points` | `hermite_derivative`, `cardinal_tangents` |
| B样条 | B-spline | `bspline_basis`, `bspline_eval`, `bspline_points` | `uniform_knots` |
| Lagrange | Lagrange | `lagrange_eval`, `lagrange_basis` | `lagrange_interpolate`, `lagrange_nodes_distinct` |
| 样条工具 | Spline | `spline_length`, `spline_curvature` | `spline_curvature_profile`, `spline_total_curvature` |
| 弧长 | Curve arc | `arc_length`, `arc_length_at` | `arc_length_parametrize`, `arc_length_to_param` |
| 曲线相交 | Curve intersect | `segments_cross`, `curve_self_intersect` | `curve_self_intersect_count`, `curves_intersect` |
| 折线 | Polyline | `polyline_length`, `polyline_simplify` | `polyline_subdivide`, `polyline_segment_count` |
| 弧长工具 | Arc length | `arc_length_segment`, `arc_length_total` | `arc_length_cumulative`, `arc_length_average` |
| 曲率 | Curvature | `curvature_at`, `curvature_signed` | `curvature_profile`, `curvature_radius` |

完整接口见 `moon info` 生成的 `.mbti` 文件。Full interface in `.mbti` files generated by `moon info`.

## 测试 | Tests

```bash
moon test                          # 全部 2518 测试 | all 2518 tests
moon test --target native          # 四目标分别验证 | verify each backend
moon test --target wasm-gc
moon test --target js
moon test --target wasm
```

四目标全绿：2518 × 4 = 10072 次测试通过。
All four targets pass: 2518 × 4 = 10072 test runs green.

## 交付路线图 | Roadmap

| 阶段 | Phase | 内容 | Content | 状态 | Status |
|------|-------|------|---------|------|--------|
| Week 1 | Week 1 | 基础类型 + 凸包 + 多边形操作 | Basic types + hull + polygon ops | ✅ 完成 | ✅ Done |
| Week 2 | Week 2 | 线段相交 + 最近点对 + 布尔运算 | Intersection + closest pair + boolean | ✅ 完成 | ✅ Done |
| Week 3 | Week 3 | Delaunay 三角剖分 + Voronoi 图 | Delaunay + Voronoi | ✅ 完成 | ✅ Done |
| Week 4 | Week 4 | 变换 + 距离 + 包围盒 + 发布 | Transform + distance + bounding + publish | ✅ 完成 | ✅ Done |
| Phase 1-2 | Phase 1-2 | 测试补充 + 圆相交 + 三角剖分 + Minkowski | Tests + circle ops + triangulate + Minkowski | ✅ 完成 | ✅ Done |
| v0.6.0 | v0.6.0 | 旋转卡壳 + 椭圆 + 贝塞尔曲线 | Rotating calipers + ellipse + bezier | ✅ 完成 | ✅ Done |
| v0.7.0 | v0.7.0 | 拟合 + 扫描线 + 凸多边形操作 | Fitting + sweep line + convex polygon | ✅ 完成 | ✅ Done |
| v0.8.0 | v0.8.0 | 向量 + 矩阵 + 角度 + 常数 + 区间 | Vector + matrix + angle + constants + interval | ✅ 完成 | ✅ Done |
| v0.9.0 | v0.9.0 | AABB树 + 哈希 + 比较 + 射线 + 平面 | AABB tree + hash + compare + ray + plane | ✅ 完成 | ✅ Done |
| v1.0.0 | v1.0.0 | 空间数据结构（8模块）| Spatial data structures (8 modules) | ✅ 完成 | ✅ Done |
| v1.1.0 | v1.1.0 | 凸性与优化（8模块）| Convexity & optimization (8 modules) | ✅ 完成 | ✅ Done |
| v1.2.0 | v1.2.0 | 多边形算法（10模块）| Polygon algorithms (10 modules) | ✅ 完成 | ✅ Done |
| v1.3.0 | v1.3.0 | 曲线与样条（10模块）| Curves & splines (10 modules) | ✅ 完成 | ✅ Done |
| v1.4.0 | v1.4.0 | 距离度量（8模块）| Distance metrics (8 modules) | ✅ 完成 | ✅ Done |
| v1.5.0 | v1.5.0 | 平面细分（8模块）| Planar subdivision (8 modules) | ✅ 完成 | ✅ Done |
| v1.6.0 | v1.6.0 | 几何变换（8模块）| Geometric transforms (8 modules) | ✅ 完成 | ✅ Done |
| v1.7.0 | v1.7.0 | 网格处理（6模块）| Mesh processing (6 modules) | ✅ 完成 | ✅ Done |
| v2.0.0 | v2.0.0 | 优化与输出（5模块）| Optimization & output (5 modules) | ✅ 完成 | ✅ Done |
| v0.108.0 | v0.108.0 | 高级凸几何（8模块）| Advanced convex geometry (8 modules) | ✅ 完成 | ✅ Done |
| v0.116.0 | v0.116.0 | 高级多边形（8模块）| Advanced polygon algorithms (8 modules) | ✅ 完成 | ✅ Done |
| v0.124.0 | v0.124.0 | 高级空间结构（8模块）| Advanced spatial structures (8 modules) | ✅ 完成 | ✅ Done |
| v0.132.0 | v0.132.0 | 高级图算法（8模块）| Advanced graph algorithms (8 modules) | ✅ 完成 | ✅ Done |
| v0.140.0 | v0.140.0 | 数值计算（8模块）| Numerical computation (8 modules) | ✅ 完成 | ✅ Done |
| v0.156.0 | v0.156.0 | 曲面（8模块）| Surface modules (8 modules) | ✅ 完成 | ✅ Done |
| v0.156.0 | v0.156.0 | 应用算法（8模块）| Application algorithms (8 modules) | ✅ 完成 | ✅ Done |
| v0.160.0 | v0.160.0 | 3D几何与多面体（10模块）| 3D geometry & polyhedra (10 modules) | ✅ 完成 | ✅ Done |
| v0.230.0 | v0.230.0 | 扩展模块（70模块）| Extension modules (70 modules) | ✅ 完成 | ✅ Done |
| v0.231.0 | v0.231.0 | 计算代数几何（10模块）| Computational algebraic geometry (10 modules) | ✅ 完成 | ✅ Done |
| v0.232.0 | v0.232.0 | 微分几何与离散曲面（10模块）| Differential geometry & discrete surfaces (10 modules) | ✅ 完成 | ✅ Done |
| v0.233.0 | v0.233.0 | 持久拓扑与高级数值（20模块）| Persistent topology & advanced numerics (20 modules) | ✅ 完成 | ✅ Done |
| v0.234.0 | v0.234.0 | ML几何+机器人+图形+PDE（40模块）| ML geometry + robotics + graphics + PDE (40 modules) | ✅ 完成 | ✅ Done |
| v0.235.0 | v0.235.0 | 代数结构+鲁棒几何+优化+应用（40模块）| Algebra structures + robust geometry + optimization + applications (40 modules) | ✅ 完成 | ✅ Done |
| v0.236.0 | v0.236.0 | 形式化验证+MOCK/FAKE+E2E+AI属性测试（5模块）| Formal verification + MOCK/FAKE + E2E + AI property tests (5 modules) | ✅ 完成 | ✅ Done |
| v0.237.0 | v0.237.0 | Trait 去重（PointTransform trait, cross/approx_eq/map_points 统一）| Trait-based deduplication | ✅ 完成 | ✅ Done |
| v0.238.0 | v0.238.0 | 目录重构（401模块→24分类子目录）| Directory restructuring (401 modules → 24 categories) | ✅ 完成 | ✅ Done |
| v0.239.0 | v0.239.0 | Warning 治理（204→55）| Warning governance (204→55) | ✅ 完成 | ✅ Done |

详见 [docs/roadmap.md](docs/roadmap.md) 与 [docs/changelog.md](docs/changelog.md)。
See [docs/roadmap.md](docs/roadmap.md) and [docs/changelog.md](docs/changelog.md).

## 设计参考 | Design References

- [CGAL](https://github.com/CGAL/cgal) — 算法参考 | algorithm reference
- [Shapely](https://github.com/shapely/shapely) — API 设计参考 | API design reference
- [scipy.spatial](https://docs.scipy.org/doc/scipy/reference/spatial.html) — Delaunay/Voronoi 对照验证 | validation

本项目为原创实现，使用 Double 浮点运算，以 MoonBit 原生类型系统组织几何类型。
Original implementation using Double floating-point arithmetic, organized with MoonBit's native type system.

## 许可证 | License

[MIT](LICENSE)