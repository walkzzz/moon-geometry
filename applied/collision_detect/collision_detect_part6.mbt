///|
/// Broad phase collision detection using AABB sweep and prune. / 宽相碰撞检测（AABB 扫掠修剪）。
///
/// Returns list of potentially colliding pairs. / 返回潜在碰撞对列表。
pub fn broad_phase_aabb(boxes : Array[AABB]) -> Array[CollisionPair] {
  let n = boxes.length()
  let indices : Array[Int] = []
  for i in 0..<n {
    indices.push(i)
  }
  indices.sort_by(fn(a, b) {
    if boxes[a].min_x < boxes[b].min_x {
      -1
    } else if boxes[a].min_x > boxes[b].min_x {
      1
    } else {
      0
    }
  })
  let pairs : Array[CollisionPair] = []
  for i in 0..<n {
    let a = indices[i]
    for j in (i + 1)..<n {
      let b = indices[j]
      if boxes[a].max_x < boxes[b].min_x {
        break
      }
      if aabb_overlap(boxes[a], boxes[b]) {
        pairs.push(CollisionPair::new(a, b))
      }
    }
  }
  pairs
}
