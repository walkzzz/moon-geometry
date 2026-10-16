# Changelog | 变更日志

All notable changes to Moon Geometry are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/).

Moon Geometry 的所有重要变更记录于此。
格式基于 [Keep a Changelog](https://keepachangelog.com/)。

## [1.3.0] - 2026-10-16

### Added — Curve & Spline Algorithms | 曲线与样条算法（10 个模块）

- **Catmull-Rom Spline** (`catmull_rom`)：`catmull_rom_eval`, `catmull_rom_points`, `catmull_rom_derivative`
- **Hermite Spline** (`hermite`)：`hermite_eval`, `hermite_points`, `hermite_derivative`, `cardinal_tangents`
- **B-Spline** (`bspline`)：`bspline_basis`, `bspline_eval`, `uniform_knots`, `bspline_points`
- **Lagrange Interpolation** (`lagrange`)：`lagrange_eval`, `lagrange_basis`, `lagrange_interpolate`
- **Spline Utilities** (`spline`)：`spline_length`, `spline_curvature`, `spline_curvature_profile`
- **Arc Length** (`curve_arc`)：`arc_length`, `arc_length_at`, `arc_length_parametrize`
- **Curve Intersection** (`curve_intersect`)：`segments_cross`, `curve_self_intersect`, `curves_intersect`
- **Polyline** (`polyline`)：`polyline_length`, `polyline_simplify`, `polyline_subdivide`
- **Arc Length Utils** (`arc_length`)：`arc_length_segment`, `arc_length_total`, `arc_length_cumulative`
- **Curvature** (`curvature`)：`curvature_at`, `curvature_signed`, `curvature_profile`, `curvature_radius`

### Tests | 测试

- Added 50 tests, total 696 tests | 新增 50 测试，累计 696 测试
- All four targets green | 四目标全绿
- 65 modules total | 共 65 个模块

## [1.2.0] - 2026-10-16

### Added — Polygon Algorithms | 多边形算法（10 个模块）

- **Polygon Offset | 多边形偏移** (`polygon_offset` module)：`polygon_offset_outward`, `polygon_offset_inward`, `polygon_offset_area`, `polygon_offset_valid`
- **Polygon with Holes | 带孔多边形** (`polygon_holes` module)：`PolygonWithHoles`, `polygon_with_holes_area`, `polygon_with_holes_contains`, `polygon_with_holes_perimeter`
- **Visibility | 可见性** (`visibility` module)：`is_visible`, `visibility_polygon`, `visibility_polygon_convex`, `visible_vertex_count`
- **Art Gallery | 美术馆问题** (`art_gallery` module)：`art_gallery_guard_count`, `art_gallery_place_guards`, `art_gallery_covers_vertices`, `art_gallery_estimate`
- **Polygon Kernel | 多边形核** (`polygon_kernel` module)：`polygon_kernel`, `is_star_shaped`, `polygon_kernel_area`, `kernel_point`
- **Convex Decomposition | 凸分解** (`convex_decomp` module)：`convex_decomposition`, `convex_decomp_count`, `convex_decomp_lower_bound`, `convex_decomp_area`
- **Polygon Symmetry | 多边形对称** (`polygon_symmetry` module)：`has_reflection_symmetry`, `has_rotation_symmetry`, `polygon_symmetry_order`, `has_any_symmetry`
- **Polygon Cover | 多边形覆盖** (`polygon_cover` module)：`cover_by_rectangles`, `cover_by_triangles`, `cover_area_rectangles`, `cover_area_triangles`
- **Ear Clipping | 耳裁剪** (`ear_clip` module)：`is_ear`, `find_ear`, `ear_clip_triangulate`, `ear_clip_count`, `ear_clip_area`
- **Monotone Triangulation | 单调三角剖分** (`monotone` module)：`is_y_monotone`, `is_x_monotone`, `triangulate_monotone`, `monotone_triangulate_count`

### Tests | 测试

- Added 50 tests, total 646 tests | 新增 50 测试，累计 646 测试
- All four targets green, zero warnings | 四目标全绿，零警告
- 55 modules total | 共 55 个模块

## [1.1.0] - 2026-10-16

### Added — Convexity & Optimization | 凸性与优化（8 个模块）

- **Half-Plane | 半平面** (`half_plane` module)：`HalfPlane` struct, `half_plane_contains`, `half_plane_eval`, `half_plane_intersect`
- **Convex Clip | 凸多边形裁剪** (`convex_clip` module)：`clip_convex_by_line`, `clip_convex_by_half_plane`, `convex_area`
- **Convex Sum | 点集运算** (`convex_sum` module)：`point_set_sum`, `point_set_difference`, `point_set_scale`, `point_set_translate`, `point_set_centroid`, `point_set_equal`
- **Polar Dual | 极对偶** (`polar_dual` module)：`polar_dual_point`, `polar_dual`, `origin_inside`, `dual_area`
- **Linear Programming | 二维线性规划** (`linear_prog` module)：`LPResult`, `linear_program_2d`, `is_feasible`, `find_feasible_point`
- **3D Convex Hull | 三维凸包** (`convex_hull3d` module)：`HullFace`, `convex_hull_3d`, `hull_face_count`, `hull_volume`
- **Support Function | 支持函数** (`support` module)：`support_point_set`, `support_circle`, `support_value`, `support_segment`, `width_in_direction`
- **Separating Axis | 分离轴** (`separating` module)：`find_separating_axis`, `separating_distance`, `are_separated`

### Tests | 测试

- Added 36 tests, total 596 tests | 新增 36 测试，累计 596 测试
- All four targets green, zero warnings | 四目标全绿，零警告
- 45 modules total | 共 45 个模块

## [1.0.0] - 2026-10-15

### Added — Spatial Data Structures | 空间数据结构（8 个模块）

- **K-d Tree | K-d树** (`kdtree` module)：`build_kdtree`, `kdtree_nearest`, `kdtree_range_query`
- **Quadtree | 四叉树** (`quadtree` module)：`build_quadtree`, `quadtree_range_query`, `quadtree_count`
- **Grid Index | 网格索引** (`grid_index` module)：`build_grid_index`, `grid_query_radius`, `grid_query_rect`, `grid_query_cell`
- **Range Tree | 范围树** (`range_tree` module)：`build_range_tree`, `range_query`, `range_query_x`, `range_query_y`
- **Sorted Search | 有序搜索** (`sort_search` module)：`binary_search`, `lower_bound`, `upper_bound`, `unique_sorted`, `kth_element`, `merge_sorted`
- **Bucket PR k-d Tree | 桶PR树** (`bucket_pr` module)：`build_bucket_pr`, `bucket_pr_nearest`, `bucket_pr_count`
- **Spatial Hash | 空间哈希** (`spatial_hash` module)：`build_spatial_hash`, `spatial_hash_query_radius`, `spatial_hash_nearby`
- **BVH | 层次包围体** (`bvh` module)：`build_bvh`, `bvh_query`, `bvh_query_point`, `bvh_count_leaves`

### Tests | 测试

- Added 42 tests, total 560 tests | 新增 42 测试，累计 560 测试
- All four targets green, zero warnings | 四目标全绿，零警告
- 37 modules total | 共 37 个模块

## [0.9.0] - 2026-10-15

### Added — AABB Tree + Hash + Compare + Ray + Plane | AABB树 + 哈希 + 比较 + 射线 + 平面

- **AABB Tree | AABB树** (`aabb_tree` module)：
  - `build_aabb_tree`: build BVH from rectangles | 由矩形构建层次包围盒
  - `query_aabb`: overlap query | 重叠查询
  - `query_point_aabb`: point containment query | 点包含查询
  - `count_leaves` | 叶子节点计数
- **Geometric Hashing | 几何哈希** (`hash` module)：
  - `cell_index`, `cell_index_3d` | 网格单元索引
  - `cell_hash`, `cell_hash_3d` | 空间哈希
  - `segment_cells`, `segment_hash` | 线段哈希
  - `hash_combine` | 哈希合并
- **Comparison Predicates | 比较谓词** (`compare` module)：
  - `robust_orientation`, `robust_left_turn`, `robust_right_turn` | 鲁棒方向判定
  - `robust_collinear` | 共线判定
  - `compare_points`, `compare_segments`, `less_than`, `points_equal` | 字典序比较
- **Ray Operations | 射线运算** (`ray` module)：
  - `Ray::new`, `Ray::from_points`, `Ray::eval` | 射线构造与求值
  - `ray_segment_intersect`, `ray_line_intersect` | 射线相交
  - `ray_polygon_intersect`, `ray_polygon_contains` | 射线与多边形
- **3D Plane | 三维平面** (`plane` module)：
  - `Plane::from_normal_point`, `Plane::from_three_points` | 平面构造
  - `Plane::distance`, `Plane::contains` | 距离与包含
  - `Plane::line_intersect`, `Plane::normalize`, `Plane::project` | 相交、归一化、投影

### Tests | 测试

- Added 41 tests (7 aabb_tree + 8 hash + 10 compare + 8 ray + 8 plane), total 518 tests | 新增 41 测试，累计 518 测试
- All four targets green, zero warnings | 四目标全绿，零警告

## [0.8.0] - 2026-10-15

### Added — Vector + Matrix + Angle + Constants + Interval | 向量 + 矩阵 + 角度 + 常数 + 区间

- **Vector Operations | 向量运算** (`vector` module)：
  - `normalize`, `length`, `perp` | 归一化、长度、垂直向量
  - `reflect`, `project`, `reject` | 反射、投影、拒绝分量
  - `lerp`, `angle_between` | 线性插值、向量夹角
- **2x2 Matrix | 2x2 矩阵** (`matrix` module)：
  - `Mat2::new`, `identity`, `det`, `trace` | 构造、单位阵、行列式、迹
  - `mul`, `transform`, `inverse` | 矩阵乘法、变换、求逆
  - `rotation`, `scaling` | 旋转矩阵、缩放矩阵
- **Angle Utilities | 角度工具** (`angle` module)：
  - `deg_to_rad`, `rad_to_deg` | 角度弧度转换
  - `normalize_angle`, `normalize_angle_signed` | 归一化到 [0,2π) / [-π,π)
  - `angle_diff`, `bisector`, `is_between` | 角差、平分线、区间判定
- **Geometric Constants | 几何常数** (`constants` module)：
  - `pi`, `two_pi`, `half_pi`, `quarter_pi` | 圆周率族
  - `e`, `sqrt2`, `sqrt3`, `golden_ratio` | 数学常数
  - `deg2rad`, `rad2deg`, `eps` | 转换因子与精度
- **Interval Operations | 区间运算** (`interval` module)：
  - `Interval::new`, `contains`, `length`, `midpoint` | 构造、包含、长度、中点
  - `intersect`, `union`, `overlaps`, `contains_interval` | 交并集、重叠判定

### Tests | 测试

- Added 43 tests (9 vector + 9 matrix + 8 angle + 8 constants + 9 interval), total 477 tests | 新增 43 测试，累计 477 测试
- All four targets green, zero warnings | 四目标全绿，零警告

## [0.7.0] - 2026-10-15

### Added — Fitting + Sweep Line + Convex Polygon | 几何拟合 + 扫描线 + 凸多边形操作

- **Geometric Fitting | 几何拟合** (`fitting` module)：
  - `fit_line`: least-squares line fit with R² | 最小二乘直线拟合（含 R²）
  - `fit_line_orthogonal`: total least squares (PCA-based) | 正交距离回归
  - `fit_circle`: Kåsa method circle fit | Kåsa 方法圆拟合
  - `centroid`: point set centroid | 点集质心
- **Sweep Line | 扫描线** (`sweep_line` module)：
  - `has_any_intersection`, `count_intersections`, `find_all_intersections` | 相交检测
  - `find_intersection_points` | 交点计算
  - `is_simple_polygon_chain` | 简单多边形链检测
- **Convex Polygon Ops | 凸多边形操作** (`convex_polygon` module)：
  - `support_function`, `extreme_point` | 支持函数、极点查询
  - `point_in_convex_polygon`: O(log n) binary search | O(log n) 点包含
  - `tangent_from_point` | 外部点切线
  - `convex_polygons_intersect`: SAT O(n+m) | 分离轴定理相交检测
  - `point_to_convex_polygon_distance` | 点到凸多边形距离

### Tests | 测试

- Added 38 tests (13 fitting + 11 sweep_line + 14 convex_polygon), total 434 tests | 新增 38 测试，累计 434 测试
- All four targets green, zero warnings | 四目标全绿，零警告

## [0.6.0] - 2026-10-15

### Added — Rotating Calipers + Ellipse + Bezier | 旋转卡壳 + 椭圆 + 贝塞尔曲线

- **Rotating Calipers | 旋转卡壳** (`rotating_calipers` module)：
  - `convex_polygon_diameter`: farthest vertex pair, O(n) | 最远顶点对
  - `convex_polygon_width`: min parallel supporting line distance | 最小宽度
  - `farthest_point_pair`: from point set via hull + calipers | 点集最远点对
  - `min_perimeter_bounding_rect`: min perimeter enclosing rectangle | 最小周长包围矩形
- **Ellipse Geometry | 椭圆几何** (`ellipse` module)：
  - `Ellipse` type with center, semi-axes, rotation | 椭圆类型
  - `area`, `perimeter` (Ramanujan), `eccentricity`, `foci` | 面积、周长、离心率、焦点
  - `contains`, `on_boundary`, `line_intersect` | 包含、边界、直线相交
- **Bezier Curves | 贝塞尔曲线** (`bezier` module)：
  - `Bezier2` / `Bezier3`: quadratic and cubic curves | 二次/三次贝塞尔曲线
  - `eval`, `derivative`, `length` (numerical integration) | 求值、导数、弧长
  - `bbox`, `subdivide` | 包围盒、细分

### Tests | 测试

- Added 41 tests (13 rotating_calipers + 14 ellipse + 14 bezier), total 396 tests | 新增 41 测试，累计 396 测试
- All four targets (native/wasm-gc/js/wasm) green, zero warnings | 四目标全绿，零警告

## [0.5.0] - 2026-10-15

### Added — Phase 1-2: Tests + Circle Ops + Triangulate + Minkowski | 测试补充 + 圆相交 + 三角剖分 + Minkowski

- **Circle Intersection | 圆相交** (`circle_ops` module)：
  - `circle_segment_intersect`: circle-segment intersection points (0/1/2) | 圆与线段交点
  - `circle_circle_intersect`: circle-circle intersection points (0/1/2) | 两圆交点
  - `circle_line_intersect`: circle-line intersection points (0/1/2) | 圆与直线交点
  - `circle_polygon_intersect`: circle-polygon boundary intersection | 圆与多边形边界交点
- **Polygon Triangulation | 多边形三角剖分** (`triangulate` module)：
  - `triangulate_polygon`: ear clipping algorithm for simple polygon | ear clipping 简单多边形三角剖分
  - Returns vertex index triples `(i, j, k)` | 返回顶点索引三元组
- **Minkowski Operations | Minkowski 运算** (`minkowski` module)：
  - `minkowski_sum_convex`: Minkowski sum of two convex polygons | 两凸多边形 Minkowski 和
  - `minkowski_difference_convex`: Minkowski difference A ⊖ B = A ⊕ (-B) | Minkowski 差
  - `minkowski_sum_circle_polygon`: rounded polygon (circle + convex polygon) | 圆角多边形
  - `convex_polygons_collide`: collision detection via Minkowski difference | 碰撞检测
- **Test Coverage | 测试覆盖**：
  - Phase 1: added 50+ boundary/degenerate/property tests across 10 modules | 为 10 个模块补充边界/退化/属性测试
  - Phase 2: added 34 tests (13 circle_ops + 10 triangulate + 11 minkowski) | 新增 34 测试

### Tests | 测试

- Total 355 tests, all four targets (native/wasm-gc/js/wasm) green | 累计 355 测试，四目标全绿

### Fixed | 修复

- Eliminated all compiler warnings (unused package, deprecated APIs) | 消除所有编译器警告

## [0.4.0] - 2026-10-15

### Added — Week 4: Transforms + Distance + Bounding + Re-export | 几何变换 + 距离 + 包围盒 + 重导出

- **Geometric Transforms | 几何变换**：
  - `translate` / `translate_points`: point and array translation | 点与数组平移
  - `rotate` / `rotate_around` / `rotate_points`: rotation around origin/center | 绕原点/中心旋转
  - `scale` / `scale_around`: scaling relative to origin/center | 相对原点/中心缩放
  - `affine_transform` / `affine_transform_points`: general affine (a*x+b*y+c, d*x+e*y+f) | 一般仿射变换
  - `mirror_x` / `mirror_y` / `mirror_origin` / `mirror_line`: reflections | 镜像反射
  - `shear`: shear transform (x+kx*y, y+ky*x) | 剪切变换
- **Distance Computations | 距离计算**：
  - `point_to_segment_distance` / `point_to_polygon_distance` / `point_to_line_distance` | 点到线段/多边形/直线距离
  - `segment_to_segment_distance`: with intersection check | 线段间距离（含相交检测）
  - `polygon_to_polygon_distance`: edge-pair minimum distance | 多边形间最小距离
- **Bounding Volumes | 包围体**：
  - `aabb` / `aabb_polygon`: axis-aligned bounding box | 轴对齐包围盒
  - `min_area_bounding_rect`: rotating calipers on convex hull, returns (cx, cy, w, h, angle) | 旋转卡壳最小面积包围矩形
  - `bounding_circle`: centroid + max-distance approximation | 包围圆（质心+最大距离近似）
- **Re-export Module | 重导出模块**：
  - Root package `walkzzz/moon-geometry` re-exports all types and functions | 根包重导出全部类型和函数
  - Single import: `import "walkzzz/moon-geometry"` | 单包导入即可访问全部 API

### Tests | 测试

- Added 58 tests (25 transform + 18 distance + 15 bounding), total 271 tests, all four targets green | 新增 58 测试，累计 271 测试，四目标全绿

### Fixed | 修复

- `segment_to_segment_distance`: added intersection check for overlapping segments | 增加相交检测修复重叠线段距离

## [0.3.0] - 2026-10-15

### Added — Week 3: Delaunay Triangulation + Voronoi Diagram | Delaunay 三角剖分 + Voronoi 图

- **Delaunay Triangulation | Delaunay 三角剖分**：
  - `delaunay_triangulation`: Bowyer-Watson incremental insertion, O(n²) expected | Bowyer-Watson 增量插入法，O(n²) 期望
  - Super-triangle enclosure, bad triangle detection, hole re-triangulation | 超三角形包围、坏三角形检测、空洞重三角化
  - Returns CCW vertex index triples `TriangleIdx` | 返回 CCW 方向的顶点索引三元组 `TriangleIdx`
- **Voronoi Diagram | Voronoi 图**：
  - `voronoi_diagram`: Delaunay duality, returns (vertices, edges) | Delaunay 对偶，返回 (顶点, 边)
  - Vertices are Delaunay triangle circumcenters, edges connect adjacent circumcenters | 顶点为 Delaunay 三角形外心，边连接相邻三角形外心

### Tests | 测试

- Added 80 tests, total 213 tests, all four targets green | 新增 80 测试，累计 213 测试，四目标全绿
- Coverage: empty/degenerate input, convex polygons, grid points, star configurations, area consistency, circumcenter equidistance, no overlapping triangles | 覆盖：空/退化输入、凸多边形、网格点、星形配置、面积一致性、外心等距性、无重叠三角形

## [0.2.0] - 2026-10-15

### Added — Week 2: Segment Intersection + Closest Pair + Polygon Boolean Ops | 线段相交 + 最近点对 + 多边形布尔运算

- **Segment Intersection | 线段相交**：
  - `segments_intersect`: segment intersection test (including endpoint contact, collinear overlap) | 线段相交检测（含端点接触、共线重叠）
  - `segment_intersection`: intersection point computation (parametric, with collinear overlap) | 线段交点计算（参数化求解，含共线重叠）
  - `line_segment_intersection`: line-segment intersection | 直线与线段交点
- **Closest Pair | 最近点对**：
  - `closest_pair`: divide & conquer O(n log n), returns closest pair and distance | 分治法 O(n log n)，返回最近点对及距离
- **Polygon Boolean Ops | 多边形布尔运算**：
  - `clip_polygon`: Sutherland-Hodgman rectangle clipping | Sutherland-Hodgman 矩形裁剪
  - `polygon_intersection`: convex polygon intersection (Sutherland-Hodgman) | 凸多边形交集（Sutherland-Hodgman）
  - `polygon_union_area` / `polygon_difference_area`: union/difference area (inclusion-exclusion) | 并集/差集面积（容斥原理）

### Tests | 测试

- Added 45 tests, total 133 tests, all four targets green | 新增 45 测试，累计 133 测试，四目标全绿

## [0.1.0] - 2026-10-15

### Added — Week 1: Basic Types + Convex Hull + Polygon Ops | 基础类型 + 凸包 + 多边形操作

- **Basic Geometric Types | 基础几何类型**：
  - `Point2D` / `Point3D`: distance, add/sub, scalar mul, dot/cross, approx_eq | 距离、加减、数乘、点积、叉积、近似相等
  - `Segment`: length, direction, midpoint | 长度、方向、中点
  - `Line` (general form ax+by+c=0): from two points, point-to-line distance, evaluate | 一般式 ax+by+c=0：从两点构造、点到直线距离、方程求值
  - `Polygon`: vertex sequence, size, index access (wrapping) | 顶点序列、大小、按索引取顶点（环绕）
  - `Triangle`: signed area, area, centroid, circumcenter, incenter | 有符号面积、面积、质心、外心、内心
  - `Circle`: area, perimeter, contains | 面积、周长、包含判定
  - `Rectangle` (AABB): area, perimeter, width/height, contains, union, intersection | 面积、周长、宽高、包含、并集、交集
  - `Orientation` enum (Clockwise / CounterClockwise / Collinear) | 方向枚举
- **Convex Hull | 凸包**：
  - `convex_hull_andrew`: Andrew's monotone chain, O(n log n), numerically stable | Andrew 单调链法，O(n log n)，数值稳定
  - `convex_hull_graham`: Graham scan, O(n log n) | Graham 扫描法，O(n log n)
  - `ccw`: three-point orientation test | 三点方向判定
- **Polygon Ops | 多边形操作**：
  - `polygon_area` / `polygon_signed_area`: Shoelace formula | Shoelace 公式
  - `polygon_perimeter`, `polygon_centroid` (area-weighted) | 周长、重心（加权面积法）
  - `polygon_orientation`: orientation test | 方向判定
  - `is_convex`: convexity test | 凸性判断
  - `point_in_polygon`: ray casting point-in-polygon | 射线法点在多边形内
  - `simplify_polygon`: Douglas-Peucker simplification | Douglas-Peucker 简化
- **Utils | 工具**: `approx_eq` tolerance comparison, `default_eps` default precision | 容差比较、默认精度

### Tests | 测试

- 88 MoonBit tests, all four targets (native / wasm-gc / js / wasm) green | 88 个 MoonBit 测试，四目标全绿
- Correctness + boundary + degenerate cases (collinear, coincident, empty, single/two-point) | 正确性 + 边界 + 退化情况测试

### Infrastructure | 基础设施

- Project scaffold: `moon.mod` / `moon.pkg`, pure MoonBit zero C FFI | 项目骨架，纯 MoonBit 零 C FFI
- Bilingual README (Chinese / English) | 中英文 README 同步
- changelog / roadmap documentation governance | changelog / roadmap 文档治理