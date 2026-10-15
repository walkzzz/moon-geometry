# Moon Geometry

> Pure MoonBit computational geometry library | 2026 MoonBit October Hackathon entry
> 纯 MoonBit 计算几何库 | 2026 MoonBit 十月赛参赛项目

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MoonBit](https://img.shields.io/badge/MoonBit-0.1.20260920-blue.svg)](https://moonbitlang.com)
[![Tests](https://img.shields.io/badge/tests-434-brightgreen.svg)]()
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

Full interface in `.mbti` files. 完整接口见 `.mbti` 文件。

## Tests | 测试

```bash
moon test                          # all 434 tests | 全部 434 测试
moon test --target native          # verify each backend | 四目标分别验证
moon test --target wasm-gc
moon test --target js
moon test --target wasm
```

All four targets pass: 434 × 4 = 1736. 四目标全绿：434 × 4 = 1736。

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

See [docs/roadmap.md](docs/roadmap.md) and [docs/changelog.md](docs/changelog.md).

## Design References | 设计参考

- [CGAL](https://github.com/CGAL/cgal) — algorithm reference | 算法参考
- [Shapely](https://github.com/shapely/shapely) — API design reference | API 设计参考
- [scipy.spatial](https://docs.sc3y.org/doc/scipy/reference/spatial.html) — validation | 对照验证

## License | 许可证

[MIT](LICENSE)