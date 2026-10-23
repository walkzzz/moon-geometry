///|
/// Triangulate a y-monotone polygon using stack-based algorithm. / 使用栈算法三角剖分 y-单调多边形。
pub fn triangulate_monotone(
  poly : Array[@core.Point2D],
) -> Array[(Int, Int, Int)] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  if n == 3 {
    return [(0, 1, 2)]
  }
  let triangles : Array[(Int, Int, Int)] = []
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
  let left_chain : Array[Int] = []
  let right_chain : Array[Int] = []
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
  let merged : Array[(Int, Int)] = []
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
  let stack : Array[(Int, Int)] = []
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
        let cross = (poly[s1].x() - poly[s2].x()) * (poly[curr].y() - poly[s2].y()) -
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
