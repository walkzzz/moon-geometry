# Changelog | 变更日志

All notable changes to Moon Geometry are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/).

Moon Geometry 的所有重要变更记录于此。
格式基于 [Keep a Changelog](https://keepachangelog.com/)。

## [0.239.0] - 2026-10-20

### Fixed — Warning Governance | 警告治理（204 → 81）

- 5 处 `derive(Show)` → `derive(Debug)`，添加 `pub extend Type with Debug::{to_repr}` 声明
- 5 处 `reserved_keyword`：`method` → `mode`（`bertrand_probability` 参数重命名）
- 5 处 `unused_package`：删除根 moon.pkg 中未使用的 testing 模块导入
- 1 处 `ambiguous_block`：`{ seed }` → `{ seed, }`
- 剩余 81 个 warning（54 `unused_package` + 26 `unused_value` + 1 `struct_never_constructed`）

## [0.238.0] - 2026-10-20

### Changed — Directory Restructuring | 目录分组重构

将 `src/` 下 401 个平铺模块重组为 24 个分类子目录：

| 分类 | 模块数 | 说明 |
|------|--------|------|
| base | 30 | 核心类型、工具、算术 |
| topology | 27 | 拓扑数据分析 |
| polygon | 26 | 多边形算法 |
| optim | 25 | 优化 |
| mesh | 25 | 网格算法 |
| curves | 24 | 曲线算法 |
| spatial | 22 | 空间索引 |
| robotics | 20 | 机器人与运动规划 |
| pde | 20 | PDE 求解器 |
| ml | 19 | 机器学习 |
| graphics | 18 | 计算机图形学 |
| computational | 18 | 计算几何 |
| hull | 18 | 凸包算法 |
| transform | 14 | 几何变换 |
| differential | 14 | 微分几何 |
| misc | 14 | 其他 |
| algebraic | 12 | 代数几何 |
| arrangement | 12 | 排列与细分 |
| stats | 11 | 几何统计 |
| distance | 11 | 距离算法 |
| io | 7 | 输入输出 |
| pointcloud | 7 | 点云处理 |
| testing | 5 | 测试模块 |
| shapes | 2 | 几何形状 |

## [0.237.0] - 2026-10-20

### Changed — Trait-based Deduplication | 基于 Trait 的去重重构

#### `PointTransform` Trait | 点变换 Trait
- 在 `@core` 中定义 `pub(open) trait PointTransform`，包含 `apply` 和 `apply_batch`（默认实现）
- `Affine2`、`Rigid`、`Similarity` 均实现 `PointTransform`，消除 `apply` 和 `apply_batch` 重复定义
- `apply_batch` 使用 trait 默认实现，自动通过 `@core.map_points` + `self.apply` 完成

#### `cross`/`cross3` 去重 | 叉积去重（11 处）
- 删除 12 个文件中的 `cross`/`cross3` 重复定义，统一使用 `@core.turn`

#### `approx_eq` 去重 | 近似比较去重（8 处）
- 删除 4 个 wbtest 文件中的 `approx_eq(a,b,eps)` 定义，统一使用 `@core.approx_eq`
- 4 个测试模块中的 `approx_eq(a,b)` 改为一行包装，`approx_eq_tol` 调用改为 `@core.approx_eq`

#### `map_points` 去重 | 点映射去重（3 处）
- 在 `@core` 中添加 `pub fn map_points`，删除 3 个测试模块中的重复定义

## [0.236.0] - 2026-10-17

### Added — Formal Verification & Testing Modules | 形式化验证与测试模块（5 个模块，91 个测试）

#### Formal Property Tests | 形式化属性测试（`formal_properties`，31 测试）
- 距离公理（对称性、非负性、同一性、三角不等式）
- 变换属性（平移/旋转保持距离、旋转复合、逆变换、镜像对合性）
- 凸包属性（算法等价性、正方形凸包、共线点凸包）
- 多边形属性（正方形面积/周长、三角形面积、凸性检测）
- 向量空间属性（加法交换/结合/零元/逆元、点积对称/正半定、叉积反对称、标量分配律）

#### Formal Invariants | 不变量保持验证（`formal_invariants`，10 测试）
- 旋转/平移保持面积、缩放改变面积 s²、旋转保持周长
- 凸性在仿射变换/平移下保持、凸包面积 ≤ 包围矩形面积
- 对称形状质心在中心、距离平方非负、镜像保持面积

#### MOCK/FAKE Framework | 模拟测试框架（`mock_geometric`，13 测试）
- Mock 点生成器（网格、圆形、正多边形、共线点、正方形、三角形）
- FakeRNG 伪随机数生成器（LCG，可重现）
- Stub 函数（零距离、曼哈顿距离、恒等变换）
- 预设数据集（星形、L形、退化点集）

#### E2E Workflows | 端到端集成测试（`e2e_workflows`，9 测试）
- 凸包管线（点集→凸包→面积→包含检查）
- 变换逆管线（多边形→变换→逆变换→恢复）
- 算法比较（Andrew vs Graham 凸包）
- 缩放面积、变换合成、周长一致性、凸性不变量、距离矩阵对称性、变换链恒等恢复

#### AI Property Tests | AI 驱动属性测试（`ai_property_tests`，28 测试）
- 边界条件（空多边形、单点、两点、共线点、相同点凸包）
- 数值稳定性（极小/极大坐标、近零距离、零角度/2π旋转、零缩放、零平移）
- AI 随机属性验证（三角不等式、距离对称性、旋转保持距离、凸包包含、点积对称、叉积反对称）
- 极端值（负坐标、混合符号、细长矩形、100顶点多边形、双重镜像、缩放逆、凸多边形凸包、算法一致性）

### Stats | 统计
- 模块数：396 → 401
- 测试数：2427 → 2518
- 测试运行：9708 → 10072（四目标）

## [0.235.0] - 2026-10-17

### Added — Phase 21-24 Extension Modules | 扩展模块（40 个模块）

#### Phase 21: Advanced Geometric Algebra & Structures | 高级几何代数与结构（10 模块）
- **Geometric Algebra** (`geometric_algebra`)：Clifford 代数（多重向量、blade、旋量）
- **Symplectic Geometry** (`symplectic_geom`)：辛几何（辛形式、哈密顿流）
- **Contact Geometry** (`contact_geom`)：接触几何（接触形式、Legendre 子流形）
- **Information Geometry** (`info_geom`)：信息几何（Fisher 度量、统计流形）
- **Discrete Differential Geometry** (`discrete_diff_geom`)：离散微分几何（离散联络、和乐）
- **Conformal Geometry** (`conformal_geom`)：共形几何（保角映射、Möbius 变换）
- **Geometric Measure Theory** (`geom_measure`)：几何测度论（Hausdorff 测度）
- **Knot Theory** (`knot_theory`)：纽结理论（Jones 多项式、交叉数）
- **Lattice Geometry** (`lattice_geom`)：格几何（Bravais 格、倒格、Brillouin 区）
- **Geometric Arrangements** (`geom_arrangement`)：几何安排（直线安排、区域定理）

#### Phase 22: Robust & Exact Geometry | 鲁棒与精确几何（10 模块）
- **Exact Predicates** (`exact_pred`)：精确谓词（精确定向、精确圆内判定）
- **Robust Arithmetic** (`robust_arith`)：鲁棒算术（误差自由变换、Shewchuk 扩展）
- **Filtered Predicates** (`filtered_pred`)：过滤谓词（静态和动态过滤）
- **Static Filtering** (`static_filter`)：静态过滤（预计算误差界）
- **Dynamic Filtering** (`dynamic_filter`)：动态过滤（运行时间区间界）
- **Interval Arithmetic** (`interval_arith`)：区间算术（区间运算）
- **Adaptive Precision** (`adaptive_pred`)：自适应精度谓词（渐进细化）
- **Expansion Arithmetic** (`expansion_arith`)：扩展算术（非重叠扩展）
- **Robust Intersection** (`robust_inter`)：鲁棒相交（精确交点计算）
- **Robust Orientation** (`robust_orient`)：鲁棒定向（符号判定）

#### Phase 23: Geometric Optimization & Probability | 几何优化与概率（10 模块）
- **Geometric Optimization** (`geom_opt`)：几何优化（最小包围圆、最小宽度矩形）
- **Isoperimetric Problems** (`isoperimetric`)：等周问题（最优形状、等周不等式）
- **Geometric Inequalities** (`geom_inequal`)：几何不等式（Brunn-Minkowski、Cauchy-Schwarz）
- **Geometric Probability** (`geom_prob`)：几何概率（Buffon 投针、Bertrand 悖论）
- **Stochastic Geometry** (`stochastic_geom`)：随机几何（Poisson 过程、Boolean 模型）
- **Random Geometric Graphs** (`random_geom_graph`)：随机几何图（连通性、渗流）
- **Geometric Hashing** (`geom_hash`)：几何哈希（哈希表、基不变量）
- **Geometric Coding** (`geom_coding`)：几何编码（球填充、接吻数、Hamming 界）
- **Geometric Mechanics** (`geom_mechanics`)：几何力学（Lagrangian、Hamiltonian）
- **Symplectic Integrators** (`symplectic_int`)：辛积分器（Verlet、leapfrog、Ruth3）

#### Phase 24: Specialized Geometry Applications | 专门几何应用（10 模块）
- **Molecular Geometry** (`molecular_geom`)：分子几何（键角、扭转角、RMSD）
- **Protein Geometry** (`protein_geom`)：蛋白质几何（Ramachandran、二级结构）
- **Drug Design** (`drug_design`)：药物设计几何（药效团、对接评分）
- **Crystal Geometry** (`crystal_geom`)：晶体几何（点群、空间群、Bravais 类型）
- **Quantum Geometry** (`quantum_geom`)：量子几何（量子群、q-变形）
- **Topological Quantum** (`topological_quantum`)：拓扑量子计算（任意子、辫子）
- **Fractal Generation** (`fractal_gen`)：分形生成（Mandelbrot、Julia、Koch 曲线）
- **Chaos Geometry** (`chaos_geom`)：混沌几何（Lorenz、Lyapunov、Henon 映射）
- **Wavelet Geometry** (`wavelet_geom`)：小波几何（Haar 小波、Daubechies4）
- **Spectral Geometry** (`spectral_geom`)：谱几何（Laplacian 谱、热核、Weyl 律）

### Changed
- reexport.mbt 新增 703 行（10275 → 10978）
- 测试数 2308 → 2427，四目标 9232 → 9708 次全绿
- 模块数 356 → 396

## [0.234.0] - 2026-10-17

### Added — Phase 17-20 Extension Modules | 扩展模块（40 个模块）

#### Phase 17: Computational Statistics & ML Geometry | 计算统计与ML几何（10 模块）
- **Kernel Density Estimation** (`kernel_density`)：核密度估计
- **Gaussian Process** (`gaussian_process`)：高斯过程回归
- **SVM Geometry** (`svm_geometry`)：支持向量机几何
- **Decision Boundary** (`decision_boundary`)：决策边界几何
- **Feature Projection** (`feature_projection`)：特征投影
- **Manifold Learning** (`manifold_learning`)：流形学习（Isomap、LLE）
- **Dimension Reduction** (`dimension_reduction`)：降维（PCA、t-SNE）
- **Clustering Geometry** (`clustering_geom`)：聚类几何（K-means、DBSCAN）
- **Regression Geometry** (`regression_geom`)：回归几何
- **Bayesian Geometry** (`bayesian_geom`)：贝叶斯几何

#### Phase 18: Robotics & Motion Planning Advanced | 机器人高级运动规划（10 模块）
- **RRT\*** (`rrt_star`)：最优快速探索随机树
- **PRM Planner** (`prm_planner`)：概率路线图规划器
- **Potential Field** (`potential_field`)：人工势场法
- **Trajectory Optimization** (`trajectory_opt`)：轨迹优化
- **3D Motion Planner** (`motion_planner_3d`)：三维运动规划
- **Kinematics** (`kinematics`)：运动学（正/逆运动学）
- **Dynamics Geometry** (`dynamics_geom`)：动力学几何
- **3D Collision Detection** (`collision_detect_3d`)：三维碰撞检测
- **Grasp Planning** (`grasp_planning`)：抓取规划
- **Workspace Analysis** (`workspace_analysis`)：工作空间分析

#### Phase 19: Computer Graphics & Rendering | 计算机图形渲染（10 模块）
- **Ray Trace Ops** (`ray_trace_ops`)：光线追踪操作
- **Raster 2D** (`raster_2d`)：二维光栅化
- **Shading Model** (`shading_model`)：着色模型（Phong、Blinn-Phong）
- **Texture Mapping** (`texture_mapping`)：纹理映射
- **Bump Mapping** (`bump_mapping`)：凹凸映射
- **Environment Mapping** (`env_mapping`)：环境映射（立方体、球面）
- **Shadow Mapping** (`shadow_mapping`)：阴影映射
- **Anti-Aliasing** (`anti_aliasing`)：抗锯齿（MSAA、SSAA）
- **Splatting** (`splatting`)：点溅射渲染
- **GPU Geometry** (`gpu_geometry`)：GPU 几何着色器

#### Phase 20: Scientific Computing & PDE Solvers | 科学计算PDE求解器（10 模块）
- **Heat Equation** (`heat_equation`)：热方程求解器
- **Wave Equation** (`wave_equation`)：波动方程求解器
- **Poisson Solver** (`poisson_solver`)：泊松方程求解器
- **Navier-Stokes** (`navier_stokes`)：Navier-Stokes 方程求解器
- **Maxwell Solver** (`maxwell_solver`)：Maxwell 方程求解器
- **Schrödinger Solver** (`schrodinger_solver`)：Schrödinger 方程求解器
- **Reaction-Diffusion** (`reaction_diffusion`)：反应扩散方程
- **Advection Solver** (`advection_solver`)：对流方程求解器
- **Diffusion Solver** (`diffusion_solver`)：扩散方程求解器
- **Eigenvalue Solver** (`eigenvalue_solver`)：特征值求解器

### Changed
- reexport.mbt 新增 527 行（9748 → 10275）
- 测试数 2196 → 2308，四目标 8784 → 9232 次全绿
- 模块数 316 → 356

## [0.233.0] - 2026-10-16

### Added — Phase 13-16 Extension Modules | 扩展模块（40 个模块）

#### Phase 13: Computational Algebraic Geometry | 计算代数几何（10 模块）
- **Gröbner Basis** (`grobner_basis`)：多项式 Gröbner 基计算
- **Polynomial Ideal** (`polynomial_ideal`)：多项式理想运算
- **Algebraic Variety** (`algebraic_variety`)：代数簇求解
- **Rational Map** (`rational_map`)：有理映射
- **Intersection Theory** (`intersection_theory`)：相交理论
- **Chow Ring** (`chow_ring`)：Chow 环
- **Hilbert Function** (`hilbert_function`)：Hilbert 函数
- **Bézout Theorem** (`bezout_theorem`)：Bézout 定理
- **Multiplicity** (`multiplicity`)：相交重数
- **Elimination Ideal** (`elimination_ideal`)：消元理想

#### Phase 14: Differential Geometry & Discrete Surfaces | 微分几何与离散曲面（10 模块）
- **Discrete Curvature** (`discrete_curvature`)：离散曲率
- **Gauss-Bonnet** (`gauss_bonnet`)：Gauss-Bonnet 定理
- **Geodesic Distance** (`geodesic_dist`)：测地距离
- **Discrete Laplacian** (`discrete_laplacian`)：离散 Laplacian
- **Harmonic Map** (`harmonic_map`)：调和映射
- **Conformal Map** (`conformal_map`)：共形映射
- **Surface Ricci Flow** (`surface_ricci`)：曲面 Ricci 流
- **Discrete Yamabe** (`discrete_yamabe`)：离散 Yamabe 流
- **Willmore Energy** (`willmore_energy`)：Willmore 能量
- **Minimal Surface** (`minimal_surface`)：极小曲面

#### Phase 15: Persistent Topology Applications | 持久拓扑应用（10 模块）
- **Persistence Diagram** (`persistence_diagram`)：持久图
- **Bottleneck Distance** (`bottleneck_dist`)：瓶颈距离
- **Wasserstein Distance** (`wasserstein_dist`)：Wasserstein 距离
- **Persistence Landscape** (`persistence_landscape`)：持久景观
- **Persistence Image** (`persistence_image`)：持久图像
- **Mapper Algorithm** (`mapper_algo`)：Mapper 算法
- **Zigzag Persistence** (`zigzag_persistence`)：Zigzag 持久同调
- **Multidimensional Persistence** (`multidim_persistence`)：多维持久同调
- **Sheaf Theory** (`sheaf_theory`)：层论
- **TDA Features** (`tda_features`)：TDA 特征提取

#### Phase 16: Advanced Numerical Methods | 高级数值方法（10 模块）
- **Spectral Method** (`spectral_method`)：谱方法
- **Finite Element** (`finite_element`)：有限元方法
- **Boundary Element** (`boundary_element`)：边界元方法
- **Meshfree Method** (`meshfree_method`)：无网格方法
- **Level Set** (`level_set`)：水平集方法
- **Fast Marching** (`fast_marching`)：快速行进法
- **Fast Sweeping** (`fast_sweeping`)：快速扫描法
- **Lattice Boltzmann** (`lattice_boltzmann`)：格子 Boltzmann 方法
- **Discontinuous Galerkin** (`discontinuous_galerkin`)：间断 Galerkin 方法
- **Radial Basis** (`radial_basis`)：径向基函数

### Changed
- reexport.mbt 新增 626 行（9122 → 9748）
- 测试数 2080 → 2196，四目标 8320 → 8784 次全绿
- 模块数 276 → 316

## [0.232.0] - 2026-10-16

### Added — Phase 9-12 Extension Modules | 扩展模块（40 个模块）

#### Phase 9: Point Cloud Processing | 点云处理与3D重建（10 模块）
- **Point Cloud** (`point_cloud`)：点云基础操作（质心、包围盒、降采样）
- **Surface Reconstruction** (`surface_recon`)：贪心三角化曲面重建
- **Voxel Grid** (`voxel_grid`)：体素网格哈希
- **Normal Estimation** (`normal_est`)：PCA 法线估计
- **Curvature Estimation** (`curvature_est`)：主曲率、高斯曲率、平均曲率估计
- **Point Cloud Segmentation** (`pc_segment`)：区域生长与平面分割
- **Point Cloud Features** (`pc_feature`)：点云特征描述子
- **Ground Detection** (`ground_detect`)：地面点检测
- **Point Cloud Filter** (`pc_filter`)：点云滤波（统计、半径）
- **Point Cloud Transform** (`pc_transform`)：刚体变换（平移、旋转、缩放）

#### Phase 10: Computational Topology | 计算拓扑高级（10 模块）
- **Simplicial Complex** (`simplicial_complex`)：单纯复形数据结构
- **Chain Complex** (`chain_complex`)：链复形
- **Boundary Operator** (`boundary_operator`)：边缘算子
- **Homology Group** (`homology_group`)：同调群
- **Cohomology** (`cohomology`)：上同调
- **Discrete Morse** (`discrete_morse`)：离散 Morse 理论
- **Witness Complex** (`witness_complex`)：见证复形
- **Čech Complex** (`cech_complex`)：Čech 复形
- **Nerve Theorem** (`nerve_theorem`)：神经定理
- **Filtration** (`filtration`)：过滤序列

#### Phase 11: Robust & Exact Geometry | 鲁棒与精确几何（10 模块）
- **Exact Predicates** (`exact_predicates`)：精确几何谓词（定向、incircle）
- **Interval Arithmetic** (`interval_arithmetic`)：区间算术
- **Filtered Predicates** (`filtered_predicates`)：过滤谓词（快速近似 + 精确回退）
- **Perturbation** (`perturbation`)：符号扰动（SoS）
- **Robust Construction** (`robust_construction`)：鲁棒几何构造
- **Big Rational** (`big_rational`)：大有理数算术
- **DE-9IM** (`de9im`)：维度扩展9交模型
- **Lazy Exact** (`lazy_exact`)：惰性精确计算
- **Rounded Geometry** (`rounded_geometry`)：舍入几何
- **Affine Arithmetic** (`affine_arithmetic`)：仿射算术

#### Phase 12: Advanced Optimization | 高级优化（10 模块）
- **NSGA-II** (`nsga2`)：多目标进化算法
- **Pareto Front** (`pareto_front`)：Pareto 前沿与超体积指标
- **Bayesian Optimization** (`bayesian_opt`)：贝叶斯优化（高斯过程）
- **CMA-ES** (`cmaes`)：协方差矩阵自适应进化策略
- **Trust Region** (`trust_region`)：信赖域方法
- **SQP** (`sqp`)：序列二次规划
- **Augmented Lagrangian** (`augmented_lagrangian`)：增广拉格朗日法
- **Branch and Bound** (`branch_bound`)：分支定界
- **SDP** (`sdp`)：半定规划
- **SOCP** (`socp`)：二阶锥规划

### Stats | 统计
- Modules: 236 → 276 (+40)
- Tests: 1952 → 2080 (+128)
- Warnings: 0
- Errors: 0

## [0.230.0] - 2026-10-16

### Added — Extension Modules | 扩展模块（70 个模块）

#### Phase 2: Voronoi/Delaunay/Topology（10 模块）
- **Voronoi 3D** (`voronoi_3d`)：3D Voronoi diagram
- **Delaunay 3D** (`delaunay_3d`)：3D Delaunay triangulation
- **Constrained Delaunay** (`constrained_delaunay`)：Constrained Delaunay triangulation
- **Power Diagram** (`power_diagram`)：Power diagram (weighted Voronoi)
- **Centroidal Voronoi** (`centroidal_voronoi`)：Centroidal Voronoi tessellation (Lloyd's algorithm)
- **Alpha Complex** (`alpha_complex`)：Alpha complex filtration
- **Persistent Homology** (`persistent_homology`)：Persistent homology computation
- **Betti Numbers** (`betti_numbers`)：Betti numbers of simplicial complexes
- **Reeb Graph** (`reeb_graph`)：Reeb graph of scalar fields
- **Morse Complex** (`morse_complex`)：Morse-Smale complex

#### Phase 3: Robotics/Motion Planning（10 模块）
- **RRT** (`rrt`)：Rapidly-exploring Random Tree (RRT/RRT*/Bidirectional)
- **PRM** (`prm`)：Probabilistic Roadmap
- **A*** (`a_star`)：A* pathfinding on grids
- **Dubins** (`dubins`)：Dubins curve (shortest path with curvature constraint)
- **Reed-Shepp** (`reed_shepp`)：Reed-Shepp curve (with reverse motion)
- **Collision Detect** (`collision_detect`)：Collision detection
- **GJK** (`gjk`)：Gilbert-Johnson-Keerthi distance algorithm
- **SAT** (`sat`)：Separating Axis Theorem for convex shapes
- **Config Space** (`config_space`)：Configuration space construction
- **Path Smooth** (`path_smooth`)：Path smoothing (spline-based)

#### Phase 4: Shape Analysis/Descriptors（10 模块）
- **Shape Context** (`shape_context`)：Shape context descriptor
- **Fourier Descriptor** (`fourier_descriptor`)：Fourier descriptors for shape
- **Moment Invariants** (`moment_invariants`)：Hu moment invariants
- **Skeleton 3D** (`skeleton_3d`)：3D skeleton extraction
- **Medial Axis 3D** (`medial_axis_3d`)：3D medial axis transform
- **Shape Matching** (`shape_matching`)：Shape matching and registration
- **Curvature Scale** (`curvature_scale`)：Curvature scale space
- **Bend Energy** (`bend_energy`)：Bend energy minimization
- **Procrustes** (`procrustes`)：Procrustes analysis
- **ICP** (`icp`)：Iterative Closest Point registration

#### Phase 5: Numerical Optimization（10 模块）
- **Quadratic Programming** (`quadratic_prog`)：QP solver
- **Gradient Descent** (`gradient_descent`)：Gradient descent with line search
- **Newton's Method** (`newton_method`)：Newton and quasi-Newton methods
- **Levenberg-Marquardt** (`levenberg_marquardt`)：LM nonlinear least squares
- **Conjugate Gradient** (`conjugate_gradient`)：Nonlinear conjugate gradient
- **Simplex Method** (`simplex_method`)：Linear programming simplex
- **Interior Point** (`interior_point`)：Interior point method for LP
- **Simulated Annealing** (`simulated_annealing`)：SA global optimization
- **Genetic Algorithm** (`genetic_algorithm`)：GA global optimization
- **PSO** (`pso`)：Particle Swarm Optimization

#### Phase 6: GIS/Geodesics（10 模块）
- **GIS Projection** (`gis_projection`)：Map projections (UTM, Mercator, etc.)
- **Geodesic** (`geodesic`)：Geodesic distance on ellipsoid
- **GIS Buffer** (`gis_buffer`)：Buffer zone construction
- **TIN** (`tin`)：Triangulated Irregular Network
- **Coordinate Convert** (`coordinate_convert`)：Coordinate system conversion
- **Datum Transform** (`datum_transform`)：Geodetic datum transformation
- **Raster Ops** (`raster_ops`)：Raster operations
- **Contour Line** (`contour_line`)：Contour line extraction
- **Watershed** (`watershed`)：Watershed segmentation
- **Delaunay Terrain** (`delaunay_terrain`)：Terrain from Delaunay triangulation

#### Phase 7: File I/O/Rendering（10 模块）
- **OBJ I/O** (`obj_io`)：Wavefront OBJ file parser/writer
- **STL I/O** (`stl_io`)：STL file parser/writer
- **PLY I/O** (`ply_io`)：PLY file parser/writer
- **glTF I/O** (`gltf_io`)：glTF file parser/writer
- **GeoJSON I/O** (`geojson_io`)：GeoJSON parser/writer
- **DXF I/O** (`dxf_io`)：DXF file parser/writer
- **Ray Tracing** (`ray_tracing`)：Ray tracing renderer
- **Marching Cubes** (`marching_cubes`)：Marching cubes isosurface extraction
- **Hidden Line** (`hidden_line`)：Hidden line removal
- **Rasterization** (`rasterization`)：Triangle rasterization

#### Phase 8: Algebraic Geometry/Fractals（10 模块）
- **Conic Section** (`conic_section`)：Conic section analysis
- **Quadric Surface** (`quadric_surface`)：Quadric surface analysis
- **Resultant** (`resultant`)：Polynomial resultant computation
- **Bézier Clipping** (`bezier_clipping`)：Bézier curve intersection by clipping
- **Implicit Curve** (`implicit_curve`)：Implicit curve plotting
- **Implicit Surface** (`implicit_surface`)：Implicit surface plotting
- **IFS** (`ifs`)：Iterated Function System fractals
- **L-System** (`l_system`)：Lindenmayer system fractals
- **Fractal Dimension** (`fractal_dimension`)：Box-counting fractal dimension
- **Hausdorff Dimension** (`hausdorff_dimension`)：Hausdorff dimension estimation

### Tests | 测试

- Total tests: 1952 (+789 from v0.160.0)
- All four targets (native, wasm-gc, js, wasm) pass: 1952 × 4 = 7808 test runs green.

## [0.160.0] - 2026-10-16

### Added — 3D Geometry & Polyhedra | 三维几何与多面体（10 个模块）

- **AABB 3D** (`aabb3d`)：3D axis-aligned bounding box operations
- **Bounding Sphere** (`bounding_sphere`)：Minimum enclosing sphere (Ritter's algorithm)
- **OBB** (`obb`)：Oriented bounding box via PCA
- **Mesh Quality** (`mesh_quality`)：Mesh quality metrics (aspect ratio, edge ratio, area)
- **Polyhedron** (`polyhedron`)：Polyhedron representation and operations
- **Mesh Repair** (`mesh_repair`)：Mesh repair (hole filling, degenerate removal)
- **Mesh Param** (`mesh_param`)：Mesh parameterization (Tutte/Harmonic mapping)
- **Mesh Boolean** (`mesh_boolean`)：Mesh boolean operations (union/intersection/difference)
- **Polyhedron Boolean** (`polyhedron_boolean`)：Polyhedron boolean operations
- **Convex Hull 3D Dynamic** (`convex_hull_3d_dynamic`)：Dynamic 3D convex hull (incremental)

### Tests | 测试

- Total tests: 1232 (+79 from v0.156.1)
- All four targets (native, wasm-gc, js, wasm) pass: 1232 × 4 = 4928 test runs green.

## [0.156.0] - 2026-10-16

### Added — Application Algorithms | 应用算法（8 个模块）

- **Packing** (`packing`)：`pack_circles`, `pack_rectangles`, `packing_density`
- **Covering** (`covering`)：`min_enclosing_circle`, `greedy_cover`, `covering_radius`
- **Clustering** (`clustering`)：`kmeans`, `dbscan`, `cluster_centroids`
- **Registration** (`registration`)：`centroid_3d`, `translate_pts`, `icp`, `rms_error`
- **Matching** (`matching`)：`nearest_neighbor_match`, `hausdorff_distance`, `chamfer_distance`, `match_points`
- **Reconstruction** (`reconstruction`)：`estimate_normal`, `ball_pivot_reconstruct`, `distance_to_mesh`
- **Hough Transform** (`hough_transform`)：`hough_lines`, `hough_circles`, `hough_accumulator`, `hough_peaks`, `hough_line_to_points`
- **RANSAC** (`ransac`)：`ransac_line`, `ransac_circle`, `ransac_plane`, `ransac_refit_line`, `count_line_inliers`

### Tests | 测试

- Total tests: 1153 (+37 from v0.148.0)
- All four targets (native, wasm-gc, js, wasm) pass: 1153 × 4 = 4612 test runs green.

## [0.148.0] - 2026-10-16

### Added — Surface Modules | 曲面模块（8 个模块）

- **NURBS** (`nurbs`)：`bspline_basis`, `bspline_curve_point`, `nurbs_curve_point`, `nurbs_surface_point`, `find_span`, `uniform_knots`
- **Surface Mesh** (`surface_mesh`)：`face_normal`, `vertex_normal`, `triangle_area`, `mesh_area`, `midpoint_subdivide`, `mesh_bounding_box`, `validate_mesh`
- **Surface Param** (`surface_param`)：`eval_surface`, `surface_du`, `surface_dv`, `surface_normal`, `first_fundamental_form`, `second_fundamental_form`, `gaussian_curvature`, `mean_curvature`
- **Surface Revolve** (`surface_revolve`)：`revolve_x/y/z`, `revolve_point_z`, `revolve_area_z`
- **Surface Sweep** (`surface_sweep`)：`sweep_surface`, `sweep_point`, `sweep_area`
- **Surface Loft** (`surface_loft`)：`loft_linear`, `loft_cubic`, `loft_mesh`, `loft_point`
- **Surface Trim** (`surface_trim`)：`is_inside_trim`, `is_in_valid_region`, `trimmed_mesh`, `trimmed_area`
- **Bézier Surface** (`bezier_surface`)：`bernstein`, `bezier_curve`, `bezier_surface`, `bezier_surface_decasteljau`, `bezier_curve_derivative`, `bezier_degree_elevate`

**Total: 148 modules, 1116 tests, 4 targets green.**

## [0.140.0] - 2026-10-16

### Added — Numerical Computation | 数值计算（8 个模块）

- **Polynomial** (`polynomial`)：`poly_eval`, `poly_derivative`, `poly_add`, `poly_mul`, `poly_roots`
- **Root Find** (`root_find`)：`bisection`, `newton`, `secant`, `find_all_roots`
- **Integration** (`integration`)：`trapezoid`, `simpson`, `monte_carlo`, `adaptive_simpson`
- **Differentiation** (`differentiation`)：`forward_diff`, `central_diff`, `second_diff`, `gradient`, `laplacian`
- **Interpolation** (`interpolation`)：`lagrange_interp`, `newton_divdiff`, `newton_interp`, `linear_interp`, `bilinear_interp`
- **Eigen** (`eigen`)：`power_iteration`, `jacobi_eigenvalues`, `matrix_trace`
- **Linear Algebra** (`linalg`)：`solve_linear`, `determinant`, `matrix_inverse`
- **3D Matrix** (`matrix3d`)：`identity4`, `translation`, `scaling`, `rotation_x/y/z`, `mat4_mul`, `transform_point`, `transform_direction`, `mat4_transpose`, `mat4_determinant`, `mat4_inverse`, `look_at`, `perspective`, `ortho`

**Total: 140 modules, 1075 tests, 4 targets green.**

## [0.132.0] - 2026-10-16

### Added — Advanced Graph Algorithms | 高级图算法（8 个模块）

- **Shortest Path** (`shortest_path`)：`dijkstra`, `shortest_path_dist`, `shortest_path_vertices`
- **Visibility Graph** (`visibility_graph`)：`build_visibility_graph`, `visibility_vertices`, `visibility_edge_count`
- **Motion Plan** (`motion_plan`)：`plan_path`, `path_length`, `is_path_valid`
- **Voronoi Adv** (`voronoi_adv`)：`voronoi_cell`, `farthest_voronoi_cell`, `voronoi_cell_area`, `voronoi_cell_count`
- **Delaunay Refine** (`delaunay_refine`)：`delaunay_refine`, `circumcenter`, `min_triangle_angle`
- **Graph Color** (`graph_color`)：`greedy_color`, `chromatic_number_upper`, `is_valid_coloring`, `is_bipartite`
- **Graph Cut** (`graph_cut`)：`max_flow`, `min_cut`, `min_cut_partition`
- **Spanning Tree** (`spanning_tree`)：`kruskal_mst`, `mst_weight`, `mst_edge_count`, `is_connected`

**Total: 132 modules, 1031 tests, 4 targets green.**

## [0.124.0] - 2026-10-16

### Added — Advanced Spatial Structures | 高级空间结构（8 个模块）

- **R-Tree** (`rtree`)：`rtree_new`, `rtree_insert`, `rtree_range_query`, `rtree_size`, `rtree_get_all`
- **Octree** (`octree`)：`octree_new`, `octree_insert`, `octree_range_query`, `octree_size`
- **Ball Tree** (`ball_tree`)：`ball_tree_build`, `ball_tree_knn`, `ball_tree_count`
- **VP-Tree** (`vp_tree`)：`vp_tree_build`, `vp_tree_knn`, `vp_tree_count`
- **Cover Tree** (`cover_tree`)：`cover_tree_build`, `cover_tree_radius_search`, `cover_tree_count`
- **Interval Tree** (`interval_tree`)：`interval_tree_build`, `interval_tree_query`, `interval_tree_count`
- **Skip Quadtree** (`skip_quadtree`)：`skip_quadtree_new`, `skip_quadtree_insert`, `skip_quadtree_query`, `skip_quadtree_count`
- **Loose Octree** (`loose_octree`)：`loose_octree_new`, `loose_octree_insert`, `loose_octree_query`, `loose_octree_count`

**Total: 124 modules, 991 tests, 4 targets green.**

## [0.116.0] - 2026-10-16

### Added — Advanced Polygon Algorithms | 高级多边形算法（8 个模块）

- **Polygon Skeleton** (`polygon_skeleton`)：`straight_skeleton`, `skeleton_faces`
- **Polygon Medial** (`polygon_medial`)：`medial_axis`, `medial_axis_points`
- **Polygon Simplify** (`polygon_simplify`)：`simplify_topology_preserve`, `simplify_visvalingam`, `douglas_peucker`
- **Polygon Round** (`polygon_round`)：`round_polygon`, `round_corner`
- **Polygon Evolve** (`polygon_evolve`)：`curve_shortening_flow`, `evolve_step`, `flow_perimeters`, `flow_areas`
- **Polygon Morph** (`polygon_morph`)：`morph`, `morph_sequence`, `best_alignment`, `morph_aligned`
- **Polygon Decomp Opt** (`polygon_decomp_opt`)：`optimal_convex_decomp`, `decomp_count`, `is_convex_polygon`
- **Polygon Triangulate Fast** (`polygon_triangulate_fast`)：`fast_triangulate`, `fast_triangulate_points`, `triangle_count`, `total_triangle_area`

**Total: 116 modules, 951 tests, 4 targets green.**

## [0.108.0] - 2026-10-16

### Added — Advanced Convex Geometry | 高级凸几何（8 个模块）

- **Convex Hull Approx** (`convex_hull_approx`)：`approx_convex_hull`, `approx_hull_area`, `approx_hull_perimeter`, `approx_error_bound`
- **Convex Hull Dynamic** (`convex_hull_dynamic`)：`DynamicHull::new`, `insert`, `get_hull`, `size`, `contains`
- **Convex Layers** (`convex_layers`)：`convex_layers` (onion decomposition), `layer_count`, `outermost_layer`
- **Concave Hull** (`concave_hull`)：`concave_hull` (k-nearest neighbor), `concave_hull_default`
- **Convex Width** (`convex_width`)：`convex_width`, `convex_max_width`, `convex_aspect_ratio`
- **Convex Diameter** (`convex_diameter`)：`convex_diameter`, `convex_diameter_pair`, `antipodal_pairs`, `convex_radius_lower_bound`
- **Convex Center** (`convex_center`)：`convex_centroid`, `chebyshev_center`, `bbox_center`, `vertex_center`, `inradius`
- **Convex Intersection** (`convex_intersection`)：`convex_polygon_intersection` (Sutherland-Hodgman), `convex_polygons_intersect`, `intersection_area`

**Total: 108 modules, 911 tests, 4 targets green.**

## [2.0.0] - 2026-10-16

### Added — Optimization & Output | 优化与输出（5 个模块）

- **Optim** (`optim`)：`smallest_enclosing_circle`, `min_area_rect`, `centroid`, `closest_to_centroid`
- **Random Gen** (`random_gen`)：`Rng::new`, `next_uint`, `next_double`, `point2d`, `random_points`, `random_convex_polygon`
- **Sampling** (`sampling`)：`grid_sample`, `circle_sample`, `circle_interior_sample`, `poisson_disk_sample`, `segment_sample`, `halton_sample`
- **SVG Out** (`svg_out`)：`svg_header`, `svg_circle`, `svg_polygon`, `svg_line`, `svg_document`
- **JSON Out** (`json_out`)：`point2d_to_json`, `point3d_to_json`, `circle_to_json`, `polygon_to_json`, `scene_to_json`

### Milestone — 100 Modules | 100 模块里程碑

**Total: 100 modules, 871 tests, 4 targets green (native, wasm-gc, js, wasm).**

All planned modules are now implemented. The library covers:
- Core geometry types and operations
- Convex hull algorithms (2D and 3D)
- Polygon operations and boolean algebra
- Triangulation (Delaunay, Voronoi, ear clipping, monotone)
- Spatial data structures (KD-tree, quadtree, BVH, grid index, etc.)
- Distance metrics (Hausdorff, Fréchet, Chamfer, EMD, DTW, etc.)
- Planar subdivisions (DCEL, arrangement, overlay, trapezoidal map)
- Geometric transforms (homography, affine, rigid, similarity, inversion, stereographic)
- Mesh processing (simplification, smoothing, normals, subdivision, Euler characteristic)
- Curves and splines (Bézier, B-spline, Catmull-Rom, Hermite, Lagrange)
- Optimization, random generation, sampling, and output (SVG, JSON)

## [1.7.0] - 2026-10-16

### Added — Mesh Processing | 网格处理（6 个模块）

- **Mesh Data** (`mesh_data`)：`Mesh::new`, `add_vertex`, `add_face`, `edge_count`, `bounding_box`, `tetrahedron`
- **Mesh Simplify** (`mesh_simplify`)：`simplify_by_edge_length`, `edge_collapse_cost`, `collapsible_edges`, `simplification_ratio`
- **Mesh Smooth** (`mesh_smooth`)：`laplacian_smooth`, `laplacian_smooth_iter`, `taubin_smooth`, `smooth_displacement`
- **Mesh Normal** (`mesh_normal`)：`face_normal`, `vertex_normal`, `all_face_normals`, `all_vertex_normals`, `face_area`
- **Mesh Subdiv** (`mesh_subdiv`)：`loop_subdivide`, `edge_bisection`, `catmull_clark_subdivide`, `subdivided_face_count`
- **Euler Char** (`euler_char`)：`euler_characteristic`, `surface_genus`, `is_sphere`, `is_torus`, `betti_0`, `is_manifold`

**Total: 95 modules, 846 tests, 4 targets green.**

## [1.6.0] - 2026-10-16

### Added — Geometric Transforms | 几何变换（8 个模块）

- **Project3D** (`project3d`)：`orthographic`, `perspective_project`, `isometric`, `oblique`, `project_to_plane`
- **Homography** (`homography`)：`Homography::identity`, `from_array`, `apply`, `compose`, `determinant`
- **Perspective** (`perspective`)：`Perspective::new`, `project`, `unproject`, `depth`, `fov`, `focal_from_fov`
- **Stereographic** (`stereographic`)：`stereographic_from_sphere`, `stereographic_to_sphere`, `on_sphere`, `stereographic_scale`
- **Affine2** (`affine2`)：`Affine2::identity`, `translation`, `scale`, `shear`, `apply`, `compose`, `inverse`, `determinant`
- **Rigid** (`rigid`)：`Rigid::identity`, `translation`, `rotation`, `apply`, `compose`, `inverse`, `from_correspondence`
- **Similarity** (`similarity`)：`Similarity::identity`, `scaling`, `rotation`, `apply`, `compose`, `inverse`, `from_correspondence`
- **Inversion** (`inversion`)：`Inversion::new`, `apply`, `power`, `is_inside`, `is_on_circle`, `invert_line`

**Total: 89 modules, 816 tests, 4 targets green.**

## [1.5.0] - 2026-10-16

### Added — Planar Subdivision | 平面细分（8 个模块）

- **DCEL** (`dcel`)：`DCEL::new`, `add_vertex`, `add_edge`, `add_face`, `set_next`, `set_face`, `trace_face`, `from_polygon`
- **Arrangement** (`arrangement`)：`build_arrangement`, `arrangement_vertices`, `arrangement_intersection_count`, `arrangement_edge_count`, `arrangement_face_count`
- **Planar Graph** (`planar_graph`)：`PlanarGraph::new`, `add_vertex`, `add_edge`, `is_planar`, `is_connected`, `face_count`, `from_polygon`
- **Face Extract** (`face_extract`)：`extract_faces`, `face_area`, `face_count`
- **Overlay** (`overlay`)：`overlay`, `overlay_vertex_count`, `overlay_edge_count`, `overlay_vertices`, `overlay_edges`
- **Euler Tour** (`euler_tour`)：`build_euler_tour`, `euler_tour_sequence`, `euler_tour_lca`, `euler_tour_is_valid`
- **Trapezoidal** (`trapezoidal`)：`build_trapezoidal_map`, `trapezoidal_locate`, `trapezoidal_above_segment`, `trapezoidal_expected_count`
- **Zone** (`zone`)：`compute_zone`, `zone_crossed_count`, `zone_entry_points`, `zone_complexity`, `zone_complexity_bound`

**Total: 81 modules, 776 tests, 4 targets green.**

## [1.4.0] - 2026-10-16

### Added — Distance Metrics | 距离度量（8 个模块）

- **Hausdorff** (`hausdorff`)：`hausdorff_distance`, `hausdorff_directed`, `partial_hausdorff`
- **Fréchet** (`frechet`)：`frechet_distance`, `frechet_within`, `frechet_point_distance`
- **Chamfer** (`chamfer`)：`chamfer_distance`, `chamfer_directed`, `chamfer_rms`
- **EMD** (`emd`)：`emd_1d`, `emd_uniform`, `emd_weighted`
- **Bottleneck** (`bottleneck`)：`bottleneck_distance`, `bottleneck_match`, `bottleneck_max`
- **Point Match** (`pmatch`)：`point_match`, `match_count`, `match_ratio`
- **DTW** (`dtw`)：`dtw_distance`, `dtw_windowed`, `dtw_normalized`
- **Metric Tree** (`metric_tree`)：`build_metric_tree`, `metric_tree_query`, `metric_tree_nearest`

### Tests | 测试

- Added 40 tests, total 736 tests | 新增 40 测试，累计 736 测试
- All four targets green | 四目标全绿
- 73 modules total | 共 73 个模块

## [1.3.0] - 2026-10-16

### Added — Curve & Spline Algorithms | 曲线与样条算法（10 个模块）

- **Catmull-Rom Spline** (`catmull_rom`)：`catmull_rom_eval`, `catmull_rom_points`, `catmull_rom_derivative`
- **Hermite Spline** (`hermite`)：`hermite_eval`, `hermite_points`, `hermite_derivative`, `cardinal_tangents`
- **B-Spline** (`bspline`)：`bspline_basis`, `bspline_eval`, `uniform_knots`, `bspline_points`
- **Lagrange Interpolation** (`lagrange`)：`lagrange_eval`, `lagrange_basis`, `lagrange_interpolate`
- **Spline Utilities** (`spline`)：`spline_length`, `spline_curvature`, `spline_curvature_profile`
- **Arc Length** (`curve_arc`)：`arc_length`, `arc_length_at`, `arc_length_parametrize`
- **Curve Intersection** (`curve_intersect`)：`segments_cross`, `curve_self_intersect`, `curves_intersect`
- **Polyline** (`polyline`)：`polyline_length`, `polyline_simplify`, `polyline_subdivide`
- **Arc Length Utils** (`arc_length`)：`arc_length_segment`, `arc_length_total`, `arc_length_cumulative`
- **Curvature** (`curvature`)：`curvature_at`, `curvature_signed`, `curvature_profile`, `curvature_radius`

### Tests | 测试

- Added 50 tests, total 696 tests | 新增 50 测试，累计 696 测试
- All four targets green | 四目标全绿
- 65 modules total | 共 65 个模块

## [1.2.0] - 2026-10-16

### Added — Polygon Algorithms | 多边形算法（10 个模块）

- **Polygon Offset | 多边形偏移** (`polygon_offset` module)：`polygon_offset_outward`, `polygon_offset_inward`, `polygon_offset_area`, `polygon_offset_valid`
- **Polygon with Holes | 带孔多边形** (`polygon_holes` module)：`PolygonWithHoles`, `polygon_with_holes_area`, `polygon_with_holes_contains`, `polygon_with_holes_perimeter`
- **Visibility | 可见性** (`visibility` module)：`is_visible`, `visibility_polygon`, `visibility_polygon_convex`, `visible_vertex_count`
- **Art Gallery | 美术馆问题** (`art_gallery` module)：`art_gallery_guard_count`, `art_gallery_place_guards`, `art_gallery_covers_vertices`, `art_gallery_estimate`
- **Polygon Kernel | 多边形核** (`polygon_kernel` module)：`polygon_kernel`, `is_star_shaped`, `polygon_kernel_area`, `kernel_point`
- **Convex Decomposition | 凸分解** (`convex_decomp` module)：`convex_decomposition`, `convex_decomp_count`, `convex_decomp_lower_bound`, `convex_decomp_area`
- **Polygon Symmetry | 多边形对称** (`polygon_symmetry` module)：`has_reflection_symmetry`, `has_rotation_symmetry`, `polygon_symmetry_order`, `has_any_symmetry`
- **Polygon Cover | 多边形覆盖** (`polygon_cover` module)：`cover_by_rectangles`, `cover_by_triangles`, `cover_area_rectangles`, `cover_area_triangles`
- **Ear Clipping | 耳裁剪** (`ear_clip` module)：`is_ear`, `find_ear`, `ear_clip_triangulate`, `ear_clip_count`, `ear_clip_area`
- **Monotone Triangulation | 单调三角剖分** (`monotone` module)：`is_y_monotone`, `is_x_monotone`, `triangulate_monotone`, `monotone_triangulate_count`

### Tests | 测试

- Added 50 tests, total 646 tests | 新增 50 测试，累计 646 测试
- All four targets green, zero warnings | 四目标全绿，零警告
- 55 modules total | 共 55 个模块

## [1.1.0] - 2026-10-16

### Added — Convexity & Optimization | 凸性与优化（8 个模块）

- **Half-Plane | 半平面** (`half_plane` module)：`HalfPlane` struct, `half_plane_contains`, `half_plane_eval`, `half_plane_intersect`
- **Convex Clip | 凸多边形裁剪** (`convex_clip` module)：`clip_convex_by_line`, `clip_convex_by_half_plane`, `convex_area`
- **Convex Sum | 点集运算** (`convex_sum` module)：`point_set_sum`, `point_set_difference`, `point_set_scale`, `point_set_translate`, `point_set_centroid`, `point_set_equal`
- **Polar Dual | 极对偶** (`polar_dual` module)：`polar_dual_point`, `polar_dual`, `origin_inside`, `dual_area`
- **Linear Programming | 二维线性规划** (`linear_prog` module)：`LPResult`, `linear_program_2d`, `is_feasible`, `find_feasible_point`
- **3D Convex Hull | 三维凸包** (`convex_hull3d` module)：`HullFace`, `convex_hull_3d`, `hull_face_count`, `hull_volume`
- **Support Function | 支持函数** (`support` module)：`support_point_set`, `support_circle`, `support_value`, `support_segment`, `width_in_direction`
- **Separating Axis | 分离轴** (`separating` module)：`find_separating_axis`, `separating_distance`, `are_separated`

### Tests | 测试

- Added 36 tests, total 596 tests | 新增 36 测试，累计 596 测试
- All four targets green, zero warnings | 四目标全绿，零警告
- 45 modules total | 共 45 个模块

## [1.0.0] - 2026-10-15

### Added — Spatial Data Structures | 空间数据结构（8 个模块）

- **K-d Tree | K-d树** (`kdtree` module)：`build_kdtree`, `kdtree_nearest`, `kdtree_range_query`
- **Quadtree | 四叉树** (`quadtree` module)：`build_quadtree`, `quadtree_range_query`, `quadtree_count`
- **Grid Index | 网格索引** (`grid_index` module)：`build_grid_index`, `grid_query_radius`, `grid_query_rect`, `grid_query_cell`
- **Range Tree | 范围树** (`range_tree` module)：`build_range_tree`, `range_query`, `range_query_x`, `range_query_y`
- **Sorted Search | 有序搜索** (`sort_search` module)：`binary_search`, `lower_bound`, `upper_bound`, `unique_sorted`, `kth_element`, `merge_sorted`
- **Bucket PR k-d Tree | 桶PR树** (`bucket_pr` module)：`build_bucket_pr`, `bucket_pr_nearest`, `bucket_pr_count`
- **Spatial Hash | 空间哈希** (`spatial_hash` module)：`build_spatial_hash`, `spatial_hash_query_radius`, `spatial_hash_nearby`
- **BVH | 层次包围体** (`bvh` module)：`build_bvh`, `bvh_query`, `bvh_query_point`, `bvh_count_leaves`

### Tests | 测试

- Added 42 tests, total 560 tests | 新增 42 测试，累计 560 测试
- All four targets green, zero warnings | 四目标全绿，零警告
- 37 modules total | 共 37 个模块

## [0.9.0] - 2026-10-15

### Added — AABB Tree + Hash + Compare + Ray + Plane | AABB树 + 哈希 + 比较 + 射线 + 平面

- **AABB Tree | AABB树** (`aabb_tree` module)：
  - `build_aabb_tree`: build BVH from rectangles | 由矩形构建层次包围盒
  - `query_aabb`: overlap query | 重叠查询
  - `query_point_aabb`: point containment query | 点包含查询
  - `count_leaves` | 叶子节点计数
- **Geometric Hashing | 几何哈希** (`hash` module)：
  - `cell_index`, `cell_index_3d` | 网格单元索引
  - `cell_hash`, `cell_hash_3d` | 空间哈希
  - `segment_cells`, `segment_hash` | 线段哈希
  - `hash_combine` | 哈希合并
- **Comparison Predicates | 比较谓词** (`compare` module)：
  - `robust_orientation`, `robust_left_turn`, `robust_right_turn` | 鲁棒方向判定
  - `robust_collinear` | 共线判定
  - `compare_points`, `compare_segments`, `less_than`, `points_equal` | 字典序比较
- **Ray Operations | 射线运算** (`ray` module)：
  - `Ray::new`, `Ray::from_points`, `Ray::eval` | 射线构造与求值
  - `ray_segment_intersect`, `ray_line_intersect` | 射线相交
  - `ray_polygon_intersect`, `ray_polygon_contains` | 射线与多边形
- **3D Plane | 三维平面** (`plane` module)：
  - `Plane::from_normal_point`, `Plane::from_three_points` | 平面构造
  - `Plane::distance`, `Plane::contains` | 距离与包含
  - `Plane::line_intersect`, `Plane::normalize`, `Plane::project` | 相交、归一化、投影

### Tests | 测试

- Added 41 tests (7 aabb_tree + 8 hash + 10 compare + 8 ray + 8 plane), total 518 tests | 新增 41 测试，累计 518 测试
- All four targets green, zero warnings | 四目标全绿，零警告

## [0.8.0] - 2026-10-15

### Added — Vector + Matrix + Angle + Constants + Interval | 向量 + 矩阵 + 角度 + 常数 + 区间

- **Vector Operations | 向量运算** (`vector` module)：
  - `normalize`, `length`, `perp` | 归一化、长度、垂直向量
  - `reflect`, `project`, `reject` | 反射、投影、拒绝分量
  - `lerp`, `angle_between` | 线性插值、向量夹角
- **2x2 Matrix | 2x2 矩阵** (`matrix` module)：
  - `Mat2::new`, `identity`, `det`, `trace` | 构造、单位阵、行列式、迹
  - `mul`, `transform`, `inverse` | 矩阵乘法、变换、求逆
  - `rotation`, `scaling` | 旋转矩阵、缩放矩阵
- **Angle Utilities | 角度工具** (`angle` module)：
  - `deg_to_rad`, `rad_to_deg` | 角度弧度转换
  - `normalize_angle`, `normalize_angle_signed` | 归一化到 [0,2π) / [-π,π)
  - `angle_diff`, `bisector`, `is_between` | 角差、平分线、区间判定
- **Geometric Constants | 几何常数** (`constants` module)：
  - `pi`, `two_pi`, `half_pi`, `quarter_pi` | 圆周率族
  - `e`, `sqrt2`, `sqrt3`, `golden_ratio` | 数学常数
  - `deg2rad`, `rad2deg`, `eps` | 转换因子与精度
- **Interval Operations | 区间运算** (`interval` module)：
  - `Interval::new`, `contains`, `length`, `midpoint` | 构造、包含、长度、中点
  - `intersect`, `union`, `overlaps`, `contains_interval` | 交并集、重叠判定

### Tests | 测试

- Added 43 tests (9 vector + 9 matrix + 8 angle + 8 constants + 9 interval), total 477 tests | 新增 43 测试，累计 477 测试
- All four targets green, zero warnings | 四目标全绿，零警告

## [0.7.0] - 2026-10-15

### Added — Fitting + Sweep Line + Convex Polygon | 几何拟合 + 扫描线 + 凸多边形操作

- **Geometric Fitting | 几何拟合** (`fitting` module)：
  - `fit_line`: least-squares line fit with R² | 最小二乘直线拟合（含 R²）
  - `fit_line_orthogonal`: total least squares (PCA-based) | 正交距离回归
  - `fit_circle`: Kåsa method circle fit | Kåsa 方法圆拟合
  - `centroid`: point set centroid | 点集质心
- **Sweep Line | 扫描线** (`sweep_line` module)：
  - `has_any_intersection`, `count_intersections`, `find_all_intersections` | 相交检测
  - `find_intersection_points` | 交点计算
  - `is_simple_polygon_chain` | 简单多边形链检测
- **Convex Polygon Ops | 凸多边形操作** (`convex_polygon` module)：
  - `support_function`, `extreme_point` | 支持函数、极点查询
  - `point_in_convex_polygon`: O(log n) binary search | O(log n) 点包含
  - `tangent_from_point` | 外部点切线
  - `convex_polygons_intersect`: SAT O(n+m) | 分离轴定理相交检测
  - `point_to_convex_polygon_distance` | 点到凸多边形距离

### Tests | 测试

- Added 38 tests (13 fitting + 11 sweep_line + 14 convex_polygon), total 434 tests | 新增 38 测试，累计 434 测试
- All four targets green, zero warnings | 四目标全绿，零警告

## [0.6.0] - 2026-10-15

### Added — Rotating Calipers + Ellipse + Bezier | 旋转卡壳 + 椭圆 + 贝塞尔曲线

- **Rotating Calipers | 旋转卡壳** (`rotating_calipers` module)：
  - `convex_polygon_diameter`: farthest vertex pair, O(n) | 最远顶点对
  - `convex_polygon_width`: min parallel supporting line distance | 最小宽度
  - `farthest_point_pair`: from point set via hull + calipers | 点集最远点对
  - `min_perimeter_bounding_rect`: min perimeter enclosing rectangle | 最小周长包围矩形
- **Ellipse Geometry | 椭圆几何** (`ellipse` module)：
  - `Ellipse` type with center, semi-axes, rotation | 椭圆类型
  - `area`, `perimeter` (Ramanujan), `eccentricity`, `foci` | 面积、周长、离心率、焦点
  - `contains`, `on_boundary`, `line_intersect` | 包含、边界、直线相交
- **Bezier Curves | 贝塞尔曲线** (`bezier` module)：
  - `Bezier2` / `Bezier3`: quadratic and cubic curves | 二次/三次贝塞尔曲线
  - `eval`, `derivative`, `length` (numerical integration) | 求值、导数、弧长
  - `bbox`, `subdivide` | 包围盒、细分

### Tests | 测试

- Added 41 tests (13 rotating_calipers + 14 ellipse + 14 bezier), total 396 tests | 新增 41 测试，累计 396 测试
- All four targets (native/wasm-gc/js/wasm) green, zero warnings | 四目标全绿，零警告

## [0.5.0] - 2026-10-15

### Added — Phase 1-2: Tests + Circle Ops + Triangulate + Minkowski | 测试补充 + 圆相交 + 三角剖分 + Minkowski

- **Circle Intersection | 圆相交** (`circle_ops` module)：
  - `circle_segment_intersect`: circle-segment intersection points (0/1/2) | 圆与线段交点
  - `circle_circle_intersect`: circle-circle intersection points (0/1/2) | 两圆交点
  - `circle_line_intersect`: circle-line intersection points (0/1/2) | 圆与直线交点
  - `circle_polygon_intersect`: circle-polygon boundary intersection | 圆与多边形边界交点
- **Polygon Triangulation | 多边形三角剖分** (`triangulate` module)：
  - `triangulate_polygon`: ear clipping algorithm for simple polygon | ear clipping 简单多边形三角剖分
  - Returns vertex index triples `(i, j, k)` | 返回顶点索引三元组
- **Minkowski Operations | Minkowski 运算** (`minkowski` module)：
  - `minkowski_sum_convex`: Minkowski sum of two convex polygons | 两凸多边形 Minkowski 和
  - `minkowski_difference_convex`: Minkowski difference A ⊖ B = A ⊕ (-B) | Minkowski 差
  - `minkowski_sum_circle_polygon`: rounded polygon (circle + convex polygon) | 圆角多边形
  - `convex_polygons_collide`: collision detection via Minkowski difference | 碰撞检测
- **Test Coverage | 测试覆盖**：
  - Phase 1: added 50+ boundary/degenerate/property tests across 10 modules | 为 10 个模块补充边界/退化/属性测试
  - Phase 2: added 34 tests (13 circle_ops + 10 triangulate + 11 minkowski) | 新增 34 测试

### Tests | 测试

- Total 355 tests, all four targets (native/wasm-gc/js/wasm) green | 累计 355 测试，四目标全绿

### Fixed | 修复

- Eliminated all compiler warnings (unused package, deprecated APIs) | 消除所有编译器警告

## [0.4.0] - 2026-10-15

### Added — Week 4: Transforms + Distance + Bounding + Re-export | 几何变换 + 距离 + 包围盒 + 重导出

- **Geometric Transforms | 几何变换**：
  - `translate` / `translate_points`: point and array translation | 点与数组平移
  - `rotate` / `rotate_around` / `rotate_points`: rotation around origin/center | 绕原点/中心旋转
  - `scale` / `scale_around`: scaling relative to origin/center | 相对原点/中心缩放
  - `affine_transform` / `affine_transform_points`: general affine (a*x+b*y+c, d*x+e*y+f) | 一般仿射变换
  - `mirror_x` / `mirror_y` / `mirror_origin` / `mirror_line`: reflections | 镜像反射
  - `shear`: shear transform (x+kx*y, y+ky*x) | 剪切变换
- **Distance Computations | 距离计算**：
  - `point_to_segment_distance` / `point_to_polygon_distance` / `point_to_line_distance` | 点到线段/多边形/直线距离
  - `segment_to_segment_distance`: with intersection check | 线段间距离（含相交检测）
  - `polygon_to_polygon_distance`: edge-pair minimum distance | 多边形间最小距离
- **Bounding Volumes | 包围体**：
  - `aabb` / `aabb_polygon`: axis-aligned bounding box | 轴对齐包围盒
  - `min_area_bounding_rect`: rotating calipers on convex hull, returns (cx, cy, w, h, angle) | 旋转卡壳最小面积包围矩形
  - `bounding_circle`: centroid + max-distance approximation | 包围圆（质心+最大距离近似）
- **Re-export Module | 重导出模块**：
  - Root package `walkzzz/moon-geometry` re-exports all types and functions | 根包重导出全部类型和函数
  - Single import: `import "walkzzz/moon-geometry"` | 单包导入即可访问全部 API

### Tests | 测试

- Added 58 tests (25 transform + 18 distance + 15 bounding), total 271 tests, all four targets green | 新增 58 测试，累计 271 测试，四目标全绿

### Fixed | 修复

- `segment_to_segment_distance`: added intersection check for overlapping segments | 增加相交检测修复重叠线段距离

## [0.3.0] - 2026-10-15

### Added — Week 3: Delaunay Triangulation + Voronoi Diagram | Delaunay 三角剖分 + Voronoi 图

- **Delaunay Triangulation | Delaunay 三角剖分**：
  - `delaunay_triangulation`: Bowyer-Watson incremental insertion, O(n²) expected | Bowyer-Watson 增量插入法，O(n²) 期望
  - Super-triangle enclosure, bad triangle detection, hole re-triangulation | 超三角形包围、坏三角形检测、空洞重三角化
  - Returns CCW vertex index triples `TriangleIdx` | 返回 CCW 方向的顶点索引三元组 `TriangleIdx`
- **Voronoi Diagram | Voronoi 图**：
  - `voronoi_diagram`: Delaunay duality, returns (vertices, edges) | Delaunay 对偶，返回 (顶点, 边)
  - Vertices are Delaunay triangle circumcenters, edges connect adjacent circumcenters | 顶点为 Delaunay 三角形外心，边连接相邻三角形外心

### Tests | 测试

- Added 80 tests, total 213 tests, all four targets green | 新增 80 测试，累计 213 测试，四目标全绿
- Coverage: empty/degenerate input, convex polygons, grid points, star configurations, area consistency, circumcenter equidistance, no overlapping triangles | 覆盖：空/退化输入、凸多边形、网格点、星形配置、面积一致性、外心等距性、无重叠三角形

## [0.2.0] - 2026-10-15

### Added — Week 2: Segment Intersection + Closest Pair + Polygon Boolean Ops | 线段相交 + 最近点对 + 多边形布尔运算

- **Segment Intersection | 线段相交**：
  - `segments_intersect`: segment intersection test (including endpoint contact, collinear overlap) | 线段相交检测（含端点接触、共线重叠）
  - `segment_intersection`: intersection point computation (parametric, with collinear overlap) | 线段交点计算（参数化求解，含共线重叠）
  - `line_segment_intersection`: line-segment intersection | 直线与线段交点
- **Closest Pair | 最近点对**：
  - `closest_pair`: divide & conquer O(n log n), returns closest pair and distance | 分治法 O(n log n)，返回最近点对及距离
- **Polygon Boolean Ops | 多边形布尔运算**：
  - `clip_polygon`: Sutherland-Hodgman rectangle clipping | Sutherland-Hodgman 矩形裁剪
  - `polygon_intersection`: convex polygon intersection (Sutherland-Hodgman) | 凸多边形交集（Sutherland-Hodgman）
  - `polygon_union_area` / `polygon_difference_area`: union/difference area (inclusion-exclusion) | 并集/差集面积（容斥原理）

### Tests | 测试

- Added 45 tests, total 133 tests, all four targets green | 新增 45 测试，累计 133 测试，四目标全绿

## [0.1.0] - 2026-10-15

### Added — Week 1: Basic Types + Convex Hull + Polygon Ops | 基础类型 + 凸包 + 多边形操作

- **Basic Geometric Types | 基础几何类型**：
  - `Point2D` / `Point3D`: distance, add/sub, scalar mul, dot/cross, approx_eq | 距离、加减、数乘、点积、叉积、近似相等
  - `Segment`: length, direction, midpoint | 长度、方向、中点
  - `Line` (general form ax+by+c=0): from two points, point-to-line distance, evaluate | 一般式 ax+by+c=0：从两点构造、点到直线距离、方程求值
  - `Polygon`: vertex sequence, size, index access (wrapping) | 顶点序列、大小、按索引取顶点（环绕）
  - `Triangle`: signed area, area, centroid, circumcenter, incenter | 有符号面积、面积、质心、外心、内心
  - `Circle`: area, perimeter, contains | 面积、周长、包含判定
  - `Rectangle` (AABB): area, perimeter, width/height, contains, union, intersection | 面积、周长、宽高、包含、并集、交集
  - `Orientation` enum (Clockwise / CounterClockwise / Collinear) | 方向枚举
- **Convex Hull | 凸包**：
  - `convex_hull_andrew`: Andrew's monotone chain, O(n log n), numerically stable | Andrew 单调链法，O(n log n)，数值稳定
  - `convex_hull_graham`: Graham scan, O(n log n) | Graham 扫描法，O(n log n)
  - `ccw`: three-point orientation test | 三点方向判定
- **Polygon Ops | 多边形操作**：
  - `polygon_area` / `polygon_signed_area`: Shoelace formula | Shoelace 公式
  - `polygon_perimeter`, `polygon_centroid` (area-weighted) | 周长、重心（加权面积法）
  - `polygon_orientation`: orientation test | 方向判定
  - `is_convex`: convexity test | 凸性判断
  - `point_in_polygon`: ray casting point-in-polygon | 射线法点在多边形内
  - `simplify_polygon`: Douglas-Peucker simplification | Douglas-Peucker 简化
- **Utils | 工具**: `approx_eq` tolerance comparison, `default_eps` default precision | 容差比较、默认精度

### Tests | 测试

- 88 MoonBit tests, all four targets (native / wasm-gc / js / wasm) green | 88 个 MoonBit 测试，四目标全绿
- Correctness + boundary + degenerate cases (collinear, coincident, empty, single/two-point) | 正确性 + 边界 + 退化情况测试

### Infrastructure | 基础设施

- Project scaffold: `moon.mod` / `moon.pkg`, pure MoonBit zero C FFI | 项目骨架，纯 MoonBit 零 C FFI
- Bilingual README (Chinese / English) | 中英文 README 同步
- changelog / roadmap documentation governance | changelog / roadmap 文档治理