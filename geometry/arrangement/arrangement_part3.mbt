///|
/// Get all vertices of the arrangement. / 获取排列的所有顶点。
pub fn arrangement_vertices(arr : Arrangement) -> Array[ArrangementVertex] {
  arr.vertices
}

///|
/// Count the number of intersection vertices (excluding endpoints). / 计算交点顶点数（不含端点）。
pub fn arrangement_intersection_count(arr : Arrangement) -> Int32 {
  let mut count = 0
  for v in arr.vertices {
    if v.seg_ids.length() >= 2 {
      count += 1
    }
  }
  count
}

///|
/// Get the total number of edges in the arrangement (upper bound). / 获取排列中边的总数（上界）。
pub fn arrangement_edge_count(arr : Arrangement) -> Int32 {
  let n = arr.segments.length()
  let k = arrangement_intersection_count(arr)
  n + k
}

///|
/// Get the number of faces in the arrangement (Euler formula: F = E - V + 2). / 用欧拉公式获取排列的面数（F = E - V + 2）。
pub fn arrangement_face_count(arr : Arrangement) -> Int32 {
  let v = arr.vertices.length()
  let e = arrangement_edge_count(arr)
  e - v + 2
}
