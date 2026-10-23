///|
pub fn hilbert_d2xy(d : Int32, i : Int32) -> (Int32, Int32) {
  let mut x = 0
  let mut y = 0
  let mut t = i
  for s in 1..<d {
    let rx = 1 & (t / 2)
    let ry = 1 & (t ^ rx)
    if ry == 0 {
      if rx == 1 {
        x = (1 << s) - 1 - x
        y = (1 << s) - 1 - y
      }
      let tmp = x
      x = y
      y = tmp
    }
    x += rx << s
    y += ry << s
    t /= 4
  }
  (x, y)
}
