/// |
/// # Interval Tree
/// # 区间树
///
/// Interval tree for 1D interval stabbing queries.
/// 用于一维区间刺查的区间树。
///
/// ## Complexity: O(n log n) build, O(log n + k) query
/// ## 复杂度: 构建 O(n log n)，查询 O(log n + k)

/// |
/// Interval entry.
/// 区间条目。
pub struct Interval {
  lo : Double
  hi : Double
  id : Int
}

///| Create a new interval with bounds and id. / 用上下界和 id 创建新区间。
pub fn Interval::new(lo : Double, hi : Double, id : Int) -> Interval {
  { lo, hi, id }
}

/// |
/// Interval tree node.
/// 区间树节点。
pub struct IntervalNode {
  center : Double
  intervals : Array[Interval]
  left : IntervalNode?
  right : IntervalNode?
}

/// |
/// Build an interval tree.
/// 构建区间树。
pub fn interval_tree_build(intervals : Array[Interval]) -> IntervalNode? {
  if intervals.is_empty() {
    return None
  }
  let sorted = intervals.copy()
  sorted.sort_by(fn(a, b) {
    if a.lo < b.lo {
      -1
    } else if a.lo > b.lo {
      1
    } else {
      0
    }
  })
  let mut min_val = sorted[0].lo
  let mut max_val = sorted[0].hi
  for i in 0..<sorted.length() {
    if sorted[i].lo < min_val {
      min_val = sorted[i].lo
    }
    if sorted[i].hi > max_val {
      max_val = sorted[i].hi
    }
  }
  build_impl(sorted, min_val, max_val)
}

/// |
/// Query all intervals containing point x.
/// 查询包含点 x 的所有区间。
pub fn interval_tree_query(node : IntervalNode?, x : Double) -> Array[Interval] {
  let result : Array[Interval] = []
  query_impl(node, x, result)
  result
}

/// |
/// Count intervals in the tree.
/// 计算树中的区间数。
pub fn interval_tree_count(node : IntervalNode?) -> Int {
  match node {
    Some(n) =>
      n.intervals.length() + interval_tree_count(n.left) + interval_tree_count(n.right)
    None => 0
  }
}

fn build_impl(
  intervals : Array[Interval],
  lo : Double,
  hi : Double,
) -> IntervalNode? {
  if intervals.is_empty() {
    return None
  }
  let center = (lo + hi) / 2.0
  let center_intervals : Array[Interval] = []
  let left_intervals : Array[Interval] = []
  let right_intervals : Array[Interval] = []
  for i in 0..<intervals.length() {
    let iv = intervals[i]
    if iv.hi < center {
      left_intervals.push(iv)
    } else if iv.lo > center {
      right_intervals.push(iv)
    } else {
      center_intervals.push(iv)
    }
  }
  center_intervals.sort_by(fn(a, b) {
    if a.lo < b.lo {
      -1
    } else if a.lo > b.lo {
      1
    } else {
      0
    }
  })
  Some({
    center,
    intervals: center_intervals,
    left: build_impl(left_intervals, lo, center),
    right: build_impl(right_intervals, center, hi),
  })
}

fn query_impl(node : IntervalNode?, x : Double, result : Array[Interval]) -> Unit {
  match node {
    Some(n) => {
      if x < n.center {
        for i in 0..<n.intervals.length() {
          if n.intervals[i].lo <= x {
            result.push(n.intervals[i])
          }
        }
        query_impl(n.left, x, result)
      } else if x > n.center {
        for i in 0..<n.intervals.length() {
          if n.intervals[i].hi >= x {
            result.push(n.intervals[i])
          }
        }
        query_impl(n.right, x, result)
      } else {
        for i in 0..<n.intervals.length() {
          result.push(n.intervals[i])
        }
      }
    }
    None => ()
  }
}