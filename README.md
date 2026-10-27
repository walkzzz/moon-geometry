# Moon Geometry

> 纯 MoonBit 计算几何库 | 2026 MoonBit 十月赛参赛项目
> Pure MoonBit computational geometry library | 2026 MoonBit October Hackathon entry

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MoonBit](https://img.shields.io/badge/MoonBit-0.1.20260920-blue.svg)](https://moonbitlang.com)
[![Tests](https://img.shields.io/badge/tests-3156-brightgreen.svg)]()
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
- **统一公差体系 | Tolerance system**: configurable `ToleranceCtx` for distance/angle/area, default/strict/loose presets | 可配置 `ToleranceCtx` 公差上下文，预设 default/strict/loose
- **退化构型鲁棒性 | Degenerate robustness**: detect collinear/overlap/zero-area/self-intersect/small-angle, remove coincident points | 检测共线/重叠/零面积/自交/极小角度，移除重合点
- **拓扑一致性验证 | Topology validation**: closed manifold check, non-manifold edges, dangling edges, isolated vertices, normal consistency | 闭合流形检测、非流形边、悬挂边、孤立顶点、法向一致性
- **增量计算 | Incremental computation**: incremental Delaunay with dynamic insert/remove, supports interactive editing | 增量 Delaunay 动态插入/删除，支持交互式编辑
- **重网格化 | Remeshing**: isotropic remeshing with edge split/collapse to target length | 各向同性重网格化，边分割/折叠至目标长度
- **非流形修复 | Non-manifold repair**: detect and repair non-manifold edges by vertex duplication | 检测并修复非流形边，通过顶点复制
- **CAD 拉伸/扫掠 | CAD extrude/sweep**: extrude 2D polygon along axis/direction, sweep profile along 3D path, revolve around axis | 2D 多边形沿轴/方向拉伸，轮廓沿 3D 路径扫描，绕轴旋转

## 安装 | Installation

```bash
moon add walkzzz/moon-geometry
```

## 项目结构 | Project Structure

287 个模块按 10 个领域分类组织 | 287 modules organized into 10 domain categories：

```
base/          # (32) Core types & robust arithmetic | 基础类型与鲁棒算术
geometry/      # (65) Convex hull, polygon, triangulation, computational geometry | 凸包、多边形、三角剖分、计算几何
transform/     # (19) Geometric transforms & differential geometry | 几何变换与微分几何
spatial/       # (30) Spatial data structures & distance metrics | 空间数据结构与距离度量
curves/        # (27) Curves, splines & algebraic geometry | 曲线、样条与代数几何
mesh/          # (31) Mesh processing & topological data analysis | 网格处理与拓扑数据分析
numerics/      # (24) Numerical optimization & PDE solvers | 数值优化与偏微分方程求解
applied/       # (29) Robotics, ML, point cloud & statistics | 机器人、机器学习、点云与统计
io/            # (18) File I/O & graphics rendering | 文件输入输出与图形渲染
testing/       # (12) Testing infrastructure & utilities | 测试基础设施与工具
```

## 快速示例 | Quick Example

```moonbit
// 1. 凸包计算 | Convex hull
let points = [
  @moon_geometry.Point2D::new(0.0, 0.0),
  @moon_geometry.Point2D::new(4.0, 0.0),
  @moon_geometry.Point2D::new(4.0, 4.0),
  @moon_geometry.Point2D::new(0.0, 4.0),
  @moon_geometry.Point2D::new(2.0, 2.0),  // 内部点 | interior point
]
let hull = @moon_geometry.convex_hull_andrew(points)  // 凸包顶点（逆时针）

// 2. 多边形面积 | Polygon area
let polygon = [
  @moon_geometry.Point2D::new(0.0, 0.0),
  @moon_geometry.Point2D::new(4.0, 0.0),
  @moon_geometry.Point2D::new(4.0, 4.0),
  @moon_geometry.Point2D::new(0.0, 4.0),
]
let area = @moon_geometry.polygon_area(polygon)  // 16.0

// 3. Delaunay 三角剖分 | Delaunay triangulation
let tri = @moon_geometry.delaunay_triangulation(points)

// 4. 几何变换 | Transform
let affine = @moon_geometry.Affine2::new(
  1.0, 0.0, 0.0,  // a, b, c
  0.0, 1.0, 0.0,  // d, e, f
)
let transformed = affine.apply(@moon_geometry.Point2D::new(1.0, 1.0))

// 5. 距离计算 | Distance
let dist = @moon_geometry.Point2D::new(0.0, 0.0).dist(
  @moon_geometry.Point2D::new(3.0, 4.0)
)  // 5.0

// 6. 点在多边形内 | Point in polygon
let inside = @moon_geometry.point_in_polygon(
  @moon_geometry.Point2D::new(2.0, 2.0),
  polygon
)  // true

// 7. Trait 多态 | Trait polymorphism (Measurable)
let circle = @moon_geometry.Circle::new(
  @moon_geometry.Point2D::new(0.0, 0.0),
  5.0
)
let circle_area = circle.area()  // 78.54...

// 8. 形式化验证 | Proof-carrying code
// dist 函数带有非负性契约: proof_ensure: result => result >= 0.0
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
moon test                          # 全部 2307 测试 | all 2307 tests
moon test --target native          # 四目标分别验证 | verify each backend
moon test --target wasm-gc
moon test --target js
moon test --target wasm
```

四目标全绿：2307 × 4 = 9228 次测试通过。
All four targets pass: 2307 × 4 = 9228 test runs green.

## 使用场景 | Use Cases

| 场景 | Scenario | 推荐模块 | Recommended modules |
|------|-----------|----------|---------------------|
| CAD/几何建模 | CAD/Geometry modeling | `base/core`, `geometry/hull`, `geometry/polygon`, `curves/bezier`, `transform/affine2` |
| 碰撞检测 | Collision detection | `applied/collision_detect`, `applied/gjk`, `applied/sat`, `geometry/minkowski` |
| 路径规划 | Path planning | `applied/rrt`, `applied/prm`, `applied/a_star`, `applied/shortest_path` |
| GIS/地理信息 | GIS/Geospatial | `testing/gis_projection`, `testing/gis_buffer`, `io/geojson_io`, `applied/tin` |
| 网格处理 | Mesh processing | `mesh/mesh_data`, `mesh/mesh_simplify`, `mesh/mesh_smooth`, `mesh/marching_cubes` |
| 数据可视化 | Data visualization | `io/svg_out`, `io/rasterization`, `io/ray_tracing` |
| 机器学习 | Machine learning | `applied/clustering`, `applied/icp`, `applied/shape_matching` |
| 数值优化 | Numerical optimization | `numerics/gradient_descent`, `numerics/newton_method`, `numerics/levenberg_marquardt` |
| 拓扑分析 | Topological analysis | `mesh/persistent_homology`, `mesh/alpha_complex`, `mesh/reeb_graph` |
| 鲁棒计算 | Robust computation | `base/robust_arith`, `base/exact_predicates`, `base/adaptive_pred` |

## Trait 系统 | Trait System

库提供 12 个 `pub(open) trait`，支持跨包多态调度：

| Trait | 方法 | 实现类型 |
|-------|------|---------|
| `PointTransform` | `apply`, `apply_batch` | Affine2, Rigid, Similarity |
| `Curve2D` | `eval`, `derivative`, `length` | Bezier2, Bezier3 |
| `Measurable` | `area` | Circle, Rectangle, Triangle, Ellipse |
| `PerimeterMeasurable` | `perimeter` | Circle, Rectangle, Ellipse |
| `Containable` | `contains` | Circle, Rectangle, Ellipse |
| `Measurable3D` | `volume`, `surface_area` | AABB3D, BoundingSphere, OBB, Polyhedron |
| `Composable` | `compose` | Affine2, Rigid, Similarity, Homography |
| `VertexCountable` | `vertex_count` | DCEL, Delaunay3D, PlanarGraph, Mesh, Polyhedron, ... |
| `FaceCountable` | `face_count` | DCEL, PlanarGraph, DynamicHull3D, Mesh, Polyhedron, ... |
| `EdgeCountable` | `edge_count` | DCEL, PlanarGraph, Mesh, Polyhedron, ReebGraph |
| `Bounded2D` | `bbox` | Bezier2, Bezier3 |
| `Subdivisible` | `subdivide` | Bezier2, Bezier3 |

## 形式化验证 | Formal Verification

核心函数带有 `proof_ensure` 契约，确保数学性质正确：

| 函数 | 契约 | 性质 |
|------|------|------|
| `Point2D::dist` | `result >= 0.0` | 距离非负性 |
| `Point2D::dist_sq` | `result >= 0.0` | 距离平方非负性 |
| `Point2D::dot` | `result == other.x * self.x + other.y * self.y` | 点积对称性 |
| `Point2D::cross` | `result == -(other.x * self.y - other.y * self.x)` | 叉积反对称性 |
| `turn` | `result == -(...)` | 叉积反对称性 |
| `approx_eq` | `result == ((b - a).abs() <= eps)` | 近似比较对称性 |
| `polyline_length` | `result >= 0.0` | 折线长度非负性 |
| `min_dist_to_set` | `result >= 0.0` | 最小距离非负性 |

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
| v0.239.0 | v0.239.0 | Warning 治理（204→0）| Warning governance (204→0) | ✅ 完成 | ✅ Done |
| v0.240.0 | v0.240.0 | Curve2D trait + 代码去重 | Curve2D trait + code dedup | ✅ 完成 | ✅ Done |
| v0.245.0 | v0.245.0 | 项目瘦身（401→283 模块）| Project slimming (401→283) | ✅ 完成 | ✅ Done |
| v0.249.0 | v0.249.0 | 10 分类合并 + CRAP 优化 + 形式化验证 | 10-category merge + CRAP optimization + proof | ✅ 完成 | ✅ Done |

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