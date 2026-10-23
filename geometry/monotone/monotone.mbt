///|
/// Check if a polygon is y-monotone (single chain from top to bottom). / 检查多边形是否 y-单调（从顶到底的单链）。
pub fn is_y_monotone(poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  if n < 3 {
    return false
  }
  let mut top_idx = 0
  let mut bottom_idx = 0
  for i in 1..<n {
    if poly[i].y() > poly[top_idx].y() {
      top_idx = i
    }
    if poly[i].y() < poly[bottom_idx].y() {
      bottom_idx = i
    }
  }
  let left_chain : Array[Int32] = []
  let right_chain : Array[Int32] = []
  let mut i = top_idx
  while i != bottom_idx {
    left_chain.push(i)
    i = (i + 1) % n
  }
  left_chain.push(bottom_idx)
  i = top_idx
  while i != bottom_idx {
    right_chain.push(i)
    i = (i - 1 + n) % n
  }
  right_chain.push(bottom_idx)
  for k in 1..<left_chain.length() {
    if poly[left_chain[k]].y() > poly[left_chain[k - 1]].y() {
      return false
    }
  }
  for k in 1..<right_chain.length() {
    if poly[right_chain[k]].y() > poly[right_chain[k - 1]].y() {
      return false
    }
  }
  true
}

///|
/// Check if a polygon is x-monotone. / 检查多边形是否 x-单调。
pub fn is_x_monotone(poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  if n < 3 {
    return false
  }
  let mut left_idx = 0
  let mut right_idx = 0
  for i in 1..<n {
    if poly[i].x() < poly[left_idx].x() {
      left_idx = i
    }
    if poly[i].x() > poly[right_idx].x() {
      right_idx = i
    }
  }
  let upper : Array[Int32] = []
  let lower : Array[Int32] = []
  let mut i = left_idx
  while i != right_idx {
    upper.push(i)
    i = (i + 1) % n
  }
  upper.push(right_idx)
  i = left_idx
  while i != right_idx {
    lower.push(i)
    i = (i - 1 + n) % n
  }
  lower.push(right_idx)
  for k in 1..<upper.length() {
    if poly[upper[k]].x() < poly[upper[k - 1]].x() {
      return false
    }
  }
  for k in 1..<lower.length() {
    if poly[lower[k]].x() < poly[lower[k - 1]].x() {
      return false
    }
  }
  true
}

///|
/// Triangulate a y-monotone polygon using stack-based algorithm. / 使用栈算法三角剖分 y-单调多边形。
pub fn triangulate_monotone(
  poly : Array[@core.Point2D],
) -> Array[(Int32, Int32, Int32)] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  if n == 3 {
    return [(0, 1, 2)]
  }
  let triangles : Array[(Int32, Int32, Int32)] = []
  let mut top_idx = 0
  let mut bottom_idx = 0
  for i in 1..<n {
    if poly[i].y() > poly[top_idx].y() {
      top_idx = i
    }
    if poly[i].y() < poly[bottom_idx].y() {
      bottom_idx = i
    }
  }
  let left_chain : Array[Int32] = []
  let right_chain : Array[Int32] = []
  let mut i = top_idx
  while i != bottom_idx {
    left_chain.push(i)
    i = (i + 1) % n
  }
  left_chain.push(bottom_idx)
  i = (top_idx - 1 + n) % n
  while i != bottom_idx {
    right_chain.push(i)
    i = (i - 1 + n) % n
  }
  right_chain.push(bottom_idx)
  let merged : Array[(Int32, Int32)] = []
  let mut li = 0
  let mut ri = 0
  while li < left_chain.length() || ri < right_chain.length() {
    if li >= left_chain.length() {
      merged.push((right_chain[ri], 1))
      ri += 1
    } else if ri >= right_chain.length() {
      merged.push((left_chain[li], 0))
      li += 1
    } else if poly[left_chain[li]].y() > poly[right_chain[ri]].y() {
      merged.push((left_chain[li], 0))
      li += 1
    } else if poly[left_chain[li]].y() < poly[right_chain[ri]].y() {
      merged.push((right_chain[ri], 1))
      ri += 1
    } else {
      merged.push((left_chain[li], 0))
      li += 1
    }
  }
  let stack : Array[(Int32, Int32)] = []
  stack.push(merged[0])
  stack.push(merged[1])
  for k in 2..<merged.length() {
    let (curr, chain) = merged[k]
    let (_, top_chain) = stack[stack.length() - 1]
    if chain != top_chain {
      while stack.length() > 1 {
        let (s1, _) = stack.remove(stack.length() - 1)
        let (s2, _) = stack[stack.length() - 1]
        triangles.push((s2, s1, curr))
      }
      stack.clear()
      stack.push(merged[k - 1])
      stack.push(merged[k])
    } else {
      let mut keep_going = true
      while stack.length() > 1 && keep_going {
        let (s1, _) = stack[stack.length() - 1]
        let (s2, _) = stack[stack.length() - 2]
        let cross = (poly[s1].x() - poly[s2].x()) *
          (poly[curr].y() - poly[s2].y()) -
          (poly[s1].y() - poly[s2].y()) * (poly[curr].x() - poly[s2].x())
        if (chain == 0 && cross > 0.0) || (chain == 1 && cross < 0.0) {
          ignore(stack.remove(stack.length() - 1))
          triangles.push((s2, s1, curr))
        } else {
          keep_going = false
        }
      }
      stack.push(merged[k])
    }
  }
  triangles
}

///|
/// Count triangles in monotone triangulation. / 单调三角剖分中三角形数量。
pub fn monotone_triangulate_count(poly : Array[@core.Point2D]) -> Int32 {
  triangulate_monotone(poly).length()
}
