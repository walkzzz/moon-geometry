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
