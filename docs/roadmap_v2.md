# Roadmap v2 | 远期迭代路线图

Moon Geometry 远期迭代计划（2026-11 ~ 2027-06）。
当前基线：**156 模块 / 1153 测试 / v0.156.1 已发布**。
目标：**236 模块 / 2000+ 测试 / v0.240.0**。

## 已有模块分类总览 | Existing Module Coverage

| 分类 | 模块数 | 覆盖范围 |
|------|--------|---------|
| 核心基础 | 26 | Point2D/3D, Vector, Matrix, Transform, Affine, Perspective, 投影, 刚体, 相似, 同形, 极对偶, 立体投影, 反演, 平面, 射线, 圆/椭圆, 角度, 距离, 常数, 随机, 采样 |
| 凸几何 | 18 | 凸包(2D/3D/近似/动态), 凸多边形, 凸裁剪, 凸分解, 凸直径, 凸交集, 凸层, 凸和, 凸宽, Minkowski和, 支撑函数, 分离定理, 半平面, 线性规划 |
| 多边形 | 24 | 多边形/折线, 单调, 耳切, 三角剖分(3种), 带洞, 核, 覆盖, 最优分解, 演化, 形变, 偏移, 圆角, 简化, 骨架, 对称, 中轴, 布尔, 叠加, 梯形分解, 美术馆, 凹包 |
| 空间索引 | 19 | KD树, 四叉树, 八叉树(3种), BVH, R树, AABB树, 球树, VP树, 覆盖树, 度量树, 范围树, 区间树, 网格索引, 桶PR, 空间哈希, 扫描线, 排列, DCEL, 平面图 |
| Voronoi/Delaunay | 3 | Delaunay精化, 高级Voronoi, Zone |
| 曲线 | 15 | Bezier(曲线/曲面), B-spline, Catmull-Rom, Hermite, Lagrange, NURBS, 样条, 插值, 弧线, 曲线求交, 弧长, 曲率, 形变, 拟合 |
| 曲面/网格 | 13 | 蒙皮, 网格, 参数, 旋转, 扫掠, 修剪, 网格数据/法向/简化/平滑/细分, 面提取, 欧拉示性数 |
| 图算法 | 7 | 欧拉回路, 图着色, 图割, 最短路, 生成树, 运动规划, 可见图 |
| 数值计算 | 9 | 特征值, 多项式, 求根, 积分, 微分, 优化, 拟合, 矩阵(2D/3D) |
| 距离/相似度 | 9 | Hausdorff, Chamfer, Fréchet, DTW, Bottleneck, EMD, 匹配, 最近邻, 点匹配 |
| 应用算法 | 7 | Hough变换, RANSAC, 聚类, 配准, 重建, 打包, 覆盖 |
| 可见性 | 2 | 可见性, 可见图 |
| I/O | 2 | JSON, SVG |
| **合计** | **156** | |

---

## 扩展计划总览 | Extension Plan Overview

| 阶段 | 版本 | 主题 | 新增模块 | 累计模块 | 测试目标 |
|------|------|------|---------|---------|---------|
| Phase 1 | v0.160 | 3D 几何与多面体 | 10 | 166 | 1280+ |
| Phase 2 | v0.170 | 高级 Voronoi/Delaunay 与拓扑 | 10 | 176 | 1400+ |
| Phase 3 | v0.180 | 机器人与运动规划 | 10 | 186 | 1520+ |
| Phase 4 | v0.190 | 形状分析与描述子 | 10 | 196 | 1640+ |
| Phase 5 | v0.200 | 数值优化扩展 | 10 | 206 | 1760+ |
| Phase 6 | v0.210 | GIS 与测地线 | 10 | 216 | 1880+ |
| Phase 7 | v0.220 | 文件 I/O 与渲染 | 10 | 226 | 2000+ |
| Phase 8 | v0.230 | 代数几何与分形 | 10 | 236 | 2120+ |

---

## Phase 1: 3D 几何与多面体 (v0.160) | 3D Geometry & Polyhedra

当前 3D 能力仅限凸包和基础网格，缺乏多面体布尔运算、包围体优化、网格修复等核心 3D 功能。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `polyhedron` | 多面体基本操作 | 体积（散度定理）、表面积、质心、切片 |
| `polyhedron_boolean` | 多面体布尔运算 | 并/交/差，基于 BSP 分割 |
| `mesh_boolean` | 网格布尔运算 | 并/交/差，基于精确谓词 |
| `mesh_repair` | 网格修复 | 孔洞填充、非流形边修复、退化面移除 |
| `mesh_param` | 网格参数化 | LSCM（最小二乘共形映射）、ARAP、调和映射 |
| `mesh_quality` | 网格质量度量 | 纵横比、面积比、二面角、雅可比 |
| `obb` | 最小定向包围盒（3D） | 基于 PCA + 凸包投影 |
| `bounding_sphere` | 最小包围球 | Welzl 算法 O(n) 期望 |
| `convex_hull_3d_dynamic` | 动态 3D 凸包 | 增量插入/删除，支持冲突图 |
| `aabb3d` | 3D AABB 操作 | 构建、合并、射线-AABB 相交、AABB-AABB 相交 |

**依赖**：`core`, `mesh_data`, `convex_hull3d`, `matrix3d`, `eigen`

---

## Phase 2: 高级 Voronoi/Delaunay 与拓扑 (v0.170) | Advanced Voronoi/Delaunay & Topology

当前仅 2D Delaunay/Voronoi，缺乏 3D 剖分、约束剖分、拓扑数据分析。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `voronoi_3d` | 3D Voronoi 图 | 从 3D Delaunay 对偶构造 |
| `delaunay_3d` | 3D Delaunay 三角剖分 | 增量插入 Bowyer-Watson 3D |
| `constrained_delaunay` | 约束 Delaunay 三角剖分 | CDT，保留约束边 |
| `power_diagram` | 幂图（加权 Voronoi） | Regular triangulation，加权点 |
| `centroidal_voronoi` | 质心 Voronoi Tessellation | Lloyd 迭代，CVT 能量最小化 |
| `alpha_complex` | Alpha 复形 | 从 Delaunay 按 alpha 半径过滤 |
| `persistent_homology` | 持续同调 | 基于 filtration 的 Betti 数条形码 |
| `betti_numbers` | Betti 数 | 连通分量数、洞数、空腔数 |
| `reeb_graph` | Reeb 图 | 标量场拓扑结构提取 |
| `morse_complex` | Morse 复形 | Morse 理论，稳定/不稳定流形 |

**依赖**：`triangulation`, `voronoi_adv`, `delaunay_refine`, `euler_char`

---

## Phase 3: 机器人与运动规划 (v0.180) | Robotics & Motion Planning

当前仅有基础 `motion_plan`，缺乏现代采样规划器和碰撞检测。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `rrt` | 快速探索随机树 | RRT / RRT* / Bidirectional RRT |
| `prm` | 概率路线图 | PRM 构建 + 最短路查询 |
| `a_star` | A* 路径规划 | 网格/图上启发式搜索 |
| `dubins` | Dubins 曲线 | 最短路径（前进only），半径约束 |
| `reed_shepp` | Reeds-Shepp 曲线 | 最短路径（前进+后退），半径约束 |
| `collision_detect` | 碰撞检测 | 宽相（AABB/BVH）+ 窄相（GJK/SAT） |
| `gjk` | GJK 碰撞检测 | Gilbert-Johnson-Keerthi 支撑映射 |
| `sat` | SAT 分离轴定理 | 凸体碰撞检测 |
| `config_space` | 构型空间 | 障碍物 C-space 展开 |
| `path_smooth` | 路径平滑 | B-spline 平滑、关键点保留 |

**依赖**：`motion_plan`, `bvh`, `aabb_tree`, `support`, `separating`, `spline`

---

## Phase 4: 形状分析与描述子 (v0.190) | Shape Analysis & Descriptors

当前缺乏形状描述子、3D 骨架、高级配准。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `shape_context` | 形状上下文描述子 | 对数极坐标直方图，形状匹配 |
| `fourier_descriptor` | 傅里叶描述子 | FFT 系数，旋转/平移/尺度不变 |
| `moment_invariants` | 矩不变量 | Hu 矩（7个）、Zernike 矩 |
| `skeleton_3d` | 3D 骨架 | 沿面收缩（thinning）、电场法 |
| `medial_axis_3d` | 3D 中轴 | Voronoi 对偶法，3D 中轴面 |
| `shape_matching` | 形状匹配 | ICP + 形状上下文 + 匈牙利匹配 |
| `curvature_scale` | 曲率尺度空间 | CSS，拐点检测，尺度空间图 |
| `bend_energy` | 弯曲能量 | ∫κ² ds，弹性杆模型 |
| `procrustes` | Procrustes 分析 | 最小二乘刚体对齐（普通/广义） |
| `icp` | ICP 点云配准 | Point-to-point / Point-to-plane ICP |

**依赖**：`registration`, `matching`, `hausdorff`, `eigen`, `polygon_skeleton`, `polygon_medial`

---

## Phase 5: 数值优化扩展 (v0.200) | Numerical Optimization Extensions

当前 `optim` 仅有基础优化，缺乏约束优化和元启发式算法。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `quadratic_prog` | 二次规划 | 主动集法 / 内点法 |
| `gradient_descent` | 梯度下降 | SGD / Momentum / Adam |
| `newton_method` | 牛顿法 | 1D/多维，线搜索，信赖域 |
| `levenberg_marquardt` | Levenberg-Marquardt | 非线性最小二乘，阻尼因子自适应 |
| `conjugate_gradient` | 共轭梯度法 | CG / preconditioned CG / nonlinear CG |
| `simplex_method` | 单纯形法 | 线性规划两阶段单纯形 |
| `interior_point` | 内点法 | 原始-对偶路径跟踪 |
| `simulated_annealing` | 模拟退火 | Metropolis 准则，冷却调度 |
| `genetic_algorithm` | 遗传算法 | 选择/交叉/变异，精英保留 |
| `pso` | 粒子群优化 | 全局/局部拓扑，惯性权重 |

**依赖**：`optim`, `linalg`, `eigen`, `root_find`, `linear_prog`

---

## Phase 6: GIS 与测地线 (v0.210) | GIS & Geodesics

当前无任何 GIS 功能，缺乏地图投影、测地线、地形分析。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `gis_projection` | 地图投影 | Mercator / UTM / Lambert / Albers |
| `geodesic` | 测地线距离 | 球面/椭球面测地线（Vincenty / Karney） |
| `gis_buffer` | 缓冲区操作 | 点/线/面缓冲区，Minkowski 和 |
| `tin` | 不规则三角网 | 从 Delaunay 构建 TIN，高程插值 |
| `coordinate_convert` | 坐标系转换 | WGS84 ↔ CGCS2000 ↔ 地心直角 |
| `datum_transform` | 基准面变换 | 7参数 Bursa-Wolf / 3参数 |
| `raster_ops` | 栅格操作 | 重采样、镶嵌、代数运算 |
| `contour_line` | 等值线提取 | Marching Squares，标注值 |
| `watershed` | 分水岭算法 | 集水盆地分割，标记驱动 |
| `delaunay_terrain` | 地形 Delaunay | 带 Z 值的约束 Delaunay，坡度/坡向 |

**依赖**：`triangulation`, `delaunay_refine`, `minkowski`, `polygon_offset`, `sampling`

---

## Phase 7: 文件 I/O 与渲染 (v0.220) | File I/O & Rendering

当前仅 JSON/SVG 输出，缺乏标准 3D 网格格式和渲染算法。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `obj_io` | OBJ 文件格式 | Wavefront OBJ 读写（v/vt/vn/f） |
| `stl_io` | STL 文件格式 | ASCII/Binary STL 读写 |
| `ply_io` | PLY 文件格式 | Stanford PLY 读写（ASCII/Binary） |
| `gltf_io` | glTF 文件格式 | glTF 2.0 JSON+Binary 读写 |
| `geojson_io` | GeoJSON 格式 | RFC 7946 读写（Point/LineString/Polygon/Multi*） |
| `dxf_io` | DXF 文件格式 | AutoCAD DXF 读写（基本实体） |
| `ray_tracing` | 光线追踪 | 射线-三角形/球/平面求交，阴影 |
| `marching_cubes` | Marching Cubes | 等值面提取，33 种构型查表 |
| `hidden_line` | 隐藏线消除 | Roberts 算法 / z-buffer 线框 |
| `rasterization` | 光栅化 | 线段/三角形光栅化，深度缓冲 |

**依赖**：`mesh_data`, `json_out`, `svg_out`, `ray`, `plane`, `triangulate`

---

## Phase 8: 代数几何与分形 (v0.230) | Algebraic Geometry & Fractals

当前无代数曲线曲面和分形几何。

| 模块 | 功能 | 算法/备注 |
|------|------|----------|
| `conic_section` | 圆锥曲线 | 椭圆/双曲线/抛物线，标准型判定 |
| `quadric_surface` | 二次曲面 | 椭球面/单叶双曲面/抛物面，分类 |
| `resultant` | 结式计算 | Sylvester 矩阵行列式，多项式消元 |
| `bezier_clipping` | Bezier 裁剪求交 | Bezier 曲线精确求交，递归裁剪 |
| `implicit_curve` | 隐式曲线 | f(x,y)=0 表示，追踪法绘制 |
| `implicit_surface` | 隐式曲面 | f(x,y,z)=0 表示，法向/曲率 |
| `ifs` | 迭代函数系统 | 压缩映射，吸引子生成（混沌游戏） |
| `l_system` | L 系统 | 海龟绘图，分形植物/雪花 |
| `fractal_dimension` | 分形维数 | 盒计数法 / 相关维数 |
| `hausdorff_dimension` | Hausdorff 维数 | 自相似维数公式 D = log(N)/log(1/r) |

**依赖**：`polynomial`, `bezier`, `curve_intersect`, `resultant`, `matrix`

---

## 优先级排序 | Priority Ranking

### 高优先级（Phase 1-3，2026 Q4）
- **Phase 1**：3D 几何是多面体操作的基础，下游所有 3D 功能依赖
- **Phase 2**：拓扑分析是高级几何处理的核心
- **Phase 3**：运动规划是机器人应用的刚需

### 中优先级（Phase 4-6，2027 Q1）
- **Phase 4**：形状分析在计算机视觉中广泛使用
- **Phase 5**：优化扩展支撑所有参数拟合场景
- **Phase 6**：GIS 领域有独立用户群

### 低优先级（Phase 7-8，2027 Q2）
- **Phase 7**：I/O 格式可按需添加
- **Phase 8**：代数几何与分形偏理论，使用场景较少

---

## 技术约束 | Technical Constraints

1. **纯 MoonBit 实现**：不依赖 C FFI，所有算法用 MoonBit 原生编写
2. **四目标全绿**：native / wasm-gc / js / wasm 均需通过
3. **0 warning**：所有新模块需通过 `moon check` 零警告
4. **测试覆盖**：每个新模块至少 8 个测试，覆盖正常/边界/退化情况
5. **中英双文注释**：所有 `///` 注释使用中英双文
6. **子包 README**：每个新模块需有 README.md
7. **重导出**：所有新模块 API 需在 `reexport.mbt` 中重导出
8. **版本递增**：每个 Phase 完成后递增大版本号并发布到 mooncakes.io