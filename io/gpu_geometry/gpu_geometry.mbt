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