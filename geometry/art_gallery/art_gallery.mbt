///|
/// Upper bound on guards needed for an n-vertex polygon: floor(n/3). / n 顶点多边形所需守卫数上界：floor(n/3)。
pub fn art_gallery_guard_count(n : Int32) -> Int32 {
  if n < 3 {
    return 0
  }
  n / 3
}
