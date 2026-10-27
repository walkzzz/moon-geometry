///|
test "Barcode::new" {
  let b = Barcode::new(0.0, 1.0, 0)
  assert_true((b.birth - 0.0).abs() < 0.0000001)
  assert_true((b.death - 1.0).abs() < 0.0000001)
  assert_eq(b.dimension, 0)
}

///|
test "Barcode::is_infinite" {
  let b1 = Barcode::new(0.0, 999999999.0, 0)
  let b2 = Barcode::new(0.0, 1.0, 0)
  assert_true(b1.is_infinite())
  assert_false(b2.is_infinite())
}

///|
test "SimplexWithFiltration::new" {
  let s = SimplexWithFiltration::new([0, 1], 2.0)
  assert_eq(s.vertices.length(), 2)
  assert_true((s.filtration - 2.0).abs() < 0.0000001)
}

///|
test "persistent_homology empty" {
  let pd = persistent_homology([])
  assert_eq(pd.barcode_count(), 0)
}

///|
test "persistent_homology single vertex" {
  let simplices = [SimplexWithFiltration::new([0], 0.0)]
  let pd = persistent_homology(simplices)
  assert_eq(pd.barcode_count(), 1)
  assert_eq(pd.barcodes[0].dimension, 0)
  assert_true(pd.barcodes[0].is_infinite())
}

///|
test "persistent_homology two vertices" {
  let simplices = [
    SimplexWithFiltration::new([0], 0.0),
    SimplexWithFiltration::new([1], 0.0),
  ]
  let pd = persistent_homology(simplices)
  assert_eq(pd.barcode_count(), 2)
}

///|
test "persistent_homology edge" {
  let simplices = [
    SimplexWithFiltration::new([0], 0.0),
    SimplexWithFiltration::new([1], 0.0),
    SimplexWithFiltration::new([0, 1], 1.0),
  ]
  let pd = persistent_homology(simplices)
  let mut h0 = 0
  for b in pd.barcodes {
    if b.dimension == 0 && b.is_infinite() {
      h0 += 1
    }
  }
  assert_eq(h0, 1)
}

///|
test "persistence_pairs" {
  let simplices = [
    SimplexWithFiltration::new([0], 0.0),
    SimplexWithFiltration::new([1], 0.0),
    SimplexWithFiltration::new([0, 1], 1.0),
  ]
  let pairs = persistence_pairs(simplices)
  assert_true(pairs.length() >= 1)
}

///|
test "betti_from_barcode" {
  let barcodes = [
    Barcode::new(0.0, 999999999.0, 0),
    Barcode::new(0.0, 999999999.0, 0),
  ]
  let betti = betti_from_barcode(barcodes, 0.5)
  assert_eq(betti[0], 2)
}

///|
test "PersistenceDiagram::new" {
  let pd = PersistenceDiagram::new()
  assert_eq(pd.barcode_count(), 0)
}

///|
test "persistence_pairs empty" {
  let pairs = persistence_pairs([])
  assert_eq(pairs.length(), 0)
}

///|
test "persistence_pairs triangle filtration" {
  // 三角形过滤：3 顶点 + 3 边 + 1 三角形
  let simplices = [
    SimplexWithFiltration::new([0], 0.0),
    SimplexWithFiltration::new([1], 0.0),
    SimplexWithFiltration::new([2], 0.0),
    SimplexWithFiltration::new([0, 1], 1.0),
    SimplexWithFiltration::new([0, 2], 1.0),
    SimplexWithFiltration::new([1, 2], 1.0),
    SimplexWithFiltration::new([0, 1, 2], 2.0),
  ]
  let pairs = persistence_pairs(simplices)
  // 产生 3 个持久对（2 个 dim 0 + 1 个 dim 1）
  assert_eq(pairs.length(), 3)
}

///|
test "compute_barcode finite and infinite" {
  // 边过滤：2 顶点 + 1 边 → 1 有限 + 1 无穷条形码
  let simplices = [
    SimplexWithFiltration::new([0], 0.0),
    SimplexWithFiltration::new([1], 0.0),
    SimplexWithFiltration::new([0, 1], 1.0),
  ]
  let barcodes = compute_barcode(simplices)
  assert_eq(barcodes.length(), 2)
  let mut has_finite = false
  let mut has_infinite = false
  for b in barcodes {
    if b.is_infinite() {
      has_infinite = true
    } else {
      has_finite = true
    }
  }
  assert_true(has_finite)
  assert_true(has_infinite)
}

///|
test "persistent_homology triangle" {
  // 三角形：b0=1（无穷），覆盖 compute_barcode 有限条形码分支
  let simplices = [
    SimplexWithFiltration::new([0], 0.0),
    SimplexWithFiltration::new([1], 0.0),
    SimplexWithFiltration::new([2], 0.0),
    SimplexWithFiltration::new([0, 1], 1.0),
    SimplexWithFiltration::new([0, 2], 1.0),
    SimplexWithFiltration::new([1, 2], 1.0),
    SimplexWithFiltration::new([0, 1, 2], 2.0),
  ]
  let pd = persistent_homology(simplices)
  let mut h0_inf = 0
  for b in pd.barcodes {
    if b.dimension == 0 && b.is_infinite() {
      h0_inf += 1
    }
  }
  assert_eq(h0_inf, 1)
}

///|
test "sort_by_filtration same value different dims" {
  // 相同 filtration 值，不同维度：覆盖 fa == fb && da > db 分支
  let simplices = [
    SimplexWithFiltration::new([0, 1], 1.0),
    SimplexWithFiltration::new([0], 1.0),
  ]
  let pd = persistent_homology(simplices)
  // [0] 和 [0,1] 配对，产生 1 个有限条形码
  assert_eq(pd.barcode_count(), 1)
  assert_eq(pd.barcodes[0].dimension, 0)
  assert_false(pd.barcodes[0].is_infinite())
}

///|
test "betti_from_barcode out of range dimension" {
  // dimension >= 3 被忽略
  let barcodes = [
    Barcode::new(0.0, 999999999.0, 5),
    Barcode::new(0.0, 999999999.0, 0),
  ]
  let betti = betti_from_barcode(barcodes, 0.5)
  assert_eq(betti[0], 1)
  assert_eq(betti[1], 0)
  assert_eq(betti[2], 0)
}

///|
test "betti_from_barcode finite death beyond threshold" {
  // 有限 death > threshold → 计入
  let barcodes = [Barcode::new(0.0, 2.0, 0)]
  let betti = betti_from_barcode(barcodes, 1.0)
  assert_eq(betti[0], 1)
}

///|
test "betti_from_barcode birth beyond threshold" {
  // birth > threshold → 不计入
  let barcodes = [Barcode::new(2.0, 999999999.0, 0)]
  let betti = betti_from_barcode(barcodes, 1.0)
  assert_eq(betti[0], 0)
}

///|
test "betti_from_barcode death before threshold" {
  // death <= threshold 且非无穷 → 不计入
  let barcodes = [Barcode::new(0.0, 0.5, 0)]
  let betti = betti_from_barcode(barcodes, 1.0)
  assert_eq(betti[0], 0)
}

///|
test "betti_from_barcode mixed dimensions" {
  // 混合维度的条形码
  let barcodes = [
    Barcode::new(0.0, 999999999.0, 0),
    Barcode::new(0.0, 999999999.0, 1),
    Barcode::new(0.0, 999999999.0, 2),
  ]
  let betti = betti_from_barcode(barcodes, 0.5)
  assert_eq(betti[0], 1)
  assert_eq(betti[1], 1)
  assert_eq(betti[2], 1)
}

///|
test "persistent_homology single edge only" {
  // 只有边没有顶点（非常规输入，但测试 is_face 维度不匹配分支）
  let simplices = [SimplexWithFiltration::new([0, 1], 0.0)]
  let pd = persistent_homology(simplices)
  assert_eq(pd.barcode_count(), 1)
}

///|
test "compute_barcode empty" {
  let barcodes = compute_barcode([])
  assert_eq(barcodes.length(), 0)
}
