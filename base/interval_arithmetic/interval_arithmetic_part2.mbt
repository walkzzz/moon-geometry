///|
pub fn interval_mul(a : Interval, b : Interval) -> Interval {
  let p1 = a.lo * b.lo
  let p2 = a.lo * b.hi
  let p3 = a.hi * b.lo
  let p4 = a.hi * b.hi
  let lo = if p1 <= p2 && p1 <= p3 && p1 <= p4 {
    p1
  } else if p2 <= p3 && p2 <= p4 {
    p2
  } else if p3 <= p4 {
    p3
  } else {
    p4
  }
  let hi = if p1 >= p2 && p1 >= p3 && p1 >= p4 {
    p1
  } else if p2 >= p3 && p2 >= p4 {
    p2
  } else if p3 >= p4 {
    p3
  } else {
    p4
  }
  { lo, hi, }
}
