test "kruskal_mst basic" {
  let n = 4
  let edges : Array[WEdge] = [
    { u: 0, v: 1, w: 1.0 },
    { u: 1, v: 2, w: 2.0 },
    { u: 2, v: 3, w: 3.0 },
    { u: 0, v: 3, w: 10.0 },
    { u: 1, v: 3, w: 5.0 },
  ]
  let mst = kruskal_mst(n, edges)
  assert_eq(mst.length(), 3)
}

test "mst_weight basic" {
  let n = 4
  let edges : Array[WEdge] = [
    { u: 0, v: 1, w: 1.0 },
    { u: 1, v: 2, w: 2.0 },
    { u: 2, v: 3, w: 3.0 },
    { u: 0, v: 3, w: 10.0 },
    { u: 1, v: 3, w: 5.0 },
  ]
  let w = mst_weight(n, edges)
  assert_true((w - 6.0).abs() < 0.001)
}

test "mst_edge_count basic" {
  let n = 3
  let edges : Array[WEdge] = [
    { u: 0, v: 1, w: 1.0 },
    { u: 1, v: 2, w: 2.0 },
    { u: 0, v: 2, w: 3.0 },
  ]
  assert_eq(mst_edge_count(n, edges), 2)
}

test "is_connected basic" {
  let n = 3
  let edges : Array[WEdge] = [
    { u: 0, v: 1, w: 1.0 },
    { u: 1, v: 2, w: 2.0 },
  ]
  assert_true(is_connected(n, edges))
}

test "is_connected disconnected" {
  let n = 4
  let edges : Array[WEdge] = [
    { u: 0, v: 1, w: 1.0 },
    { u: 2, v: 3, w: 2.0 },
  ]
  assert_false(is_connected(n, edges))
}