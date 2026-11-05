# 项目拆分方案 | Project Restructure Plan

> 将单一仓库拆分为 **1 个基础库 + 8 个专业库**，使用 git submodule 组织。
> Split single repo into **1 core library + 8 domain libraries**, organized via git submodules.
>
> v2: 基于 mooncakes.io 竞品分析更新差异化定位。

---

## 竞品分析 | Competitor Analysis (mooncakes.io)

### 直接竞品（几何库）

| 包名 | 下载 | 功能 | 与本项目关系 |
|------|------|------|-------------|
| `BigSaltyMan/moonclip` | 72 | 2D 多边形布尔/PolyTree/偏移/Minkowski | **部分重叠**（polygon boolean），但仅 2D 整数/小数网格 |
| `cn-xjr/moongeokit` | 61 | 2D 几何原语 + Grid 空间索引 | **部分重叠**（基础 2D），本项目更全面 |
| `totto2727/geo` | 80 | georust/geo 移植：2D 平面地理空间 | **互补**（GIS 方向），mg-gis 可参考 |
| `python123-ops/moon-cv-geometry` | 103 | 计算机视觉几何：投影/单应性/RANSAC | **互补**（CV 方向），基础库 homography 不重复 |
| `LING71671/moon_strtree` | 87 | STR 空间索引 + DTW/Fréchet 轨迹 | **部分重叠**（mg-spatial 距离度量），差异化 |
| `ZYK-ai-nb/moon-geo` | 25 | 2D 向量几何 | **重叠小**，本项目远超其范围 |

### CAD/网格竞品

| 包名 | 下载 | 功能 | 与本项目关系 |
|------|------|------|-------------|
| `gmlewis/step` | 263 | STEP CAD：3D 设计/挤出/扫掠/STEP 导出 | **强竞品**，mg-cad 需差异化（网格布尔/质量/修复） |
| `mik1e80/stlkit` | 118 | STL/OBJ/3MF/PLY 网格工具链 | **强竞品**，mg-cad IO 部分可引用而非重复 |
| `mik1e80/dxfkit` | 53 | DXF 读取 + 2D 轮廓检查 | **互补**，mg-cad DXF 可引用 |
| `ShiChengxu/moonsurface` | 11 | 三角曲面编辑 + Loop 细分 | **互补**，mg-cad mesh_subdiv 可参考 |
| `Milky2018/meshopt_mbt` | 179 | meshoptimizer 绑定：简化/优化 | **互补**（FFI 绑定 vs 纯 MoonBit） |
| `gmlewis/picogkffi` | 89 | PicoGK 几何内核：体素/SDF | **互补**（FFI vs 纯 MoonBit） |

### 拓扑竞品

| 包名 | 下载 | 功能 | 与本项目关系 |
|------|------|------|-------------|
| `wdgodghl/moontopolens` | 135 | 持久同调 H0/H1/H2 + Betti + 瓶颈距离 | **强竞品**，mg-topology 需差异化（流形修复/Reeb/骨架） |

### 路径规划/碰撞竞品

| 包名 | 下载 | 功能 | 与本项目关系 |
|------|------|------|-------------|
| `NoEmotionYY/moon-pathplanning` | 37 | BFS/DFS/Dijkstra/A*/RRT/RRT* | **强竞品**，mg-robotics 需差异化（Dubins/Reed-Shepp/构型空间） |
| `FlyCloudC/GJK` | 47 | GJK 碰撞检测 | **部分重叠**，mg-robotics GJK 可引用 |
| `uiwcvb/mooncollider` | 50 | 2D 游戏物理 + 碰撞 | **互补**（游戏物理 vs 几何碰撞） |

### 数值/优化竞品

| 包名 | 下载 | 功能 | 与本项目关系 |
|------|------|------|-------------|
| `yyyt0807/curvefit` | 43 | 曲线拟合 + Levenberg-Marquardt | **互补**，mg-pde 可参考 |
| `noweizongqing/numsolve` | 43 | ODE/根 finding/线性系统 | **互补**，mg-pde 专注 PDE/有限元 |
| `Luna-Flow/linear-algebra` | 3192 | 线性代数基础 | **强竞品**，基础库 linalg 保持轻量 |
| `CAIMEOX/symbit` | 209 | 符号数学（含 PDE） | **互补**（符号 vs 数值） |

### 其他相关

| 包名 | 下载 | 功能 | 与本项目关系 |
|------|------|------|-------------|
| `mizchi/three` | 311 | three.js 绑定：渲染/NURBS/CSG | **互补**（FFI vs 纯 MoonBit） |
| `hmyhmyhmyss/generative_patterns` | 73 | 生成模式：2D 几何/SVG/噪声 | **互补** |
| `0Ayachi0/math` | 81 | 数学工具（含几何） | **互补** |

### 竞品结论

1. **基础库 `moon-geometry`**：无全面竞品，本项目是最完整的纯 MoonBit 计算几何库
2. **mg-cad**：`gmlewis/step` 和 `mik1e80/stlkit` 是强竞品 → **差异化**：专注网格布尔运算、质量分析、修复、CAD 拉伸/扫掠，IO 部分可引用竞品
3. **mg-topology**：`wdgodghl/moontopolens` 是强竞品 → **差异化**：专注流形修复、Reeb 图、骨架、Marching Cubes，持久同调部分保持轻量
4. **mg-robotics**：`NoEmotionYY/moon-pathplanning` 是强竞品 → **差异化**：专注几何路径（Dubins/Reed-Shepp）、构型空间、SAT 碰撞
5. **mg-pde**：`Luna-Flow/linear-algebra` 是强竞品 → **差异化**：专注 PDE 求解（有限元/边界元/热方程/泊松/Navier-Stokes），线性代数引用竞品
6. **mg-spatial**：`LING71671/moon_strtree` 部分重叠 → **差异化**：专注距离度量（Hausdorff/Frechet/DTW/EMD/瓶颈）和高级结构
7. **mg-gis**：`totto2727/geo` 是互补 → **定位**：坐标转换、地形分析、栅格处理

---

## 总览 | Overview

| 仓库 | 包名 | 模块数 | 职责 | 竞品差异化 |
|------|------|--------|------|-----------|
| `moon-geometry` | `walkzzz/moon-geometry` | ~132 | 基础库：核心类型 + 基础算法 | 无全面竞品，最完整纯 MoonBit 几何库 |
| `mg-cad` | `walkzzz/mg-cad` | ~24 | CAD：网格布尔/拉伸/扫掠/曲面/质量 | vs `gmlewis/step`：专注网格布尔+质量+修复，IO 可引用 `stlkit` |
| `mg-gis` | `walkzzz/mg-gis` | ~10 | GIS：坐标转换/栅格/地形/GeoJSON | 互补 `totto2727/geo`，专注坐标转换+地形 |
| `mg-robotics` | `walkzzz/mg-robotics` | ~13 | 机器人：Dubins/Reed-Shepp/构型空间/SAT | vs `moon-pathplanning`：专注几何路径+构型空间 |
| `mg-topology` | `walkzzz/mg-topology` | ~15 | 拓扑：流形修复/Reeb/骨架/Marching Cubes | vs `moontopolens`：专注流形修复+骨架，持久同调保持轻量 |
| `mg-pde` | `walkzzz/mg-pde` | ~24 | 数值：PDE/有限元/边界元 | vs `linear-algebra`：专注 PDE 求解，线性代数引用竞品 |
| `mg-rendering` | `walkzzz/mg-rendering` | ~9 | 渲染：SVG/光线追踪/栅格化/分形 | 无直接竞品 |
| `mg-spatial` | `walkzzz/mg-spatial` | ~20 | 空间结构：BVH/R-tree/距离度量 | vs `moon_strtree`：专注距离度量+高级结构 |
| `mg-applied` | `walkzzz/mg-applied` | ~24 | 应用：ML/点云/统计/形状匹配 | 无直接竞品 |

## 依赖关系 | Dependency Graph

```
                    moon-geometry (基础库)
                         ↑
        ┌────┬────┬──────┼──────┬────┬────┬────┐
     mg-cad mg-gis mg-robotics mg-topology mg-pde mg-rendering mg-spatial mg-applied
```

- 所有专业库 **仅依赖** `moon-geometry`（基础库）
- 专业库之间 **无依赖**（完全独立）
- 基础库 **不依赖** 任何专业库
- 专业库 **可引用 mooncakes.io 竞品**（如 mg-cad 可引用 `mik1e80/stlkit` 做 IO）

## 仓库组织 | Repository Organization

```
moon-geometry/                    # 基础库主仓库
  moon.mod                        # name = "walkzzz/moon-geometry"
  base/  geometry/  transform/  spatial/  curves/  testing/
  ext/                            # 专业库 submodule 目录
    mg-cad/                       # git submodule → walkzzz/mg-cad
    mg-gis/                       # git submodule → walkzzz/mg-gis
    mg-robotics/                  # git submodule → walkzzz/mg-robotics
    mg-topology/                  # git submodule → walkzzz/mg-topology
    mg-pde/                       # git submodule → walkzzz/mg-pde
    mg-rendering/                 # git submodule → walkzzz/mg-rendering
    mg-spatial/                   # git submodule → walkzzz/mg-spatial
    mg-applied/                   # git submodule → walkzzz/mg-applied
```

克隆全部代码：
```bash
git clone --recursive https://github.com/walkzzz/moon-geometry.git
```

---

## 1. 基础库 `moon-geometry` (~132 模块)

> **定位**：无全面竞品。提供核心几何类型、基础算法、鲁棒算术、形式化证明。
> **vs `Luna-Flow/linear-algebra`**：linalg/matrix 保持轻量（仅几何所需），不重复通用线性代数。

### base/ (32 模块 — 全部保留)

```
base/
  adaptive_pred/        affine_arithmetic/   angle/              big_rational/
  compare/              constants/            core/               degenerate/
  exact_pred/           exact_predicates/    expansion_arith/    filtered_pred/
  filtered_predicates/  geom_error/          hash/               interval/
  interval_arith/       interval_arithmetic/ lazy_exact/         linalg/
  matrix/               matrix3d/            perturbation/       plane/
  polynomial/           random_gen/          ray/                robust_arith/
  robust_construction/  robust_inter/        robust_orient/      root_find/
  sort_search/          tolerance/           vector/
```

### geometry/ (40 模块 — 核心 + 高级算法)

```
geometry/
  # 核心
  hull/                    polygon/                triangulation/          triangulate/
  boolean/                 minkowski/              rotating_calipers/      convex_hull3d/
  convex_polygon/          convex_clip/            convex_decomp/          convex_diameter/
  convex_center/           convex_width/           delaunay_3d/            voronoi_3d/
  constrained_delaunay/    ear_clip/               monotone/               sweep_line/
  half_plane/              polar_dual/             support/                separating/
  dcel/                    polygon_holes/          polygon_offset/         polygon_simplify/
  incremental_delaunay/    power_diagram/          centroidal_voronoi/     voronoi_adv/
  # 高级
  arrangement/             art_gallery/            planar_graph/           overlay/
  euler_tour/              zone/                   geom_arrangement/      visibility/
  spanning_tree/           packing/                covering/               concave_hull/
  geom_prob/               geom_hash/              de9im/                  rounded_geometry/
  convex_hull_approx/      convex_hull_dynamic/    convex_hull_3d_dynamic/ convex_intersection/
  convex_sum/              convex_layers/          polygon_evolve/         polygon_morph/
  polygon_decomp_opt/      polygon_cover/          polygon_symmetry/       polygon_triangulate_fast/
  polygon_medial/          polygon_skeleton/       polygon_round/          isoperimetric/
```

### transform/ (8 模块 — 核心变换)

```
transform/
  affine2/         rigid/           similarity/      transform/
  homography/      perspective/     inversion/       stereographic/
```

### spatial/ (10 模块 — 核心结构)

```
spatial/
  kdtree/          quadtree/        distance/        bounding/
  nearest/         aabb3d/          aabb_tree/       obb/
  bounding_sphere/ grid_index/
```

### curves/ (12 模块 — 核心曲线)

```
curves/
  bezier/          bspline/         nurbs/           ellipse/
  circle_ops/      catmull_rom/     hermite/         lagrange/
  spline/          polyline/        arc_length/      curvature/
```

### testing/ (5 模块 — 基础测试)

```
testing/
  intersect/       fitting/         project3d/       trapezoidal/
  delaunay_refine/
```

### transform/ 高级 (9 模块 — 归基础库)

```
transform/
  bend_energy/          conformal_map/        discrete_curvature/  discrete_diff_geom/
  discrete_laplacian/   geodesic/             rational_map/        registration/
  procrustes/
```

### curves/ 高级 (8 模块 — 归基础库)

```
curves/
  curvature_scale/      curvature_est/        curve_arc/           curve_intersect/
  conic_section/        resultant/            geometric_algebra/   interpolation/
```

### testing/ 高级 (5 模块 — 归基础库)

```
testing/
  ai_property_tests/    e2e_workflows/        formal_invariants/   formal_properties/
  mock_geometric/
```

---

## 2. `mg-cad` — CAD 专业库 (~24 模块)

> **vs `gmlewis/step`**（263 下载）：step 是完整 CAD 内核（STEP 导出/挤出/扫掠），mg-cad **专注网格处理**（布尔运算/质量/修复/细分）
> **vs `mik1e80/stlkit`**（118 下载）：stlkit 是网格 IO 工具链，mg-cad **可引用 stlkit** 做 STL/OBJ/PLY IO，自身专注网格算法
> **vs `ShiChengxu/moonsurface`**（11 下载）：moonsurface 是曲面编辑+Loop 细分，mg-cad mesh_subdiv 可参考

### mesh/ (16 模块)

```
mesh/
  cad_extrude/         cad_sweep/           remesh/              mesh_boolean/
  polyhedron_boolean/  mesh_quality/        mesh_simplify/       mesh_smooth/
  mesh_subdiv/         mesh_param/          mesh_normal/         mesh_data/
  mesh_repair/         surface_mesh/        reconstruction/      polyhedron/
```

### curves/ (5 模块 — 曲面)

```
curves/
  bezier_surface/      quadric_surface/     implicit_surface/    implicit_curve/
  nurbs_intersect/
```

### io/ (3 模块 — 工业 IO，轻量)

```
io/
  step_iges/           volume_format/       dxf_io/
  # 注：STL/OBJ/PLY IO 可引用 mik1e80/stlkit，避免重复
```

---

## 3. `mg-gis` — GIS 专业库 (~10 模块)

> **vs `totto2727/geo`**（80 下载）：geo 是 georust/geo 移植（2D 平面地理），mg-gis **专注坐标转换+地形分析+栅格处理**
> **vs `phjphj676/moongeoroute`**（59 下载）：moongeoroute 是地理路由，mg-gis **不含路由**

```
transform/
  coordinate_convert/   datum_transform/
io/
  geojson_io/           raster_ops/          contour_line/        hough_transform/
geometry/
  delaunay_terrain/
testing/
  gis_projection/       gis_buffer/
applied/
  tin/
```

---

## 4. `mg-robotics` — 机器人专业库 (~13 模块)

> **vs `NoEmotionYY/moon-pathplanning`**（37 下载）：moon-pathplanning 是通用路径规划（BFS/Dijkstra/A*/RRT），mg-robotics **专注几何路径**（Dubins/Reed-Shepp）+ 构型空间 + SAT 碰撞
> **vs `FlyCloudC/GJK`**（47 下载）：GJK 是独立碰撞算法，mg-robotics 可**引用 GJK** 而非重复

```
applied/
  rrt/                  prm/                 a_star/              shortest_path/
  visibility_graph/     motion_plan/         collision_detect/    config_space/
  sat/
  # 注：GJK 可引用 FlyCloudC/GJK，避免重复
curves/
  dubins/               reed_shepp/          path_smooth/
```

---

## 5. `mg-topology` — 拓扑数据分析专业库 (~15 模块)

> **vs `wdgodghl/moontopolens`**（135 下载）：moontopolens 是完整 TDA 工具箱（H0/H1/H2 + 瓶颈距离 + persistence landscapes），mg-topology **差异化**：专注流形修复、Reeb 图、骨架、Marching Cubes，持久同调保持轻量

```
mesh/
  alpha_complex/        betti_numbers/       cech_complex/        euler_char/
  persistent_homology/  persistence_diagram/ reeb_graph/         simplicial_complex/
  knot_theory/          watershed/           skeleton_3d/         medial_axis_3d/
  marching_cubes/       topology_check/      nonmanifold_repair/
```

---

## 6. `mg-pde` — 数值/PDE 专业库 (~24 模块)

> **vs `Luna-Flow/linear-algebra`**（3192 下载）：linear-algebra 是通用线性代数，mg-pde **专注 PDE 求解**，线性代数可引用竞品
> **vs `noweizongqing/numsolve`**（43 下载）：numsolve 是 ODE 套件，mg-pde **专注 PDE**（有限元/边界元/热方程/泊松/Navier-Stokes）
> **vs `CAIMEOX/symbit`**（209 下载）：symbit 是符号数学，mg-pde 是**数值**方法

```
numerics/
  advection_solver/     boundary_element/    conjugate_gradient/  diffusion_solver/
  eigen/                fast_marching/       fast_sweeping/       finite_element/
  genetic_algorithm/    gradient_descent/    heat_equation/       interior_point/
  level_set/            levenberg_marquardt/ linear_prog/         navier_stokes/
  newton_method/        optim/               poisson_solver/      pso/
  quadratic_prog/       simplex_method/      simulated_annealing/ wave_equation/
```

---

## 7. `mg-rendering` — 渲染/IO 专业库 (~9 模块)

> **无直接竞品**。`mizchi/three`（311 下载）是 three.js FFI 绑定，mg-rendering 是**纯 MoonBit** 实现。

```
io/
  svg_out/              json_out/            ray_tracing/         hidden_line/
  rasterization/        ray_trace_ops/       raster_2d/           gpu_geometry/
  fractal_gen/
```

---

## 8. `mg-spatial` — 高级空间结构专业库 (~20 模块)

> **vs `LING71671/moon_strtree`**（87 下载）：moon_strtree 是 STR 空间索引 + DTW/Fréchet，mg-spatial **差异化**：专注距离度量（Hausdorff/Frechet/DTW/EMD/瓶颈）和更多结构（BVH/R-tree/八叉树/球树/VP树）

```
spatial/
  bvh/                  rtree/               octree/              ball_tree/
  vp_tree/              cover_tree/          interval_tree/       skip_quadtree/
  loose_octree/         range_tree/          bucket_pr/           spatial_hash/
  chamfer/              emd/                 bottleneck/          dtw/
  metric_tree/          voxel_grid/          hausdorff/           frechet/
```

---

## 9. `mg-applied` — 应用算法专业库 (~24 模块)

> **无直接竞品**。提供 ML/点云/统计/形状匹配算法。

```
applied/
  clustering/           matching/            sampling/            icp/
  pmatch/               point_cloud/         normal_est/          pc_segment/
  pc_feature/           pc_filter/           pc_transform/        shape_context/
  fourier_descriptor/   moment_invariants/   shape_matching/      graph_color/
  graph_cut/            random_geom_graph/   surface_reconstruction/
```

---

## 执行步骤 | Execution Steps

### Phase 1: 创建专业库仓库 (8 个)

对每个专业库 `mg-xxx`：
1. `git init` 创建新仓库
2. 创建 `moon.mod`（`name = "walkzzz/mg-xxx"`，`version = "0.1.0"`，依赖 `walkzzz/moon-geometry`）
3. 从主仓库 `moon-geometry` 移动对应模块目录
4. 更新每个模块的 `moon.pkg` 导入路径（`@core` → `@moon_geometry`）
5. 创建 `reexport.mbt` 聚合公共 API
6. `moon check && moon test` 验证
7. `git push` 推送到 GitHub

### Phase 2: 精简基础库

1. 从主仓库删除已移出的模块目录
2. 更新根 `moon.pkg`（移除已移出的导入）
3. 更新 `reexport.mbt`（移除已移出的重导出）
4. `moon check && moon test` 验证

### Phase 3: 添加 submodule

```bash
git submodule add https://github.com/walkzzz/mg-cad.git ext/mg-cad
git submodule add https://github.com/walkzzz/mg-gis.git ext/mg-gis
git submodule add https://github.com/walkzzz/mg-robotics.git ext/mg-robotics
git submodule add https://github.com/walkzzz/mg-topology.git ext/mg-topology
git submodule add https://github.com/walkzzz/mg-pde.git ext/mg-pde
git submodule add https://github.com/walkzzz/mg-rendering.git ext/mg-rendering
git submodule add https://github.com/walkzzz/mg-spatial.git ext/mg-spatial
git submodule add https://github.com/walkzzz/mg-applied.git ext/mg-applied
```

### Phase 4: 发布

1. 发布基础库 `moon publish`（`walkzzz/moon-geometry`）
2. 发布各专业库 `moon publish`（`walkzzz/mg-xxx`）
3. 更新 README 文档

---

## 用户使用方式 | Usage

### 仅用基础库

```bash
moon add walkzzz/moon-geometry
```

```moonbit
import "walkzzz/moon-geometry"
// 使用凸包、Delaunay、多边形等核心算法
```

### 用 CAD 专业库

```bash
moon add walkzzz/moon-geometry
moon add walkzzz/mg-cad
```

```moonbit
import "walkzzz/moon-geometry"
import "walkzzz/mg-cad"
// 使用 CAD 拉伸、网格布尔、STEP/IGES IO
```

### 用全部专业库

```bash
moon add walkzzz/moon-geometry
moon add walkzzz/mg-cad
moon add walkzzz/mg-gis
moon add walkzzz/mg-robotics
# ... 按需添加
```