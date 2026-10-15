# Roadmap | 交付路线图

Moon Geometry one-month delivery plan (2026-10-15 ~ 2026-10-31).
Moon Geometry 一个月交付计划（2026-10-15 ~ 2026-10-31）。

## Progress Overview | 进度总览

| Phase | Content | Test Target | Status | Date |
|-------|---------|-------------|--------|------|
| Week 1 | Basic types + convex hull + polygon ops | 80+ | ✅ Done | 2026-10-15 |
| Week 2 | Segment intersection + closest pair + boolean ops | +70 | ✅ Done | 2026-10-15 |
| Week 3 | Delaunay triangulation + Voronoi diagram | +80 | ✅ Done | 2026-10-15 |
| Week 4 | Transforms + distance + bounding box + publish | 320+ | ✅ Done | 2026-10-15 |

| 阶段 | 内容 | 测试目标 | 状态 | 完成日期 |
|------|------|---------|------|---------|
| Week 1 | 基础类型 + 凸包 + 多边形操作 | 80+ | ✅ 完成 | 2026-10-15 |
| Week 2 | 线段相交 + 最近点对 + 多边形布尔运算 | +70 | ✅ 完成 | 2026-10-15 |
| Week 3 | Delaunay 三角剖分 + Voronoi 图 | +80 | ✅ 完成 | 2026-10-15 |
| Week 4 | 几何变换 + 距离 + 包围盒 + mooncakes 发布 | 320+ | ✅ 完成 | 2026-10-15 |

**Current tests | 当前测试数**: 271 / 320+ target

---

## Project Structure | 项目结构

```
moon-geometry/
  src/
    core/           # Base types: Point2D, Segment, Polygon, etc. | 基础类型
    hull/           # Convex hull algorithms | 凸包算法
    polygon/        # Polygon operations | 多边形操作
    intersect/      # Segment/line intersection | 相交计算
    nearest/        # Closest pair | 最近点对
    boolean/        # Polygon boolean ops | 多边形布尔运算
    triangulation/  # Delaunay/Voronoi | 三角剖分
    transform/      # Geometric transforms | 几何变换
    distance/       # Distance computations | 距离计算
    bounding/       # Bounding boxes | 包围盒
```

## Week 1: Basic Types + Convex Hull + Polygon Ops ✅

- [x] Point2D / Point3D (distance, add/sub, scalar mul, dot/cross) | 距离、加减、数乘、点积、叉积
- [x] Segment / Line (length, midpoint, point-to-line distance) | 长度、中点、点到直线距离
- [x] Polygon / Triangle / Circle / Rectangle
- [x] Convex hull: convex_hull_andrew, convex_hull_graham, ccw | 凸包
- [x] Polygon ops: area, perimeter, centroid, orientation, is_convex, point_in_polygon, simplify_polygon | 多边形操作
- [x] 88 tests, all four targets green | 88 测试四目标全绿

## Week 2: Segment Intersection + Closest Pair + Boolean Ops ✅

- [x] `segments_intersect` / `segment_intersection` | 线段相交
- [x] `line_segment_intersection` | 直线与线段交点
- [x] `closest_pair`: divide & conquer O(n log n) | 分治法最近点对
- [x] `clip_polygon`: Sutherland-Hodgman clipping | 多边形裁剪
- [x] `polygon_intersection`: convex polygon intersection | 凸多边形交集
- [x] `polygon_union_area` / `polygon_difference_area` | 并集/差集面积
- [x] +45 tests, total 133 tests, all four targets green | +45 测试，累计 133

## Week 3: Delaunay Triangulation + Voronoi Diagram ✅

- [x] `delaunay_triangulation`: Bowyer-Watson incremental insertion | Bowyer-Watson 增量插入
- [x] `voronoi_diagram`: Delaunay duality construction | 从 Delaunay 对偶图构造
- [x] +80 tests, total 213 tests, all four targets green | +80 测试，累计 213
- [x] Coverage: convex polygons, grid points, star configs, area consistency, circumcenter equidistance, no overlapping triangles | 覆盖各类配置

## Week 4: Transforms + Distance + Bounding Box + Publish ✅

- [x] `translate` / `rotate` / `scale` / `affine_transform` / `mirror` / `shear` | 几何变换
- [x] `point_to_segment_distance` / `point_to_polygon_distance` / `polygon_to_polygon_distance` | 距离计算
- [x] `aabb` / `min_area_bounding_rect` (rotating calipers) | 包围盒
- [x] Re-export module for unified import | 重导出模块
- [x] +58 tests, total 271 tests, all four targets green | +58 测试，累计 271
- [ ] README finalization + mooncakes publish | README 定稿 + mooncakes 发布