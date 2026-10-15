# API Reference | API 参考手册

Moon Geometry API reference for all sub-packages.
Moon Geometry 所有子包的 API 参考手册。

## core — Base Types | 基础类型

### Point2D

| Method | Description | 描述 |
|--------|-------------|------|
| `Point2D::new(x, y)` | Construct a 2D point | 构造二维点 |
| `Point2D::x()` | X coordinate accessor | X 坐标访问器 |
| `Point2D::y()` | Y coordinate accessor | Y 坐标访问器 |
| `Point2D::dist(other)` | Euclidean distance | 欧几里得距离 |
| `Point2D::dist_sq(other)` | Squared distance | 距离平方 |
| `Point2D::add(other)` | Vector addition | 向量加法 |
| `Point2D::sub(other)` | Vector subtraction | 向量减法 |
| `Point2D::mul(s)` | Scalar multiplication | 标量乘法 |
| `Point2D::dot(other)` | Dot product | 点积 |
| `Point2D::cross(other)` | 2D cross product scalar | 二维叉积标量 |
| `Point2D::equals(other)` | Exact equality | 精确相等 |
| `Point2D::approx_eq(other, eps)` | Approximate equality | 近似相等 |

### Point3D

| Method | Description | 描述 |
|--------|-------------|------|
| `Point3D::new(x, y, z)` | Construct a 3D point | 构造三维点 |
| `Point3D::dist(other)` | Euclidean distance | 欧几里得距离 |
| `Point3D::add/sub/mul` | Vector ops | 向量运算 |
| `Point3D::dot(other)` | Dot product | 点积 |
| `Point3D::cross(other)` | 3D cross product vector | 三维叉积向量 |

### Segment / Line

| Method | Description | 描述 |
|--------|-------------|------|
| `Segment::new(start, end)` | Construct segment | 构造线段 |
| `Segment::length()` | Segment length | 线段长度 |
| `Segment::direction()` | Direction vector | 方向向量 |
| `Segment::midpoint()` | Midpoint | 中点 |
| `Line::new(a, b, c)` | Line from ax+by+c=0 | 从一般式构造直线 |
| `Line::from_points(p1, p2)` | Line from two points | 从两点构造直线 |
| `Line::point_distance(p)` | Point-to-line distance | 点到直线距离 |

### Polygon / Triangle / Circle / Rectangle

| Method | Description | 描述 |
|--------|-------------|------|
| `Polygon::new(vertices)` | Construct polygon | 构造多边形 |
| `Polygon::size()` | Vertex count | 顶点数量 |
| `Polygon::get(i)` | Vertex at index (wrapping) | 按索引取顶点 |
| `Triangle::new(a, b, c)` | Construct triangle | 构造三角形 |
| `Triangle::area()` | Unsigned area | 无符号面积 |
| `Triangle::centroid()` | Centroid | 重心 |
| `Triangle::circumcenter()` | Circumcenter | 外心 |
| `Triangle::incenter()` | Incenter | 内心 |
| `Circle::new(center, radius)` | Construct circle | 构造圆 |
| `Circle::area()` / `Circle::perimeter()` | Area / circumference | 面积 / 周长 |
| `Circle::contains(p)` | Contains point | 包含点 |
| `Rectangle::new(x, y, w, h)` | Construct rectangle | 构造矩形 |
| `Rectangle::from_corners(p1, p2)` | From two corners | 从对角点构造 |
| `Rectangle::area/perimeter/width/height` | Properties | 属性 |
| `Rectangle::contains(p)` | Contains point | 包含点 |
| `Rectangle::union(other)` | Union (bounding box) | 并集 |
| `Rectangle::intersection(other)` | Intersection | 交集 |

### Utility Functions | 工具函数

| Function | Description | 描述 |
|----------|-------------|------|
| `turn(o, a, b)` | Cross product (a-o)×(b-o) | 叉积 (a-o)×(b-o) |
| `approx_eq(a, b, eps)` | Tolerance comparison | 容差比较 |
| `default_eps` | Default epsilon (1e-9) | 默认精度 (1e-9) |

---

## hull — Convex Hull | 凸包

| Function | Description | 描述 |
|----------|-------------|------|
| `convex_hull_andrew(points)` | Andrew's monotone chain O(n log n) | Andrew 单调链法 |
| `convex_hull_graham(points)` | Graham scan O(n log n) | Graham 扫描法 |
| `ccw(a, b, c)` | Three-point orientation | 三点方向判定 |

---

## polygon — Polygon Operations | 多边形操作

| Function | Description | 描述 |
|----------|-------------|------|
| `polygon_area(poly)` | Unsigned area (Shoelace) | 无符号面积 |
| `polygon_signed_area(poly)` | Signed area | 有符号面积 |
| `polygon_perimeter(poly)` | Perimeter | 周长 |
| `polygon_centroid(poly)` | Centroid (area-weighted) | 重心 |
| `polygon_orientation(poly)` | Orientation | 方向 |
| `is_convex(poly)` | Convexity test | 凸性判断 |
| `point_in_polygon(p, poly)` | Point-in-polygon (ray casting) | 点在多边形内 |
| `simplify_polygon(poly, eps)` | Douglas-Peucker simplification | Douglas-Peucker 简化 |

---

## intersect — Intersection | 相交

| Function | Description | 描述 |
|----------|-------------|------|
| `segments_intersect(s1, s2)` | Segment intersection test | 线段相交检测 |
| `segment_intersection(s1, s2)` | Intersection point | 交点计算 |
| `line_segment_intersection(line, seg)` | Line-segment intersection | 直线与线段交点 |

---

## nearest — Closest Pair | 最近点对

| Function | Description | 描述 |
|----------|-------------|------|
| `closest_pair(points)` | Divide & conquer O(n log n) | 分治法 O(n log n) |

---

## boolean — Boolean Operations | 布尔运算

| Function | Description | 描述 |
|----------|-------------|------|
| `clip_polygon(poly, rect)` | Sutherland-Hodgman clipping | 多边形裁剪 |
| `polygon_intersection(subject, clip)` | Convex polygon intersection | 凸多边形交集 |
| `polygon_union_area(p1, p2)` | Union area | 并集面积 |
| `polygon_difference_area(p1, p2)` | Difference area | 差集面积 |

---

## triangulation — Delaunay / Voronoi | 三角剖分

| Function | Description | 描述 |
|----------|-------------|------|
| `delaunay_triangulation(points)` | Bowyer-Watson, O(n²) expected | Bowyer-Watson 增量插入 |
| `voronoi_diagram(points)` | Delaunay duality | Delaunay 对偶 |

---

## transform — Geometric Transforms | 几何变换

| Function | Description | 描述 |
|----------|-------------|------|
| `translate(p, dx, dy)` | Translate point | 平移点 |
| `translate_points(pts, dx, dy)` | Translate point array | 平移点数组 |
| `rotate(p, angle)` | Rotate around origin | 绕原点旋转 |
| `rotate_around(p, center, angle)` | Rotate around center | 绕中心旋转 |
| `rotate_points(pts, center, angle)` | Rotate point array | 旋转点数组 |
| `scale(p, sx, sy)` | Scale relative to origin | 相对原点缩放 |
| `scale_around(p, center, sx, sy)` | Scale relative to center | 相对中心缩放 |
| `affine_transform(p, a, b, c, d, e, f)` | Affine transform | 仿射变换 |
| `mirror_x(p)` / `mirror_y(p)` | Mirror across axis | 轴镜像 |
| `mirror_origin(p)` | Mirror through origin | 原点镜像 |
| `mirror_line(p, line)` | Mirror across line | 直线镜像 |
| `shear(p, kx, ky)` | Shear transform | 剪切变换 |

---

## distance — Distance | 距离

| Function | Description | 描述 |
|----------|-------------|------|
| `point_to_segment_distance(p, seg)` | Point to segment | 点到线段 |
| `point_to_polygon_distance(p, poly)` | Point to polygon | 点到多边形 |
| `segment_to_segment_distance(s1, s2)` | Segment to segment (with intersection check) | 线段间（含相交检测） |
| `polygon_to_polygon_distance(p1, p2)` | Polygon to polygon | 多边形间 |
| `point_to_line_distance(p, line)` | Point to infinite line | 点到直线 |

---

## bounding — Bounding Volumes | 包围体

| Function | Description | 描述 |
|----------|-------------|------|
| `aabb(points)` | Axis-aligned bounding box of points | 点集轴对齐包围盒 |
| `aabb_polygon(poly)` | Axis-aligned bounding box of polygon | 多边形轴对齐包围盒 |
| `min_area_bounding_rect(points)` | Min-area bounding rect (rotating calipers), returns (cx, cy, w, h, angle) | 最小面积包围矩形 |
| `bounding_circle(points)` | Bounding circle (centroid + max distance), returns (center, radius) | 包围圆 |

---

## Re-export | 重导出

Root package `walkzzz/moon-geometry` re-exports all types and functions.
根包 `walkzzz/moon-geometry` 重导出全部类型和函数。

```moonbit
import "walkzzz/moon-geometry"
// Access all APIs via @moon-geometry
// 通过 @moon-geometry 访问全部 API
```