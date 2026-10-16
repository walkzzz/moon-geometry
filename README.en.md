# Moon Geometry

> Pure MoonBit computational geometry library | 2026 MoonBit October Hackathon entry
> 纯 MoonBit 计算几何库 | 2026 MoonBit 十月赛参赛项目

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MoonBit](https://img.shields.io/badge/MoonBit-0.1.20260920-blue.svg)](https://moonbitlang.com)
[![Tests](https://img.shields.io/badge/tests-1075-brightgreen.svg)]()
[![Targets](https://img.shields.io/badge/targets-native%20%7C%20wasm--gc%20%7C%20js%20%7C%20wasm-green.svg)]()

Moon Geometry is a **pure MoonBit** computational geometry library with **zero C FFI dependencies**, supporting all four backends (3natively. It provides reusable geometric algorithm primitives for CAD, collision detection, GIS, path planning, and image processing.

Moon Geometry 是一个**纯 MoonBit** 实现的计算几何库，**零 C FFI 依赖**，四目标原生支持。

## Features | 特性

- **Basic types | 基础类型**: `Point2D` / `Point3D` / `Segment` / `Line` / `Polygon` / `Triangle` / `Circle` / `Rectangle`
- **Convex hull | 凸包**: Graham scan, Andrew's monotone chain (O(n log n))
- **Polygon ops | 多边形操作**: area (Shoelace), perimeter, centroid, point-in-polygon, convexity, Douglas-Peucker
- **Delaunay triangulation | Delaunay 三角剖分**: Bowyer-Watson incremental insertion (O(n²) expected)
- **Voronoi diagram | Voronoi 图**: Delaunay duality, circumcenters as vertices
- **Transforms | 几何变换**: translate, rotate, scale, affine, mirror, shear
- **Distance | 距离计算**: point-to-segment/polygon, segment-to-segment, polygon-to-polygon
- **Bounding | 包围体**: AABB, min-area bounding rect (rotating calipers), bounding circle
- **Circle intersection | 圆相交**: circle-segment, circle-circle, circle-line, circle-polygon
- **Polygon triangulation | 多边形三角剖分**: ear clipping for simple polygons
- **Minkowski ops | Minkowski 运算**: sum/difference of convex polygons, collision detection
- **Rotating calipers | 旋转卡壳**: diameter, width, farthest pair, min-perimeter rect
- **Ellipse | 椭圆**: area, perimeter, eccentricity, foci, contains, line intersection
- **Bezier | 贝塞尔曲线**: quadratic/cubic eval, derivative, length, bbox, subdivide
- **Fitting | 几何拟合**: least-squares line/circle, orthogonal regression, centroid
- **Sweep line | 扫描线**: segment intersection detection, simple polygon test
- **Convex polygon | 凸多边形**: O(log n) point query, tangent, SAT intersect
- **Unified import | 统一导入**: `import "walkzzz/moon-geometry"` re-exports all APIs
- **Pure MoonBit, zero deps | 纯 MoonBit 零依赖**: no C FFI, single codebase for all targets
- **Full degenerate coverage | 退化情况全覆盖**: collinear, coincident, empty, single/two-point

## Installation | 安装

```bash
moon add walkzzz/moon-geometry
```

## Project Structure | 项目结构

```
src/
  core/           # Base types | 基础类型
  hull/           # Convex hull | 凸包
  polygon/        # Polygon operations | 多边形操作
  intersect/      # Intersection |* Intersection | 相交
  nearest/        # Closest pair | 最近点对
  boolean/        # Boolean operations | 布尔运算
  triangulation/  # Delaunay/Voronoi | 三角剖分
  transform/      # Geometric transforms | 几何变换
  distance/       # Distance computations | 距离计算
  bounding/       # Bounding boxes | 包围盒
  circle_ops/     # Circle intersection | 圆相交
  triangulate/    # Polygon triangulation | 多边形三角剖分
  minkowski/      # Minkowski operations | Minkowski 运算
  rotating_calipers/ # Rotating calipers | 旋转卡壳
  ellipse/        # Ellipse geometry | 椭圆几何
  bezier/         # Bezier curves | 贝塞尔曲线
  fitting/        # Geometric fitting | 几何拟合
  sweep_line/     # Sweep line | 扫描线
  convex_polygon/ # Convex polygon ops | 凸多边形操作
  vector/         # Vector operations | 向量运算
  matrix/         # 2x2 matrices | 矩阵
  angle/          # Angle utilities | 角度工具
  constants/      # Geometric constants | 几何常数
  interval/       # Interval operations | 区间运算
  aabb_tree/      # AABB tree | AABB树
  hash/           # Geometric hashing | 几何哈希
  compare/        # Comparison predicates | 比较谓词
  ray/            # Ray operations | 射线运算
  plane/          # 3D plane | 三维平面
  kdtree/         # K-d tree | K-d树
  quadtree/       # Quadtree | 四叉树
  grid_index/     # Grid index | 网格索引
  range_tree/     # Range tree | 范围树
  sort_search/    # Sorted search | 有序搜索
  bucket_pr/      # Bucket PR k-d tree | 桶PR树
  spatial_hash/   # Spatial hash | 空间哈希
  bvh/            # BVH | 层次包围体
  half_plane/     # Half-plane | 半平面
  convex_clip/    # Convex clipping | 凸多边形裁剪
  convex_sum/     # Point set ops | 点集运算
  polar_dual/     # Polar duality | 极对偶
  linear_prog/    # 2D linear programming | 二维线性规划
  convex_hull3d/  # 3D convex hull | 三维凸包
  support/        # Support functions | 支持函数
  separating/     # Separating axis | 分离轴
  polygon_offset/ # Polygon offset | 多边形偏移
  polygon_holes/  # Polygon with holes | 带孔多边形
  visibility/     # Visibility | 可见性
  art_gallery/    # Art gallery | 美术馆问题
  polygon_kernel/ # Polygon kernel | 多边形核
  convex_decomp/  # Convex decomposition | 凸分解
  polygon_symmetry/ # Polygon symmetry | 多边形对称
  polygon_cover/  # Polygon cover | 多边形覆盖
  ear_clip/       # Ear clipping | 耳裁剪
  monotone/       # Monotone triangulation | 单调三角剖分
  catmull_rom/    # Catmull-Rom spline | Catmull-Rom样条
  hermite/        # Hermite spline | Hermite样条
  bspline/        # B-spline | B样条
  lagrange/       # Lagrange interpolation | Lagrange插值
  spline/         # Spline utilities | 样条工具
  curve_arc/      # Arc length | 弧长
  curve_intersect/ # Curve intersection | 曲线相交
  polyline/       # Polyline | 折线
  arc_length/     # Arc length utils | 弧长工具
  curvature/      # Curvature | 曲率
  hausdorff/      # Hausdorff distance | Hausdorff距离
  frechet/        # Fréchet distance | Fréchet距离
  chamfer/        # Chamfer distance | Chamfer距离
  emd/            # Earth Mover's distance | EMD距离
  bottleneck/     # Bottleneck matching | 瓶颈匹配
  pmatch/         # Point matching | 点匹配
  dtw/            # Dynamic time warping | DTW
  metric_tree/    # Metric tree | 度量树
  dcel/           # Doubly-connected edge list | 双向边链表
  arrangement/    # Line arrangement | 直线安排
  planar_graph/   # Planar graph | 平面图
  face_extract/   # Face extraction | 面提取
  overlay/        # Overlay | 叠加
  euler_tour/     # Euler tour | 欧拉回路
  trapezoidal/    # Trapezoidal map | 梯形图
  zone/           # Zone theorem | 区域定理
  project3d/      # 3D projection | 3D投影
  homography/     # Homography | 单应变换
  perspective/    # Perspective transform | 透视变换
  stereographic/  # Stereographic projection | 立体投影
  affine2/        # Affine transform | 仿射变换
  rigid/          # Rigid transform | 刚体变换
  similarity/     # Similarity transform | 相似变换
  inversion/      # Inversion | 反演变换
  mesh_data/      # Mesh data | 网格数据
  mesh_simplify/  # Mesh simplification | 网格简化
  mesh_smooth/    # Mesh smoothing | 网格平滑
  mesh_normal/    # Mesh normals | 网格法线
  mesh_subdiv/    # Mesh subdivision | 网格细分
  euler_char/     # Euler characteristic | 欧拉特征
  optim/          # Optimization | 优化
  random_gen/     # Random generation | 随机生成
  sampling/       # Sampling | 采样
  svg_out/        # SVG output | SVG输出
  json_out/       # JSON output | JSON输出
  convex_hull_approx/  # Approximate convex hull | 近似凸包
  convex_hull_dynamic/ # Dynamic convex hull | 动态凸包
  convex_layers/       # Convex layers (onion) | 凸包层次
  concave_hull/        # Concave hull | 凹包
  convex_width/        # Convex width | 凸宽度
  convex_diameter/     # Convex diameter | 凸直径
  convex_center/       # Convex center | 凸中心
  convex_intersection/ # Convex intersection | 凸交集
  polygon_skeleton/     # Straight skeleton | 直骨架
  polygon_medial/       # Medial axis | 中轴线
  polygon_simplify/     # Polygon simplification | 多边形简化
  polygon_round/        # Corner rounding | 圆角化
  polygon_evolve/       # Curve shortening flow | 曲率流
  polygon_morph/        # Polygon morphing | 多边形变形
  polygon_decomp_opt/   # Optimal convex decomposition | 最优凸分解
  polygon_triangulate_fast/ # Fast triangulation | 快速三角剖分
  rtree/                # R-tree | R树
  octree/               # Octree | 八叉树
  ball_tree/            # Ball tree | 球树
  vp_tree/              # Vantage point tree | 基点树
  cover_tree/           # Cover tree | 覆盖树
  interval_tree/        # Interval tree | 区间树
  skip_quadtree/        # Skip quadtree | 跳跃四叉树
  loose_octree/         # Loose octree | 松散八叉树
  shortest_path/        # Shortest path (Dijkstra) | 最短路径
  visibility_graph/     # Visibility graph | 可见性图
  motion_plan/          # Motion planning | 运动规划
  voronoi_adv/          # Advanced Voronoi | 高级Voronoi
  delaunay_refine/      # Delaunay refinement | Delaunay细化
  graph_color/          # Graph coloring | 图着色
  graph_cut/            # Graph cut | 图割
  spanning_tree/        # Minimum spanning tree | 最小生成树
```

## Quick Example | 快速示例

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
  @geom.Point2D::new(2.0, 2.0),  // interior point | 内部点
]
let hull = @hull.convex_hull_andrew(points)  // hull vertices (CCW) | 凸包顶点（逆时针）
```

## API Overview | API 概览

| Module | 模块 | Key APIs | 主要 API |
|--------|------|----------|---------|
| Points | 点 | `Point2D::new/dist/dot/cross` | `Point3D` isomorphic |
| Segment/Line | 线段/直线 | `Segment::length/midpoint` | `Line::from_points/point_distance` |
| Polygon | 多边形 | `polygon_area/perimeter/centroid` | `is_convex`, `point_in_polygon` |
| Convex hull | 凸包 | `convex_hull_andrew`, `convex_hull_graham` | `ccw` |
| Intersection | 相交 | `segments_intersect`, `segment_intersection` | `line_segment_intersection` |
| Closest pair | 最近点对 | `closest_pair` | divide & conquer O(n log n) |
| Boolean ops | 布尔运算 | `clip_polygon`, `polygon_intersection` | `polygon_union_area` |
| Triangulation | 三角剖分 | `delaunay_triangulation` | `voronoi_diagram` |
| Transform | 变换 | `translate`, `rotate`, `scale` | `affine_transform`, `mirror_line` |
| Distance | 距离 | `point_to_segment_distance`, `polygon_to_polygon_distance` | `segment_to_segment_distance` |
| Bounding | 包围体 | `aabb`, `aabb_polygon` | `min_area_bounding_rect`, `bounding_circle` |
| Circle ops | 圆相交 | `circle_segment_intersect`, `circle_circle_intersect` | `circle_polygon_intersect` |
| Triangulate | 三角剖分 | `triangulate_polygon` | ear clipping |
| Minkowski | Minkowski | `minkowski_sum_convex`, `minkowski_difference_convex` | `convex_polygons_collide` |
| Rotating calipers | 旋转卡壳 | `convex_polygon_diameter`, `convex_polygon_width` | `farthest_point_pair` |
| Ellipse | 椭圆 | `ellipse_new`, `ellipse_area`, `ellipse_perimeter` | `ellipse_contains`, `ellipse_foci` |
| Bezier | 贝塞尔 | `bezier2_new`, `bezier2_eval`, `bezier3_new` | `bezier2_length`, `bezier3_subdivide` |
| Fitting | 拟合 | `fit_line`, `fit_circle`, `fit_line_orthogonal` | `centroid` |
| Sweep line | 扫描线 | `has_any_intersection`, `count_intersections` | `is_simple_polygon_chain` |
| Convex polygon | 凸多边形 | `point_in_convex_polygon`, `convex_polygons_intersect` | `tangent_from_point` |
| Vector | 向量 | `vec_normalize`, `vec_reflect`, `vec_project` | `vec_lerp`, `vec_perp`, `vec_angle_between` |
| Matrix | 矩阵 | `mat2_new`, `mat2_det`, `mat2_mul`, `mat2_inverse` | `mat2_rotation`, `mat2_scaling`, `mat2_trace` |
| Angle | 角度 | `deg_to_rad`, `rad_to_deg`, `normalize_angle` | `normalize_angle_signed`, `angle_diff`, `angle_bisector` |
| Constants | 常数 | `pi`, `two_pi`, `half_pi`, `euler_e` | `sqrt2`, `sqrt3`, `golden_ratio`, `geom_eps` |
| Interval | 区间 | `interval_new`, `interval_contains`, `interval_intersect` | `interval_union`, `interval_overlaps`, `interval_length` |
| AABB tree | AABB树 | `build_aabb_tree`, `query_aabb`, `query_point_aabb` | `count_leaves` |
| Hash | 哈希 | `cell_index`, `cell_hash`, `segment_hash` | `cell_index_3d`, `hash_combine` |
| Compare | 比较 | `robust_orientation`, `robust_left_turn`, `compare_points` | `robust_collinear`, `points_equal` |
| Ray | 射线 | `ray_new`, `ray_segment_intersect`, `ray_polygon_contains` | `ray_line_intersect`, `ray_polygon_intersect` |
| Plane | 平面 | `plane_from_normal_point`, `plane_distance`, `plane_project` | `plane_from_three_points`, `plane_line_intersect` |
| K-d tree | K-d树 | `build_kdtree`, `kdtree_nearest`, `kdtree_range_query` | Nearest neighbor |
| Quadtree | 四叉树 | `build_quadtree`, `quadtree_range_query` | `quadtree_count` |
| Grid index | 网格索引 | `build_grid_index`, `grid_query_radius`, `grid_query_rect` | `grid_query_cell`, `grid_size` |
| Range tree | 范围树 | `build_range_tree`, `range_query` | `range_query_x`, `range_query_y` |
| Sort search | 有序搜索 | `binary_search`, `lower_bound`, `upper_bound` | `unique_sorted`, `kth_element`, `merge_sorted` |
| Bucket PR | 桶PR树 | `build_bucket_pr`, `bucket_pr_nearest` | `bucket_pr_count` |
| Spatial hash | 空间哈希 | `build_spatial_hash`, `spatial_hash_query_radius` | `spatial_hash_nearby`, `spatial_hash_size` |
| BVH | 层次包围体 | `build_bvh`, `bvh_query`, `bvh_query_point` | `bvh_count_leaves` |
| Half-plane | 半平面 | `HalfPlane`, `half_plane_contains`, `half_plane_intersect` | `half_plane_eval` |
| Convex clip | 凸裁剪 | `clip_convex_by_line`, `clip_convex_by_half_plane` | `convex_area` |
| Convex sum | 点集运算 | `point_set_sum`, `point_set_difference`, `point_set_scale` | `point_set_centroid`, `point_set_equal` |
| Polar dual | 极对偶 | `polar_dual_point`, `polar_dual` | `origin_inside`, `dual_area` |
| Linear prog | 线性规划 | `LPResult`, `linear_program_2d`, `is_feasible` | `find_feasible_point` |
| 3D convex hull | 三维凸包 | `HullFace`, `convex_hull_3d`, `hull_face_count` | `hull_volume` |
| Support | 支持函数 | `support_point_set`, `support_circle`, `support_value` | `support_segment`, `width_in_direction` |
| Separating | 分离轴 | `find_separating_axis`, `separating_distance` | `are_separated` |
| Polygon offset | 多边形偏移 | `polygon_offset_outward`, `polygon_offset_inward` | `polygon_offset_area`, `polygon_offset_valid` |
| Polygon holes | 带孔多边形 | `PolygonWithHoles`, `polygon_with_holes_area` | `polygon_with_holes_contains`, `polygon_with_holes_perimeter` |
| Visibility | 可见性 | `is_visible`, `visibility_polygon` | `visibility_polygon_convex`, `visible_vertex_count` |
| Art gallery | 美术馆 | `art_gallery_guard_count`, `art_gallery_place_guards` | `art_gallery_covers_vertices`, `art_gallery_estimate` |
| Polygon kernel | 多边形核 | `polygon_kernel`, `is_star_shaped` | `polygon_kernel_area`, `kernel_point` |
| Convex decomp | 凸分解 | `convex_decomposition`, `convex_decomp_count` | `convex_decomp_lower_bound`, `convex_decomp_area` |
| Polygon symmetry | 多边形对称 | `has_reflection_symmetry`, `has_rotation_symmetry` | `polygon_symmetry_order`, `has_any_symmetry` |
| Polygon cover | 多边形覆盖 | `cover_by_rectangles`, `cover_by_triangles` | `cover_area_rectangles`, `cover_area_triangles` |
| Ear clip | 耳裁剪 | `is_ear`, `find_ear`, `ear_clip_triangulate` | `ear_clip_count`, `ear_clip_area` |
| Monotone | 单调剖分 | `is_y_monotone`, `is_x_monotone` | `triangulate_monotone`, `monotone_triangulate_count` |
| Catmull-Rom | Catmull-Rom | `catmull_rom_eval`, `catmull_rom_points` | `catmull_rom_derivative` |
| Hermite | Hermite | `hermite_eval`, `hermite_points` | `hermite_derivative`, `cardinal_tangents` |
| B-spline | B样条 | `bspline_basis`, `bspline_eval`, `bspline_points` | `uniform_knots` |
| Lagrange | Lagrange | `lagrange_eval`, `lagrange_basis` | `lagrange_interpolate`, `lagrange_nodes_distinct` |
| Spline | 样条工具 | `spline_length`, `spline_curvature` | `spline_curvature_profile`, `spline_total_curvature` |
| Curve arc | 弧长 | `arc_length`, `arc_length_at` | `arc_length_parametrize`, `arc_length_to_param` |
| Curve intersect | 曲线相交 | `segments_cross`, `curve_self_intersect` | `curve_self_intersect_count`, `curves_intersect` |
| Polyline | 折线 | `polyline_length`, `polyline_simplify` | `polyline_subdivide`, `polyline_segment_count` |
| Arc length | 弧长工具 | `arc_length_segment`, `arc_length_total` | `arc_length_cumulative`, `arc_length_average` |
| Curvature | 曲率 | `curvature_at`, `curvature_signed` | `curvature_profile`, `curvature_radius` |

Full interface in `.mbti` files. 完整接口见 `.mbti` 文件。

## Tests | 测试

```bash
moon test                          # all 1075 tests | 全部 1075 测试
moon test --target native          # verify each backend | 四目标分别验证
moon test --target wasm-gc
moon test --target js
moon test --target wasm
```

All four targets pass: 1075 × 4 = 4300. 四目标全绿：1075 × 4 = 4300。

## Roadmap | 交付路线图

| Phase | Content | Status |
|-------|---------|--------|
| Week 1 | Basic types + hull + polygon ops | ✅ Done |
| Week 2 | Intersection + closest pair + boolean | ✅ Done |
| Week 3 | Delaunay + Voronoi | ✅ Done |
| Week 4 | Transform + distance + bounding + publish | ✅ Done |
| Phase 1-2 | Tests + circle ops + triangulate + Minkowski | ✅ Done |
| v0.6.0 | Rotating calipers + ellipse + bezier | ✅ Done |
| v0.7.0 | Fitting + sweep line + convex polygon | ✅ Done |
| v0.8.0 | Vector + matrix + angle + constants + interval | ✅ Done |
| v0.9.0 | AABB tree + hash + compare + ray + plane | ✅ Done |
| v1.0.0 | Spatial data structures (8 modules) | ✅ Done |
| v1.1.0 | Convexity & optimization (8 modules) | ✅ Done |
| v1.2.0 | Polygon algorithms (10 modules) | ✅ Done |
| v1.3.0 | Curves & splines (10 modules) | ✅ Done |
| v1.4.0 | Distance metrics (8 modules) | ✅ Done |
| v1.5.0 | Planar subdivision (8 modules) | ✅ Done |
| v1.6.0 | Geometric transforms (8 modules) | ✅ Done |
| v1.7.0 | Mesh processing (6 modules) | ✅ Done |
| v2.0.0 | Optimization & output (5 modules) | ✅ Done |
| v0.108.0 | Advanced convex geometry (8 modules) | ✅ Done |
| v0.116.0 | Advanced polygon algorithms (8 modules) | ✅ Done |
| v0.124.0 | Advanced spatial structures (8 modules) | ✅ Done |
| v0.132.0 | Advanced graph algorithms (8 modules) | ✅ Done |
| v0.140.0 | Numerical computation (8 modules) | ✅ Done |

See [docs/roadmap.md](docs/roadmap.md) and [docs/changelog.md](docs/changelog.md).

## Design References | 设计参考

- [CGAL](https://github.com/CGAL/cgal) — algorithm reference | 算法参考
- [Shapely](https://github.com/shapely/shapely) — API design reference | API 设计参考
- [scipy.spatial](https://docs.sc3y.org/doc/scipy/reference/spatial.html) — validation | 对照验证

## License | 许可证

[MIT](LICENSE)