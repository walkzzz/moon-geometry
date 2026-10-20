///|
/// # GPU Geometry | GPU 几何
/// GPU-friendly geometry operations. / GPU 友好几何操作。
///|
pub fn morton_code_2d(x : Int, y : Int) -> Int {
  let mut result = 0
  for i in 0..<16 {
    result = result | (((x >> i) & 1) << (2 * i))
    result = result | (((y >> i) & 1) << (2 * i + 1))
  }
  result
}
///|
pub fn hilbert_d2xy(d : Int, i : Int) -> (Int, Int) {
  let mut x = 0; let mut y = 0
  let mut t = i
  for s in 1..<d {
    let rx = 1 & (t / 2)
    let ry = 1 & (t ^ rx)
    if ry == 0 {
      if rx == 1 { x = (1 << s) - 1 - x; y = (1 << s) - 1 - y }
      let tmp = x; x = y; y = tmp
    }
    x += rx << s
    y += ry << s
    t /= 4
  }
  (x, y)
}
///|
pub fn vertex_cache_optimize(indices : Array[Int], cache_size_ : Int) -> Array[Int] {
  indices
}
///|
pub fn meshlet_bounds(verts : Array[(Double, Double, Double)]) -> ((Double, Double, Double), Double) {
  let mut cx = 0.0; let mut cy = 0.0; let mut cz = 0.0
  let n = verts.length().to_double()
  for i in 0..<verts.length() {
    cx += verts[i].0; cy += verts[i].1; cz += verts[i].2
  }
  if n > 0.0 { cx /= n; cy /= n; cz /= n }
  let mut max_r = 0.0
  for i in 0..<verts.length() {
    let dx = verts[i].0 - cx; let dy = verts[i].1 - cy; let dz = verts[i].2 - cz
    let d = (dx * dx + dy * dy + dz * dz).sqrt()
    if d > max_r { max_r = d }
  }
  ((cx, cy, cz), max_r)
}
