///|
/// Grid cell index of a 2D point. / 二维点的网格单元索引。
pub fn cell_index(p : @core.Point2D, cell_size : Double) -> (Int32, Int32) {
  let cx = (p.x() / cell_size).floor()
  let cy = (p.y() / cell_size).floor()
  (cx.to_int(), cy.to_int())
}

///|
/// Grid cell index of a 3D point. / 三维点的网格单元索引。
pub fn cell_index_3d(
  p : @core.Point3D,
  cell_size : Double,
) -> (Int32, Int32, Int32) {
  let cx = (p.x / cell_size).floor()
  let cy = (p.y / cell_size).floor()
  let cz = (p.z / cell_size).floor()
  (cx.to_int(), cy.to_int(), cz.to_int())
}

///|
/// Hash a 2D point to a table index. / 将二维点哈希到表索引。
pub fn cell_hash(
  p : @core.Point2D,
  cell_size : Double,
  table_size : Int32,
) -> Int32 {
  let (cx, cy) = cell_index(p, cell_size)
  let h = (cx * 73856093) ^ (cy * 19349663)
  let result = h % table_size
  if result < 0 {
    result + table_size
  } else {
    result
  }
}

///|
/// Hash a 3D point to a table index. / 将三维点哈希到表索引。
pub fn cell_hash_3d(
  p : @core.Point3D,
  cell_size : Double,
  table_size : Int32,
) -> Int32 {
  let (cx, cy, cz) = cell_index_3d(p, cell_size)
  let h = (cx * 73856093) ^ (cy * 19349663) ^ (cz * 83492791)
  let result = h % table_size
  if result < 0 {
    result + table_size
  } else {
    result
  }
}

///|
/// Combine two hash values. / 合并两个哈希值。
pub fn hash_combine(a : Int32, b : Int32) -> Int32 {
  a * 31 + b
}

///|
/// Cell indices of a segment's endpoints. / 线段端点的单元索引。
pub fn segment_cells(
  seg : @core.Segment,
  cell_size : Double,
) -> ((Int32, Int32), (Int32, Int32)) {
  (cell_index(seg.start, cell_size), cell_index(seg.end, cell_size))
}

///|
/// Hash a segment to a table index. / 将线段哈希到表索引。
pub fn segment_hash(
  seg : @core.Segment,
  cell_size : Double,
  table_size : Int32,
) -> Int32 {
  let h1 = cell_hash(seg.start, cell_size, table_size)
  let h2 = cell_hash(seg.end, cell_size, table_size)
  let result = hash_combine(h1, h2) % table_size
  if result < 0 {
    result + table_size
  } else {
    result
  }
}
