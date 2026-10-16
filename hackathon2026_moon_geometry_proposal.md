# moon-geometry 项目申报书

> 2026 MoonBit 十月赛参赛申报 | 方向：工具库 | 截止：2026-10-31

---

## 基本信息

- 项目名称：Moon Geometry：纯 MoonBit 计算几何库
- 参赛者：walkzzz
- 联系方式：phone: 13689047817, email: 745244185@qq.com
- GitHub 仓库链接：https://github.com/walkzzz/moon-geometry.git
- mooncakes 包名：walkzzz/moon-geometry
- 项目方向：MoonBit 计算几何基础库 / 可复用基础组件
- 是否为移植项目：否（原创，参考 CGAL / Shapely / scipy.spatial 设计）

---

## 项目简介

Moon Geometry 是一个纯 MoonBit 实现的计算几何库，**无任何 C FFI 依赖**，为 CAD、游戏碰撞检测、GIS 地理信息、机器人路径规划、图像处理（轮廓分析、形状检测、区域操作）等场景提供可复用的几何算法基础组件。

项目面向需要在 MoonBit 中进行几何计算、空间推理或图形处理的库作者、工具开发者和应用开发者，提供从基础几何类型（点、线段、多边形、三角形、圆）到高级算法（凸包、Delaunay 三角剖分、Voronoi 图、多边形布尔运算、最近点对）的完整能力。

mooncakes 生态调研确认：截至 2026-10-15，GitHub 与 mooncakes.io 上**无任何 MoonBit 计算几何库**，本项目填补该领域空白。

---

## 核心功能范围

### 基础几何类型

- `Point2D` / `Point3D`：二维/三维点，支持距离、加减、数乘、点积、叉积
- `Segment`：线段，支持长度、方向、中点
- `Polygon`：多边形（顶点序列），支持顺时针/逆时针判定
- `Triangle`：三角形，支持面积、外心、内心、重心
- `Circle`：圆，支持面积、周长、包含判定
- `Rectangle`：轴对齐矩形（AABB），支持面积、周长、并/交
- `Line`：直线（一般式 ax + by + c = 0），支持点到直线距离

### 凸包

- `convex_hull_graham(points)` — Graham 扫描法，O(n log n)
- `convex_hull_andrew(points)` — Andrew 单调链法，O(n log n)，数值稳定性更优

### 多边形操作

- `polygon_area(poly)` — Shoelace 公式，支持顺/逆时针
- `polygon_perimeter(poly)` — 周长
- `polygon_centroid(poly)` — 质心（加权面积法）
- `point_in_polygon(point, poly)` — 射线法 + 环绕数法，含边界判定
- `is_convex(poly)` — 凸性判断
- `simplify_polygon(poly, epsilon)` — Douglas-Peucker 简化
- `polygon_orientation(poly)` — 方向判定（CW/CCW/Collinear）

### 线段与相交

- `ccw(a, b, c)` — 三点方向判定（逆时针/顺时针/共线）
- `segments_intersect(s1, s2)` — 线段相交检测
- `segment_intersection(s1, s2)` — 线段交点计算（含参数化求解）
- `line_segment_intersection(line, seg)` — 直线与线段交点

### 最近点对

- `closest_pair(points)` — 分治法，O(n log n)，返回最近点对及距离

### Delaunay 三角剖分

- `delaunay_triangulation(points)` — Bowyer-Watson 增量插入算法
- 支持约束 Delaunay（CDT）基础入口

### Voronoi 图

- `voronoi_diagram(points)` — 从 Delaunay 对偶图构造
- 支持裁剪到指定包围盒

### 多边形布尔运算

- `polygon_union(p1, p2)` — 多边形并集（Greiner-Hormann 算法）
- `polygon_intersection(p1, p2)` — 多边形交集
- `polygon_difference(p1, p2)` — 多边形差集
- `clip_polygon(poly, clip_rect)` — Sutherland-Hodgman 裁剪

### 几何变换

- `translate(shape, dx, dy)` — 平移
- `rotate(shape, angle, center)` — 绕指定中心旋转
- `scale(shape, sx, sy)` — 缩放
- `affine_transform(shape, matrix)` — 仿射变换
- `mirror(shape, axis)` — 镜像反射

### 距离计算

- `point_to_segment_distance(p, seg)` — 点到线段距离
- `point_to_polygon_distance(p, poly)` — 点到多边形边界距离
- `polygon_to_polygon_distance(p1, p2)` — 多边形间最小距离

### 包围盒

- `aabb(points)` — 轴对齐包围盒
- `min_area_bounding_rect(points)` — 最小面积包围矩形（旋转卡壳法）

### 质量与测试

- 不少于 **320 个 MoonBit 测试**，覆盖四目标（native / wasm-gc / js / wasm），预留退化用例 buffer
- 每个算法含正确性测试 + 边界测试 + 退化情况测试（共线、重合、空输入等）
- 与已知结果（CGAL / scipy.spatial）对照的回归测试
- 提供 README 示例，覆盖凸包、Delaunay、多边形布尔运算、最近点对等核心用法

---

## 一个月交付计划

| 周次 | 交付内容 | 验收标准 |
|------|---------|---------|
| Week 1 | 基础类型 + 凸包 + 多边形基础操作 + README 骨架 | `moon check` 通过 + 80+ 测试 |
| Week 2 | 线段相交 + 最近点对 + 多边形布尔运算 | +70 测试，含退化情况 |
| Week 3 | Delaunay 三角剖分 + Voronoi 图 | +80 测试，与 scipy.spatial 对照 |
| Week 4 | 几何变换 + 距离 + 包围盒 + 测试完善 + README 定稿 + mooncakes 发布 | 320+ 测试四目标全绿，预留 2 天发布缓冲 |

---

## 参考与设计说明

- 参考项目 1：[CGAL](https://github.com/CGAL/cgal)（Computational Geometry Algorithms Library）— 算法参考
- 参考项目 2：[Shapely](https://github.com/shapely/shapely)（Python 几何操作库）— API 设计参考
- 参考项目 3：[scipy.spatial](https://docs.scipy.org/doc/scipy/reference/spatial.html) — Delaunay/Voronoi 对照验证
- 参考项目 4：[stb-image](https://github.com/moonbit-community/stb-image)（MoonBit 图像处理库）— MoonBit 工程范式参考
- 本项目许可证：MIT License

### 与参考项目的关系

与 CGAL / Shapely 相比，本项目做以下简化和重新设计：

- 使用 MoonBit 原生类型系统（struct + enum + trait）组织几何类型，而非复刻 C++ 模板或 Python 类继承层级
- 优先实现可在 MoonBit 中独立运行的核心算法，弱化 CGAL 的精确算术内核（CORE / LEDA）依赖，使用 Double 浮点运算
- 采用 MoonBit 四目标（native / wasm-gc / js / wasm）共用代码库，无条件编译
- 以 MoonBit API 为主要交付接口，所有函数纯函数式（无副作用），便于测试和组合
- 与 stb-image 生态协同：图像轮廓分析可调用 `convex_hull` / `polygon_area`，形状检测可调用 `is_convex` / `point_in_polygon`

### 生态协同

- **stb-image**（图像处理）：轮廓凸包、形状判定、区域面积、几何变换
- **linalg**（线性代数）：仿射变换矩阵运算、最小二乘拟合
- **moon-geometry** 可作为上述库的几何计算后端

---

## 验收标准对齐（大赛要求）

| 大赛验收项 | 本项目满足方式 |
|-----------|-------------|
| MoonBit 为主 | 100% MoonBit 实现，零 C FFI |
| 仓库公开 | GitHub 公开仓库，持续提交 |
| 能够运行 | README + 可运行示例 + 320+ 测试 |
| 工作有效 | 全新原创项目，10 月从零开发 |
| 开源合规 | MIT License，参考来源已标注 |
| AI 可解释 | AI 辅助开发，所有算法经人工审查 + 数值验证 |

---

## 技术亮点

1. **纯 MoonBit 零依赖** — 四目标原生支持，无 C FFI，部署极简
2. **填补生态空白** — mooncakes 首个计算几何库
3. **算法深度** — Delaunay 三角剖分、Voronoi 图、旋转卡壳均为经典复杂算法
4. **可测试性极高** — 几何结果可精确验证（坐标、面积、顶点序列）
5. **退化情况全覆盖** — 共线点、重合点、空输入、单点/两点退化均有处理
6. **生态协同** — 与 stb-image 图像处理库形成几何计算 + 图像处理组合能力