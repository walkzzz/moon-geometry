///|
/// # Persistence Image
/// # 持久性图像
///
/// Persistence image: stable vectorized representation of persistence diagrams.
/// 持久性图像：持久性图的稳定向量化表示。

///|
pub fn gaussian_kernel_2d(x : Double, y : Double, mu_x : Double, mu_y : Double, sigma : Double) -> Double {
  let dx = x - mu_x
  let dy = y - mu_y
  let s2 = sigma * sigma
  @math.exp(-(dx * dx + dy * dy) / (2.0 * s2)) / (2.0 * 3.141592653589793 * s2)
}

///|
pub fn persistence_image_pixel(point : @persistence_diagram.PersistencePoint, mu_x : Double, mu_y : Double, sigma : Double, weight : Double) -> Double {
  let x = point.birth
  let y = point.death - point.birth
  weight * gaussian_kernel_2d(x, y, mu_x, mu_y, sigma)
}

///|
pub fn persistence_image_vector(diagram : Array[@persistence_diagram.PersistencePoint], pixels : Array[(Double, Double)], sigma : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<pixels.length() {
    let (px, py) = pixels[i]
    let mut sum = 0.0
    for j in 0..<diagram.length() {
      sum += persistence_image_pixel(diagram[j], px, py, sigma, 1.0)
    }
    result.push(sum)
  }
  result
}

///|
pub fn image_norm(image : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<image.length() {
    sum += image[i] * image[i]
  }
  sum.sqrt()
}
