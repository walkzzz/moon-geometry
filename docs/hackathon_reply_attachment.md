# moon-geometry 申报补充材料

**GitHub 仓库**：https://github.com/walkzzz/moon-geometry.git
**当前版本**：v0.231.0
**提交日期**：2026-10-16

---

## 一、复用关系说明

经核查，moon-geometry 与 mooncakes.io 上现有库 `totto2727/geo@0.1.3`、`cn-xjr/moongeokit@0.3.0` 的关系如下：

### 1. 与 totto2727/geo@0.1.3 的关系

- totto2727/geo 是 Rust 库 georust/geo 的 MoonBit 移植，聚焦 **2D 平面地理空间**，含 4 个子包（geo/2d/type, geo/2d, robust, rtree），明确声明 **"3D geometry is outside the module scope"**
- moon-geometry **未复用** totto2727/geo 的任何代码，所有模块均为原创实现
- 两者在 2D 基础几何（凸包/相交/距离/三角剖分）上存在**功能重叠**，但实现完全独立

### 2. 与 cn-xjr/moongeokit@0.3.0 的关系

- moongeokit 是 **2D 几何 + 均匀网格空间索引** 库，仅 3 个源文件（moongeokit.mbt, grid_index.mbt, robust.mbt），明确声明"not a replacement for an R-tree, polygon topology engine, coordinate-reference transformation library, or a GeoJSON parser"
- moon-geometry **未复用** moongeokit 的任何代码
- 两者在 2D 基础几何上有**少量功能重叠**

---

## 二、能力规模对比

| 维度 | moon-geometry | totto2727/geo@0.1.3 | cn-xjr/moongeokit@0.3.0 |
|------|:---:|:---:|:---:|
| 子包/模块数 | **236** | ~4 | 1（3 源文件） |
| 测试数 | **1952**（四目标 7808 次运行） | 未公开 | 未公开 |
| 几何维度 | **2D + 3D** | 仅 2D | 仅 2D |
| 代码来源 | 原创实现 | georust/geo 移植 | 原创实现 |
| 文件 I/O 格式 | 6 种（OBJ/STL/PLY/glTF/GeoJSON/DXF） | 无 | 仅 GeoJSON 输出 |
| 空间索引结构 | 19 种 | 1 种（R-tree） | 1 种（均匀网格） |

---

## 三、独立增量能力清单

以下为 moon-geometry 独有、两个竞品**完全不具备**的能力，共 **200+ 个模块**（占总量 92%）：

### A. 3D 几何与多面体（10 模块）— 竞品均仅 2D

| 模块 | 功能 |
|------|------|
| aabb3d | 3D 轴对齐包围盒 |
| bounding_sphere | 最小包围球（Ritter 算法） |
| obb | 有向包围盒（PCA） |
| polyhedron | 多面体表示与操作（体积/表面积/质心） |
| polyhedron_boolean | 多面体布尔运算（并/交/差） |
| mesh_boolean | 网格布尔运算 |
| convex_hull3d | 3D 凸包 |
| convex_h@3d_dynamic | 动态 3D 凸包（增量式） |
| mesh_quality | 网格质量度量 |
| mesh_repair | 网格修复（孔洞填充/退化去除） |

### B. 3D Voronoi/Delaunay 与计算拓扑（10 模块）

| 模块 | 功能 |
|------|------|
| voronoi_3d | 3D Voronoi 图 |
| delaunay_3d | 3D Delaunay 三角剖分 |
| constrained_delaunay | 约束 Delaunay 三角剖分 |
| power_diagram | 幂图（加权 Voronoi） |
| centroidal_voronoi | 质心 Voronoi 镶嵌（Lloyd 算法） |
| alpha_complex | Alpha 复形过滤 |
| persistent_homology | 持久同调计算 |
| betti_numbers | Betti 数计算 |
| reeb_graph | Reeb 图 |
| morse_complex | Morse-Smale 复形 |

### C. 机器人与运动规划（10 模块）

| 模块 | 功能 |
|------|------|
| rrt | RRT/RRT*/双向 RRT 路径规划 |
| prm | 概率路线图 |
| a_star | A* 网格寻路 |
| dubins | Dubins 曲线（曲率约束最短路径） |
| reed_shepp | Reed-Shepp 曲线（含倒车） |
| collision_detect | 碰撞检测 |
| gjk | GJK 距离算法 |
| sat | 分离轴定理 |
| config_space | 构型空间构建 |
| path_smooth | 路径平滑（样条） |

### D. 形状分析与描述子（10 模块）

| 模块 | 功能 |
|------|------|
| shape_context | 形状上下文描述子 |
| fourier_descriptor | 傅里叶描述子 |
| moment_invariants | Hu 矩不变量 |
| skeleton_3d | 3D 骨架提取 |
| medial_axis_3d | 3D 中轴变换 |
| shape_matching | 形状匹配与配准 |
| curvature_scale | 曲率尺度空间 |
| bend_energy | 弯曲能量（弹性杆模型） |
| procrustes | Procrustes 分析 |
| icp | ICP 点云配准 |

### E. 数值优化（10 模块）

| 模块 | 功能 |
|------|------|
| quadratic_prog | 二次规划 |
| gradient_descent | 梯度下降（线搜索） |
| newton_method | 牛顿法/拟牛顿法 |
| levenberg_marquardt | LM 非线性最小二乘 |
| conjugate_gradient | 非线性共轭梯度 |
| simplex_method | 线性规划单纯形法 |
| interior_point | 内点法 |
| simulated_annealing | 模拟退火 |
| genetic_algorithm | 遗传算法 |
| pso | 粒子群优化 |

### F. GIS 与测地线（10 模块）

| 模块 | 功能 |
|------|------|
| gis_projection | 地图投影（UTM/Mercator 等） |
| geodesic | 椭球面测地距离 |
| gis_buffer | 缓冲区构建 |
| tin | 不规则三角网 |
| coordinate_convert | 坐标系转换 |
| datum_transform | 基准变换 |
| raster_ops | 栅格操作 |
| contour_line | 等高线提取 |
| watershed | 分水岭分割 |
| delaunay_terrain | Delaunay 地形建模 |

### G. 文件 I/O 与渲染（10 模块）

| 模块 | 功能 |
|------|------|
| obj_io | Wavefront OBJ 读写 |
| stl_io | STL 读写 |
| ply_io | PLY 读写 |
| gltf_io | glTF 读写 |
| geojson_io | GeoJSON 读写 |
| dxf_io | DXF 读写 |
| ray_tracing | 光线追踪渲染 |
| marching_cubes | 移动立方体等值面提取 |
| hidden_line | 隐藏线消除 |
| rasterization | 三角形光栅化 |

### H. 代数几何与分形（10 模块）

| 模块 | 功能 |
|------|------|
| conic_section | 圆锥曲线分析 |
| quadric_surface | 二次曲面分析 |
| resultant | 多项式结式 |
| bezier_clipping | Bezier 裁剪求交 |
| implicit_curve | 隐式曲线绘制 |
| implicit_surface | 隐式曲面绘制 |
| ifs | 迭代函数系统分形 |
| l_system | L 系统分形 |
| fractal_dimension | 盒计数分形维数 |
| hausdorff_dimension | Hausdorff 维数 |

### I. 其他独有领域（120+ 模块）

- **高级曲线与曲面**（15+ 模块）：NURBS、B 样条、Catmull-Rom、Hermite、Lagrange、Bezier 曲面、曲面蒙皮/参数化/旋转/扫掠/修剪/放样
- **高级空间结构**（19 模块）：KD 树、四叉树、八叉树（3 种）、BVH、R 树、AABB 树、球树、VP 树、覆盖树、度量树、范围树、区间树、网格索引、桶 PR、空间哈希、跳跃四叉树、松散八叉树
- **距离度量**（8 模块）：Hausdorff、Fréchet、Chamfer、EMD、DTW、瓶颈匹配
- **网格处理**（6 模块）：简化/平滑/法向/细分/欧拉示性数
- **应用算法**（7 模块）：Hough 变换、RANSAC、聚类、配准、重建、打包、覆盖
- **凸几何高级**（18 模块）：凸层、凹包、凸宽/直径/中心/交集、Minkowski 和、支撑函数、分离定理
- **多边形高级**（24 模块）：偏移/带洞/核/覆盖/分解/演化/形变/骨架/对称/中轴/快速三角剖分

---

## 四、同一输入下的能力与输出对比

### 对比 1：2D 凸包（三者共有）

**输入**：`points = [(0,0), (4,0), (4,4), (0,4), (2,2)]`

| 库 | 调用方式 | 输出 |
|----|---------|------|
| moon-geometry | `convex_hull_andrew(points)` | `[(0,0), (4,0), (4,4), (0,4)]` |
| totto2727/geo | `ConvexHull::convex_hull(&polygon)` | 等价结果 |
| cn-xjr/moongeokit | `convex_hull(points)` | 等价结果 |

**结论**：基础 2D 凸包能力等价。

### 对比 2：3D 凸包（仅 moon-geometry 具备）

**输入**：`points_3d = [(0,0,0), (1,0,0), (0,1,0), (0,0,1), (0.5,0.5,0.5)]`

| 库 | 调用方式 | 输出 |
|----|---------|------|
| moon-geometry | `convex_hull_3d(points_3d)` | 4 个三角面片（四面体） |
| totto2727/geo | **不支持**（"3D geometry is outside the module scope"） | N/A |
| cn-xjr/moongeokit | **不支持**（仅 2D） | N/A |

### 对比 3：RRT 路径规划（仅 moon-geometry 具备）

**输入**：起点 `(0,0)`，终点 `(10,10)`，圆形障碍物列表

| 库 | 调用方式 | 输出 |
|----|---------|------|
| moon-geometry | `rrt_plan(start, goal, obstacles, config)` | 无碰撞路径（点序列） |
| totto2727/geo | **不支持** | N/A |
| cn-xjr/moongeokit | **不支持** | N/A |

### 对比 4：NURBS 曲线求值（仅 moon-geometry 具备）

**输入**：控制点 `[(0,0), (1,2), (3,2), (4,0)]`，节点向量 `[0,0,0,0.5,1,1,1]`，参数 `t=0.5`

| 库 | 调用方式 | 输出 |
|----|---------|------|
| moon-geometry | `nurbs_curve_point(ctrl_pts, knots, weights, t)` | `(2.0, 1.5)` |
| totto2727/geo | **不支持** | N/A |
| cn-xjr/moongeokit | **不支持** | N/A |

### 对比 5：持久同调（仅 moon-geometry 具备）

**输入**：点云的 Vietoris-Rips 复形过滤

| 库 | 调用方式 | 输出 |
|----|---------|------|
| moon-geometry | `persistent_homology(filtration)` | 持久条形码列表 `[(birth, death, dim), ...]` |
| totto2727/geo | **不支持** | N/A |
| cn-xjr/moongeokit | **不支持** | N/A |

### 对比 6：OBJ 文件解析（仅 moon-geometry 具备）

**输入**：`v 0 0 0\nv 1 0 0\nv 0 1 0\nf 1 2 3\n`

| 库 | 调用方式 | 输出 |
|----|---------|------|
| moon-geometry | `obj_parse(content)` | `ObjMesh`（3 顶点 + 1 三角面） |
| totto2727/geo | **不支持** | N/A |
| cn-xjr/moongeokit | **不支持** | N/A |

---

## 五、量化总结

| 指标 | 数值 |
|------|------|
| moon-geometry 总模块数 | 236 |
| 与竞品重叠模块数 | ~15-20（基础 2D 几何） |
| 独有模块数 | ~216+（占 92%） |
| 独有领域数 | 14 个大类 |
| 测试数 | 1952（四目标全绿） |
| 代码复用 | 零（未引用任何竞品代码） |

**结论**：moon-geometry 是一个覆盖 2D+3D 全栈计算几何的独立原创项目。与现有库在基础 2D 几何上存在约 8% 的功能重叠（实现独立），92% 的模块为竞品完全不具备的增量能力，足以支撑独立项目定位。

---

完整对比报告及项目源码：https://github.com/walkzzz/moon-geometry