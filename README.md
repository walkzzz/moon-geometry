# Moon Geometry

> 纯 MoonBit 计算几何库 | 2026 MoonBit 十月赛参赛项目
> Pure MoonBit computational geometry library | 2026 MoonBit October Hackathon entry

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MoonBit](https://img.shields.io/badge/MoonBit-0.1.20260920-blue.svg)](https://moonbitlang.com)
[![Tests](https://img.shields.io/badge/tests-477-brightgreen.svg)]()
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

```
src/
  core/           # 基础类型 | Base types (Point2D, Segment, Polygon, ...)
  hull/           # 凸包 | Convex hull
  polygon/        # 多边形操作 | Polygon operations
  intersect/      # 相交 | Intersection
  nearest/        # 最近点对 | Closest pair
  boolean/        # 布尔运算 | Boolean operations
  triangulation/  # 三角剖分 | Delaunay/Voronoi
  transform/      # 几何变换 | Geometric transforms
  distance/       # 距离 | Distance computations
  bounding/       # 包围盒 | Bounding boxes
  circle_ops/     # 圆相交 | Circle intersection
  triangulate/    # 多边形三角剖分 | Polygon triangulation (ear clipping)
  minkowski/      # Minkowski 运算 | Minkowski operations
  rotating_calipers/ # 旋转卡壳 | Rotating calipers
  ellipse/        # 椭圆几何 | Ellipse geometry
  bezier/         # 贝塞尔曲线 | Bezier curves
  fitting/        # 几何拟合 | Geometric fitting
  sweep_line/     # 扫描线 | Sweep line
  convex_polygon/ # 凸多边形操作 | Convex polygon ops
  vector/         # 向量运算 | Vector operations
  matrix/         # 矩阵 | 2x2 matrices
  angle/          # 角度工具 | Angle utilities
  constants/      # 几何常数 | Geometric constants
  interval/       # 区间运算 | Interval operations
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

完整接口见 `moon info` 生成的 `.mbti` 文件。Full interface in `.mbti` files generated by `moon info`.

## 测试 | Tests

```bash
moon test                          # 全部 477 测试 | all 477 tests
moon test --target native          # 四目标分别验证 | verify each backend
moon test --target wasm-gc
moon test --target js
moon test --target wasm
```

四目标全绿：477 × 4 = 1908 次测试通过。
All four targets pass: 477 × 4 = 1908 test runs green.

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