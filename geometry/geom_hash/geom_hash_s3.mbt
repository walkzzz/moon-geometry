///| Compute a quantized hash key from 2D coordinates. / 由二维坐标计算量化哈希键。
pub fn hash_key(x : Double, y : Double, bins : Int) -> Int {
  let v = ((x + y) * bins.to_double()).floor().to_int()
  if v < 0 { 0 } else if v >= bins { bins - 1 } else { v }
}
