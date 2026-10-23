///|
/// Deterministic LCG pseudo-random 2D point generator in [0,1000)².
/// 确定性 LCG 伪随机二维点生成器，范围 [0,1000)²。
fn gen_points(n : Int32, seed : UInt32) -> Array[@geo.Point2D] {
  let pts : Array[@geo.Point2D] = []
  let mut state = seed
  for i = 0; i < n; i = i + 1 {
    state = state * 1103515245 + 12345
    let r1 = state
    state = state * 1103515245 + 12345
    let r2 = state
    let x = (r1 % 1000000).to_double() / 1000000.0 * 1000.0
    let y = (r2 % 1000000).to_double() / 1000000.0 * 1000.0
    pts.push(@geo.Point2D::new(x, y))
  }
  pts
}

///|
/// Generate a convex polygon with n vertices on a circle of radius 400.
/// 生成 n 个顶点的圆上凸多边形（半径 400）。
fn gen_convex_polygon(n : Int32) -> @geo.Polygon {
  let pts : Array[@geo.Point2D] = []
  let pi = 3.141592653589793
  for i = 0; i < n; i = i + 1 {
    let angle = 2.0 * pi * i.to_double() / n.to_double()
    pts.push(
      @geo.Point2D::new(
        500.0 + 400.0 * @math.cos(angle),
        500.0 + 400.0 * @math.sin(angle),
      ),
    )
  }
  @geo.Polygon::new(pts)
}

///|
/// Time a thunk and print elapsed milliseconds.
/// 计时并打印耗时（毫秒）。
fn timed(name : String, n : Int32, f : () -> Unit) -> Unit {
  let start = @benchlib.monotonic_clock_start()
  f()
  let elapsed = @benchlib.monotonic_clock_end(start)
  let ms = elapsed * 1000.0
  println("\{name} n=\{n}: \{ms} ms")
}

///|
/// Benchmark convex hull (Andrew monotone chain) on 100/1000/10000 points.
/// 凸包（Andrew 单调链）基准测试，规模 100/1000/10000 点。
test "bench:convex_hull" {
  let sizes : Array[Int32] = [100, 1000, 10000]
  for n in sizes {
    let pts = gen_points(n, 42U)
    timed("convex_hull", n, () => {
      let hull = @geo.convex_hull_andrew(pts)
      ignore(hull)
    })
  }
}

///|
/// Benchmark Delaunay triangulation on 100/1000 points.
/// Delaunay 三角剖分基准测试，规模 100/1000 点。
test "bench:delaunay" {
  let sizes : Array[Int32] = [100, 1000]
  for n in sizes {
    let pts = gen_points(n, 42U)
    timed("delaunay", n, () => {
      let tris = @geo.delaunay_triangulation(pts)
      ignore(tris)
    })
  }
}

///|
/// Benchmark polygon area on 100/1000 vertices.
/// 多边形面积基准测试，规模 100/1000 顶点。
test "bench:polygon_area" {
  let sizes : Array[Int32] = [100, 1000]
  for n in sizes {
    let poly = gen_convex_polygon(n)
    timed("polygon_area", n, () => {
      let area = @geo.polygon_area(poly)
      ignore(area)
    })
  }
}

///|
/// Benchmark point-in-polygon test on 100/1000 vertices.
/// 点在多边形内测试基准测试，规模 100/1000 顶点。
test "bench:point_in_polygon" {
  let sizes : Array[Int32] = [100, 1000]
  for n in sizes {
    let poly = gen_convex_polygon(n)
    let query = @geo.Point2D::new(500.0, 500.0)
    timed("point_in_polygon", n, () => {
      let inside = @geo.point_in_polygon(query, poly)
      ignore(inside)
    })
  }
}

///|
/// Benchmark k-d tree nearest neighbor on 100/1000 points (1000 queries each).
/// K-d 树最近邻搜索基准测试，规模 100/1000 点（每次 1000 次查询）。
test "bench:kdtree_nearest" {
  let sizes : Array[Int32] = [100, 1000]
  for n in sizes {
    let pts = gen_points(n, 42U)
    let tree = @geo.build_kdtree(pts)
    let queries = gen_points(1000, 99U)
    timed("kdtree_nearest", n, () => {
      for q in queries {
        let result = @geo.kdtree_nearest(tree, q)
        ignore(result)
      }
    })
  }
}

///|
/// Benchmark affine transform on 100/1000 points.
/// 仿射变换基准测试，规模 100/1000 点。
test "bench:affine_transform" {
  let sizes : Array[Int32] = [100, 1000]
  for n in sizes {
    let pts = gen_points(n, 42U)
    timed("affine_transform", n, () => {
      let result = @geo.affine_transform_points(
        pts, 1.5, 0.5, 0.0, 1.5, 10.0, 20.0,
      )
      ignore(result)
    })
  }
}
