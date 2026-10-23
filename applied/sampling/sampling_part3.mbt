///|
/// Halton sequence sampling (low-discrepancy). / Halton 序列采样（低差异）。
pub fn halton_sample(
  base_x : Int,
  base_y : Int,
  n : Int,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 1..=n {
    result.push(@core.Point2D::new(halton(i, base_x), halton(i, base_y)))
  }
  result
}

fn halton(index : Int, base : Int) -> Double {
  let mut f = 1.0
  let mut r = 0.0
  let mut i = index
  while i > 0 {
    f = f / base.to_double()
    r = r + f * (i % base).to_double()
    i = i / base
  }
  r
}