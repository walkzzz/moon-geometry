///|
/// Number of points in tree. / 范围树中的点数。
pub fn range_tree_size(tree : RangeTree) -> Int {
  @range_tree.range_tree_size(tree)
}

// ---------------------------------------------------------------------------
// sort_search: sorted array search / 有序数组搜索
// ---------------------------------------------------------------------------


///|
/// Binary search. / 二分查找。
pub fn binary_search(arr : Array[Double], target : Double) -> Int? {
  @sort_search.binary_search(arr, target)
}


///|
/// Lower bound. / 下界。
pub fn lower_bound(arr : Array[Double], target : Double) -> Int {
  @sort_search.lower_bound(arr, target)
}


///|
/// Upper bound. / 上界。
pub fn upper_bound(arr : Array[Double], target : Double) -> Int {
  @sort_search.upper_bound(arr, target)
}


///|
/// Remove duplicates from sorted array. / 去重有序数组。
pub fn unique_sorted(arr : Array[Double]) -> Array[Double] {
  @sort_search.unique_sorted(arr)
}


///|
/// Check if array is sorted. / 检查数组是否有序。
pub fn is_sorted(arr : Array[Double]) -> Bool {
  @sort_search.is_sorted(arr)
}
