///|
/// Compute Betti numbers from a barcode at a given threshold. / 由条形码在给定阈值处计算 Betti 数。
pub fn betti_from_barcode(
  barcodes : Array[Barcode],
  threshold : Double,
) -> Array[Int] {
  let betti = Array::make(3, 0)
  for b in barcodes {
    if b.birth <= threshold + 0.0000000001 &&
      (b.death > threshold || b.is_infinite()) {
      if b.dimension >= 0 && b.dimension < 3 {
        betti[b.dimension] += 1
      }
    }
  }
  betti
}