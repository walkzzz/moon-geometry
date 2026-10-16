/// |
/// # Packing Algorithms
/// # 装填算法
///
/// Pack circles and rectangles into containers.
/// 将圆形和矩形装入容器。
///
/// ## Complexity: O(n²) for greedy packing
/// ## 复杂度: 贪心装填 O(n²)

/// |
/// Pack circles into a square container using greedy placement.
/// 使用贪心放置将圆形装入方形容器。
///
/// # Arguments / 参数
/// - `radii`: circle radii / 圆半径数组
/// - `container_size`: container side length / 容器边长
///
/// Returns array of (x, y) centers for successfully packed circles, or empty if failed.
/// 返回成功装入的圆心坐标数组，失败则返回空数组。
pub fn pack_circles(
  radii : Array[Double],
  container_size : Double,
) -> Array[(Double, Double)] {
  let positions : Array[(Double, Double)] = []
  for idx in 0..<radii.length() {
    let r = radii[idx]
    let mut placed = false
    let step = container_size / 20.0
    let mut y = r
    while y <= container_size - r && !placed {
      let mut x = r
      while x <= container_size - r && !placed {
        let mut overlap = false
        for j in 0..<positions.length() {
          let (px, py) = positions[j]
          let dx = x - px
          let dy = y - py
          let dist = (dx * dx + dy * dy).sqrt()
          let rj = radii[j]
          if dist < r + rj {
            overlap = true
            break
          }
        }
        if !overlap {
          positions.push((x, y))
          placed = true
        }
        x += step
      }
      y += step
    }
    if !placed {
      return []
    }
  }
  positions
}

/// |
/// Pack rectangles into a bin using first-fit decreasing heuristic.
/// 使用首次适应递减启发式将矩形装入箱子。
///
/// # Arguments / 参数
/// - `rects`: array of (width, height) / 矩形数组
/// - `bin_w`, `bin_h`: bin dimensions / 箱子尺寸
///
/// Returns array of (x, y) positions for placed rectangles, or empty if failed.
/// 返回已放置矩形的位置数组，失败则返回空数组。
pub fn pack_rectangles(
  rects : Array[(Double, Double)],
  bin_w : Double,
  bin_h : Double,
) -> Array[(Double, Double)] {
  let n = rects.length()
  let order : Array[Int] = []
  for i in 0..<n {
    order.push(i)
  }
  for i in 0..<(n - 1) {
    for j in 0..<(n - 1 - i) {
      let (w1, h1) = rects[order[j]]
      let (w2, h2) = rects[order[j + 1]]
      if w1 * h1 < w2 * h2 {
        let tmp = order[j]
        order[j] = order[j + 1]
        order[j + 1] = tmp
      }
    }
  }
  let positions : Array[(Double, Double)] = []
  for k in 0..<n {
    positions.push((0.0, 0.0))
  }
  let mut shelf_y = 0.0
  let mut shelf_h = 0.0
  let mut shelf_x = 0.0
  for k in 0..<n {
    let idx = order[k]
    let (w, h) = rects[idx]
    if w > bin_w || h > bin_h {
      return []
    }
    if shelf_x + w > bin_w {
      shelf_y += shelf_h
      shelf_x = 0.0
      shelf_h = 0.0
    }
    if shelf_y + h > bin_h {
      return []
    }
    positions[idx] = (shelf_x, shelf_y)
    shelf_x += w
    if h > shelf_h {
      shelf_h = h
    }
  }
  positions
}

/// |
/// Compute packing density (fraction of container area used).
/// 计算装填密度（使用的容器面积比例）。
///
/// # Arguments / 参数
/// - `radii`: circle radii / 圆半径数组
/// - `container_size`: container side length / 容器边长
pub fn packing_density(
  radii : Array[Double],
  container_size : Double,
) -> Double {
  let mut total_area = 0.0
  for r in radii {
    total_area += 3.14159265358979323846 * r * r
  }
  total_area / (container_size * container_size)
}