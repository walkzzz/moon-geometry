///|
/// Compose two homographies (self after other). / 组合两个单应矩阵（先 other 后 self）。
pub impl @core.Composable for Homography with fn compose(self, other) {
  {
    h00: self.h00 * other.h00 + self.h01 * other.h10 + self.h02 * other.h20,
    h01: self.h00 * other.h01 + self.h01 * other.h11 + self.h02 * other.h21,
    h02: self.h00 * other.h02 + self.h01 * other.h12 + self.h02 * other.h22,
    h10: self.h10 * other.h00 + self.h11 * other.h10 + self.h12 * other.h20,
    h11: self.h10 * other.h01 + self.h11 * other.h11 + self.h12 * other.h21,
    h12: self.h10 * other.h02 + self.h11 * other.h12 + self.h12 * other.h22,
    h20: self.h20 * other.h00 + self.h21 * other.h10 + self.h22 * other.h20,
    h21: self.h20 * other.h01 + self.h21 * other.h11 + self.h22 * other.h21,
    h22: self.h20 * other.h02 + self.h21 * other.h12 + self.h22 * other.h22,
  }
}

///|
pub extend Homography with @core.Composable::{compose}
