# Changelog

All notable changes to Moon Geometry are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/).

## [0.2.0] - 2026-10-15

### Added — Week 2: 线段相交 + 最近点对 + 多边形布尔运算

- **线段相交**：
  - `segments_intersect`：线段相交检测（含端点接触、共线重叠）
  - `segment_intersection`：线段交点计算（参数化求解，含共线重叠）
  - `line_segment_intersection`：直线与线段交点
- **最近点对**：
  - `closest_pair`：分治法 O(n log n)，返回最近点对及距离
- **多边形布尔运算**：
  - `clip_polygon`：Sutherland-Hodgman 矩形裁剪
  - `polygon_intersection`：凸多边形交集（Sutherland-Hodgman）
  - `polygon_union_area` / `polygon_difference_area`：并集/差集面积（容斥原理）

### Tests

- 新增 45 测试，累计 133 测试，四目标全绿

## [0.1.0] - 2026-10-15

### Added — Week 1: 基础类型 + 凸包 + 多边形操作

- **基础几何类型**：
  - `Point2D` / `Point3D`：距离、加减、数乘、点积、叉积、近似相等
  - `Segment`：长度、方向、中点
  - `Line`（一般式 ax+by+c=0）：从两点构造、点到直线距离、方程求值
  - `Polygon`：顶点序列、大小、按索引取顶点（环绕）
  - `Triangle`：有符号面积、面积、质心、外心、内心
  - `Circle`：面积、周长、包含判定
  - `Rectangle`（AABB）：面积、周长、宽高、包含、并集、交集
  - `Orientation` 枚举（Clockwise / CounterClockwise / Collinear）
- **凸包**：
  - `convex_hull_andrew`：Andrew 单调链法，O(n log n)，数值稳定
  - `convex_hull_graham`：Graham 扫描法，O(n log n)
  - `ccw`：三点方向判定
- **多边形操作**：
  - `polygon_area` / `polygon_signed_area`：Shoelace 公式
  - `polygon_perimeter`、`polygon_centroid`（加权面积法）
  - `polygon_orientation`：方向判定
  - `is_convex`：凸性判断
  - `point_in_polygon`：射线法点在多边形内
  - `simplify_polygon`：Douglas-Peucker 简化
- **工具**：`approx_eq` 容差比较、`default_eps` 默认精度

### Tests

- 88 个 MoonBit 测试，覆盖四目标（native / wasm-gc / js / wasm）全绿
- 含正确性测试 + 边界测试 + 退化情况测试（共线、重合、空输入、单点/两点）

### Infrastructure

- 项目骨架：`moon.mod` / `moon.pkg`，纯 MoonBit 零 C FFI
- 中英文 README 同步
- changelog / roadmap 文档治理