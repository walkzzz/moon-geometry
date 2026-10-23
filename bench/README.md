# Benchmarks | 性能基准

Core algorithm benchmark suite for `moon-geometry`.

核心算法性能基准测试套件。

## Run benchmarks | 运行基准测试

```bash
moon test -p walkzzz/moon-geometry/bench
```

## Benchmark list | 基准测试列表

| Name | Algorithm | Sizes |
|------|-----------|-------|
| `bench:convex_hull` | Convex hull (Andrew monotone chain) | 100 / 1000 / 10000 |
| `bench:delaunay` | Delaunay triangulation | 100 / 1000 |
| `bench:polygon_area` | Polygon area (shoelace) | 100 / 1000 |
| `bench:point_in_polygon` | Point-in-polygon (ray casting) | 100 / 1000 |
| `bench:kdtree_nearest` | k-d tree nearest neighbor | 100 / 1000 |
| `bench:affine_transform` | Affine transform (batch) | 100 / 1000 |

## Output | 输出

Each benchmark prints elapsed time in milliseconds, e.g.:

```
convex_hull n=100: 0.12 ms
convex_hull n=1000: 1.5 ms
convex_hull n=10000: 18.3 ms
```