///|
/// Count catchment basin cells for each label. / 统计各标签的汇水盆地像元数。
pub fn basin_cell_counts(r : WatershedResult) -> Array[(Int, Int)] {
  // Collect unique labels
  let unique_labels : Array[Int] = []
  for label in r.labels {
    if label != 0 {
      let mut found = false
      for ul in unique_labels {
        if ul == label {
          found = true
          break
        }
      }
      if !found {
        unique_labels.push(label)
      }
    }
  }
  let result : Array[(Int, Int)] = []
  for ul in unique_labels {
    let mut count = 0
    for label in r.labels {
      if label == ul {
        count += 1
      }
    }
    result.push((ul, count))
  }
  result
}
