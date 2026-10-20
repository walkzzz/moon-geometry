test "is_inside_trim basic" {
  let trim_loop = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
  assert_true(is_inside_trim(0.5, 0.5, trim_loop))
  assert_true(!is_inside_trim(2.0, 2.0, trim_loop))
}

test "is_in_valid_region basic" {
  let outer = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
  let inner : Array[Array[(Double, Double)]] = []
  assert_true(is_in_valid_region(0.5, 0.5, outer, inner))
  assert_true(!is_in_valid_region(2.0, 2.0, outer, inner))
}

test "is_in_valid_region with hole" {
  let outer = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
  let hole = [(0.4, 0.4), (0.6, 0.4), (0.6, 0.6), (0.4, 0.6)]
  let inner = [hole]
  assert_true(is_in_valid_region(0.1, 0.1, outer, inner))
  assert_true(!is_in_valid_region(0.5, 0.5, outer, inner))
}

test "trimmed_mesh basic" {
  let s = fn(u : Double, v : Double) {
    (u, v, 0.0)
  }
  let outer = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]
  let inner : Array[Array[(Double, Double)]] = []
  let (verts, faces) = trimmed_mesh(s, outer, inner, 5, 5)
  assert_true(verts.length() > 0)
  assert_true(faces.length() > 0)
}

test "trimmed_area basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let faces = [(0, 1, 2)]
  let area = trimmed_area(verts, faces)
  assert_true((area - 0.5).abs() < 0.0001)
}