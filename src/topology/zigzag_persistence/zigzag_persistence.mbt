///|
/// # Zigzag Persistence
/// # 之字持久性
///
/// Zigzag persistence for sequences of complexes with inclusions both ways.
/// 双向包含序列的之字持久性。

///|
pub fn zigzag_intervals(births : Array[Int], deaths : Array[Int]) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  let n = if births.length() < deaths.length() { births.length() } else { deaths.length() }
  for i in 0..<n {
    result.push((births[i], deaths[i]))
  }
  result
}

///|
pub fn zigzag_length(interval : (Int, Int)) -> Int {
  let (b, d) = interval
  d - b
}

///|
pub fn zigzag_max_length(intervals : Array[(Int, Int)]) -> Int {
  let mut max_l = 0
  for i in 0..<intervals.length() {
    let l = zigzag_length(intervals[i])
    if l > max_l { max_l = l }
  }
  max_l
}

///|
pub fn zigzag_total_betti(intervals : Array[(Int, Int)]) -> Int {
  intervals.length()
}
