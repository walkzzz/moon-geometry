///|
test "vp_tree build and count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = vp_tree_build(pts)
  assert_eq(vp_tree_count(tree), 5)
}

///|
test "vp_tree knn" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = vp_tree_build(pts)
  let nn = vp_tree_knn(tree, @core.Point2D::new(1.0, 1.0), 2)
  assert_eq(nn.length(), 2)
}

///|
test "vp_tree empty" {
  let tree = vp_tree_build([])
  assert_eq(vp_tree_count(tree), 0)
}

///|
test "vp_tree single" {
  let tree = vp_tree_build([@core.Point2D::new(1.0, 1.0)])
  assert_eq(vp_tree_count(tree), 1)
}

///|
test "vp_tree many points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<15 {
    pts.push(@core.Point2D::new(i.to_double(), i.to_double() * 2.0))
  }
  let tree = vp_tree_build(pts)
  assert_eq(vp_tree_count(tree), 15)
}

///|
test "vp_tree knn sort branches and replace" {
  // 覆盖 L110/L112 (首个 sort_by 的 -1 与 1) 与 L118/L119/L123 (替换分支及其 sort 的 1)
  // 构造使遍历先入远点、后入近点，触发 result 满 k 后替换最远元素
  let pts = [
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let tree = vp_tree_build(pts)
  let nn = vp_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 3)
  assert_eq(nn.length(), 3)
  // 最近邻应为 (0,0), (3,0), (5,0)
  assert_true((nn[0].x() - 0.0).abs() < 0.001)
  assert_true((nn[1].x() - 3.0).abs() < 0.001)
  assert_true((nn[2].x() - 5.0).abs() < 0.001)
}

///|
test "vp_tree knn replace sort equal and less" {
  // 覆盖 L121 (替换 sort 的 -1) 与 L125 (替换 sort 的 0: 等距离比较)
  // 替换后 result 含等距离点 (1,0) 与 (-1,0)，sort 比较返回 0
  let pts = [
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(-1.0, 0.0),
  ]
  let tree = vp_tree_build(pts)
  let nn = vp_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 2)
  assert_eq(nn.length(), 2)
  // 两个最近邻距离均为 1: (1,0) 与 (-1,0)
  let d0 = (nn[0].x() * nn[0].x() + nn[0].y() * nn[0].y()).sqrt()
  let d1 = (nn[1].x() * nn[1].x() + nn[1].y() * nn[1].y()).sqrt()
  assert_true((d0 - 1.0).abs() < 0.001)
  assert_true((d1 - 1.0).abs() < 0.001)
}
