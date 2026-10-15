# Roadmap

Moon Geometry 一个月交付计划（2026-10-15 ~ 2026-10-31）。

## 进度总览

| 阶段 | 内容 | 测试目标 | 状态 | 完成日期 |
|------|------|---------|------|---------|
| Week 1 | 基础类型 + 凸包 + 多边形操作 | 80+ | ✅ 完成 | 2026-10-15 |
| Week 2 | 线段相交 + 最近点对 + 多边形布尔运算 | +70 | ⏳ 进行中 | — |
| Week 3 | Delaunay 三角剖分 + Voronoi 图 | +80 | ⏸ 待开始 | — |
| Week 4 | 几何变换 + 距离 + 包围盒 + mooncakes 发布 | 320+ | ⏸ 待开始 | — |

**当前测试数**：88 / 320+ 目标

---

## Week 1：基础类型 + 凸包 + 多边形操作 ✅

- [x] Point2D / Point3D（距离、加减、数乘、点积、叉积）
- [x] Segment / Line（长度、中点、点到直线距离）
- [x] Polygon / Triangle / Circle / Rectangle
- [x] 凸包：convex_hull_andrew、convex_hull_graham、ccw
- [x] 多边形操作：area、perimeter、centroid、orientation、is_convex、point_in_polygon、simplify_polygon
- [x] 88 测试四目标全绿
- [x] README 骨架

## Week 2：线段相交 + 最近点对 + 多边形布尔运算 ⏳

- [ ] `segments_intersect` / `segment_intersection`：线段相交检测与交点
- [ ] `line_segment_intersection`：直线与线段交点
- [ ] `closest_pair`：分治法最近点对 O(n log n)
- [ ] `polygon_union` / `polygon_intersection` / `polygon_difference`：Greiner-Hormann
- [ ] `clip_polygon`：Sutherland-Hodgman 裁剪
- [ ] +70 测试，含退化情况

## Week 3：Delaunay 三角剖分 + Voronoi 图 ⏸

- [ ] `delaunay_triangulation`：Bowyer-Watson 增量插入
- [ ] 约束 Delaunay（CDT）基础入口
- [ ] `voronoi_diagram`：从 Delaunay 对偶图构造
- [ ] Voronoi 裁剪到包围盒
- [ ] +80 测试，与 scipy.spatial 对照

## Week 4：几何变换 + 距离 + 包围盒 + 发布 ⏸

- [ ] `translate` / `rotate` / `scale` / `affine_transform` / `mirror`
- [ ] `point_to_segment_distance` / `point_to_polygon_distance` / `polygon_to_polygon_distance`
- [ ] `aabb` / `min_area_bounding_rect`（旋转卡壳法）
- [ ] 测试完善至 320+
- [ ] README 定稿 + mooncakes 发布