# Moon Geometry

> 纯 MoonBit 计算几何库 | 2026 MoonBit 十月赛参赛项目

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MoonBit](https://img.shields.io/badge/MoonBit-0.1.20260920-blue.svg)](https://moonbitlang.com)
[![Tests](https://img.shields.io/badge/tests-213-brightgreen.svg)]()
[![Targets](https://img.shields.io/badge/targets-native%20%7C%20wasm--gc%20%7C%20js%20%7C%20wasm-green.svg)]()

Moon Geometry 是一个**纯 MoonBit** 实现的计算几何库，**零 C FFI 依赖**，四目标（native / wasm-gc / js / wasm）原生支持。为 CAD、碰撞检测、GIS、路径规划、图像处理等场景提供可复用的几何算法基础组件。

## 特性

- **基础几何类型**：`Point2D` / `Point3D` / `Segment` / `Line` / `Polygon` / `Triangle` / `Circle` / `Rectangle`
- **凸包**：Graham 扫描法、Andrew 单调链法（O(n log n)）
- **多边形操作**：面积（Shoelace）、周长、质心、点在多边形内（射线法）、凸性判断、方向判定、Douglas-Peucker 简化
- **方向判定**：`ccw` 三点方向测试
- **Delaunay 三角剖分**：Bowyer-Watson 增量插入法（O(n²) 期望）
- **Voronoi 图**：Delaunay 对偶，外心为顶点
- **纯 MoonBit 零依赖**：无 C FFI，四目标共用代码库，无条件编译
- **退化情况全覆盖**：共线点、重合点、空输入、单点/两点退化均有处理

## 安装

```bash
moon add walkzzz/moon-geometry
```

## 快速示例

```moonbit
let points = [
  Point2D::new(0.0, 0.0),
  Point2D::new(4.0, 0.0),
  Point2D::new(4.0, 4.0),
  Point2D::new(0.0, 4.0),
  Point2D::new(2.0, 2.0),  // 内部点
]
let hull = convex_hull_andrew(points)  // 凸包顶点（逆时针）
let poly = Polygon::new(points)
let area = polygon_area(poly)          // 多边形面积
```

## API 概览

| 模块 | 主要 API |
|------|---------|
| 点 | `Point2D::new/dist/dot/cross/add/sub/mul`、`Point3D` 同构 |
| 线段/直线 | `Segment::length/midpoint`、`Line::from_points/point_distance` |
| 多边形 | `polygon_area/perimeter/centroid/orientation`、`is_convex`、`point_in_polygon`、`simplify_polygon` |
| 凸包 | `convex_hull_andrew`、`convex_hull_graham`、`ccw` |
| 相交 | `segments_intersect`、`segment_intersection`、`line_segment_intersection` |
| 最近点对 | `closest_pair`（分治 O(n log n)） |
| 布尔运算 | `clip_polygon`、`polygon_intersection`、`polygon_union_area`、`polygon_difference_area` |
| 三角剖分 | `delaunay_triangulation`（Bowyer-Watson）、`voronoi_diagram`（对偶） |
| 三角形 | `Triangle::area/centroid/circumcenter/incenter` |
| 圆/矩形 | `Circle::area/perimeter/contains`、`Rectangle::area/union/intersection` |

完整接口见 `moon info` 生成的 `.mbti` 文件。

## 测试

```bash
moon test                          # 全部 213 测试
moon test --target native          # 四目标分别验证
moon test --target wasm-gc
moon test --target js
moon test --target wasm
```

四目标全绿：213 × 4 = 852 次测试通过。

## 交付路线图

| 阶段 | 内容 | 状态 |
|------|------|------|
| Week 1 | 基础类型 + 凸包 + 多边形操作 | ✅ 完成（88 测试） |
| Week 2 | 线段相交 + 最近点对 + 多边形布尔运算 | ✅ 完成（累计 133 测试） |
| Week 3 | Delaunay 三角剖分 + Voronoi 图 | ✅ 完成（累计 213 测试） |
| Week 4 | 几何变换 + 距离 + 包围盒 + mooncakes 发布 | ⏸ 待开始 |

详见 [docs/roadmap.md](docs/roadmap.md) 与 [docs/changelog.md](docs/changelog.md)。

## 设计参考

- [CGAL](https://github.com/CGAL/cgal) — 算法参考
- [Shapely](https://github.com/shapely/shapely) — API 设计参考
- [scipy.spatial](https://docs.scipy.org/doc/scipy/reference/spatial.html) — Delaunay/Voronoi 对照验证

本项目为原创实现，使用 Double 浮点运算，以 MoonBit 原生类型系统组织几何类型。

## 许可证

[MIT](LICENSE)