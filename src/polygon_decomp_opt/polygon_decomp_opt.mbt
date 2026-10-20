/// |
/// # Optimal Convex Decomposition (Hertel-Mehlhorn)
/// # 最优凸分解（Hertel-Mehlhorn 算法）
///
/// Decompose a simple polygon into convex pieces using the Hertel-Mehlhorn
/// heuristic, which produces at most 4× the optimal number of pieces.
/// 使用 Hertel-Mehlhorn 启发式将简单多边形分解为凸块，
/// 产生的块数最多为最优解的 4 倍。
///
/// ## Complexity: O(n + r) where r = number of reflex vertices
/// ## 复杂度: O(n + r)，r = 反射顶点数

/// |
/// Decompose polygon into convex pieces using Hertel-Mehlhorn.
/// 使用 Hertel-Mehlhorn 分解多边形为凸块。
///
/// # Arguments / 参数
/// - `pts`: polygon vertices (counterclockwise) / 多边形顶点（逆时针）
pub fn optimal_convex_decomp(
  pts : Array[@core.Point2D],
) -> Array[Array[@core.Point2D]] {
  let n = pts.length()
  let result : Array[Array[@core.Point2D]] = []
  if n < 3 {
    return result
  }
  if n == 3 {
    result.push(pts.copy())
    return result
  }
  let reflex = find_reflex_vertices(pts)
  if reflex.length() == 0 {
    result.push(pts.copy())
    return result
  }
  let mut pieces : Array[Array[@core.Point2D]] = [pts.copy()]
  let mut changed = true
  let mut iter = 0
  while changed && iter < n * 2 {
    changed = false
    let new_pieces : Array[Array[@core.Point2D]] = []
    for k in 0..<pieces.length() {
      let piece = pieces[k]
      let pn = piece.length()
      if pn < 4 {
        new_pieces.push(piece)
        continue
      }
      let reflex_in_piece = find_reflex_vertices(piece)
      if reflex_in_piece.length() == 0 {
        new_pieces.push(piece)
        continue
      }
      let v = reflex_in_piece[0]
      let cut = find_valid_cut(piece, v)
      match cut {
        Some((a, b)) => {
          let (left, right) = split_polygon(piece, a, b)
          new_pieces.push(left)
          new_pieces.push(right)
          changed = true
        }
        None => new_pieces.push(piece)
      }
    }
    pieces = new_pieces
    iter += 1
  }
  for k in 0..<pieces.length() {
    if pieces[k].length() >= 3 {
      result.push(pieces[k])
    }
  }
  result
}

/// |
/// Count the minimum number of convex pieces needed.
/// 计算所需的最少凸块数。
pub fn decomp_count(pts : Array[@core.Point2D]) -> Int {
  optimal_convex_decomp(pts).length()
}

/// |
/// Check if a polygon is convex.
/// 检查多边形是否为凸多边形。
pub fn is_convex_polygon(pts : Array[@core.Point2D]) -> Bool {
  let n = pts.length()
  if n < 3 {
    return false
  }
  let mut sign = 0
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let cur = pts[i]
    let next = pts[(i + 1) % n]
    let cross = (cur.x() - prev.x()) * (next.y() - cur.y()) -
      (cur.y() - prev.y()) * (next.x() - cur.x())
    if cross.abs() < 0.0000000001 {
      continue
    }
    let s = if cross > 0.0 {
      1
    } else {
      -1
    }
    if sign == 0 {
      sign = s
    } else if sign != s {
      return false
    }
  }
  true
}

fn find_reflex_vertices(pts : Array[@core.Point2D]) -> Array[Int] {
  let n = pts.length()
  let result : Array[Int] = []
  if n < 3 {
    return result
  }
  let mut sign = 0
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let cur = pts[i]
    let next = pts[(i + 1) % n]
    let cross = (cur.x() - prev.x()) * (next.y() - cur.y()) -
      (cur.y() - prev.y()) * (next.x() - cur.x())
    if cross.abs() < 0.0000000001 {
      continue
    }
    let s = if cross > 0.0 {
      1
    } else {
      -1
    }
    if sign == 0 {
      sign = s
    }
    if s != sign {
      result.push(i)
    }
  }
  result
}

fn find_valid_cut(
  pts : Array[@core.Point2D],
  v : Int,
) -> (Int, Int)? {
  let n = pts.length()
  let vp = pts[(v - 1 + n) % n]
  let vc = pts[v]
  let vn = pts[(v + 1) % n]
  for j in 0..<n {
    if j == v || j == (v - 1 + n) % n || j == (v + 1) % n {
      continue
    }
    let target = pts[j]
    if is_diagonal(pts, v, j) {
      let d1 = (target.x() - vp.x()) * (vc.y() - vp.y()) -
        (target.y() - vp.y()) * (vc.x() - vp.x())
      let d2 = (target.x() - vn.x()) * (vc.y() - vn.y()) -
        (target.y() - vn.y()) * (vc.x() - vn.x())
      if d1 * d2 > 0.0 {
        return Some((v, j))
      }
    }
  }
  None
}

fn is_diagonal(pts : Array[@core.Point2D], i : Int, j : Int) -> Bool {
  let n = pts.length()
  let a = pts[i]
  let b = pts[j]
  for k in 0..<n {
    if k == i || k == j {
      continue
    }
    let k2 = (k + 1) % n
    if k2 == i || k2 == j {
      continue
    }
    if segments_cross(a, b, pts[k], pts[k2]) {
      return false
    }
  }
  true
}

fn segments_cross(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(b1, b2, a1)
  let d2 = @core.turn(b1, b2, a2)
  let d3 = @core.turn(a1, a2, b1)
  let d4 = @core.turn(a1, a2, b2)
  ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
    ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0))
}

fn split_polygon(
  pts : Array[@core.Point2D],
  a : Int,
  b : Int,
) -> (Array[@core.Point2D], Array[@core.Point2D]) {
  let left : Array[@core.Point2D] = []
  let right : Array[@core.Point2D] = []
  let n = pts.length()
  let mut i = a
  while true {
    left.push(pts[i])
    if i == b {
      break
    }
    i = (i + 1) % n
  }
  let mut j = b
  while true {
    right.push(pts[j])
    if j == a {
      break
    }
    j = (j + 1) % n
  }
  (left, right)
}