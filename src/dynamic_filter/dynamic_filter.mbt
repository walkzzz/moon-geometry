///| Dynamic Filtering | 动态过滤
///| Runtime interval bounds for adaptive predicate evaluation
///| 运行时间区间界用于自适应谓词求值

pub struct Interval {
  lo : Double
  hi : Double
} derive(Show)

pub fn Interval::new(lo : Double, hi : Double) -> Interval {
  { lo, hi }
}

pub fn Interval::add(self : Interval, other : Interval) -> Interval {
  { lo: self.lo + other.lo, hi: self.hi + other.hi }
}

pub fn Interval::mul(self : Interval, other : Interval) -> Interval {
  let p1 = self.lo * other.lo
  let p2 = self.lo * other.hi
  let p3 = self.hi * other.lo
  let p4 = self.hi * other.hi
  let lo = p1
  let lo2 = if p2 < lo { p2 } else { lo }
  let lo3 = if p3 < lo2 { p3 } else { lo2 }
  let lo4 = if p4 < lo3 { p4 } else { lo3 }
  let hi = p1
  let hi2 = if p2 > hi { p2 } else { hi }
  let hi3 = if p3 > hi2 { p3 } else { hi2 }
  let hi4 = if p4 > hi3 { p4 } else { hi3 }
  { lo: lo4, hi: hi4 }
}

pub fn Interval::width(self : Interval) -> Double {
  self.hi - self.lo
}

pub fn Interval::contains_zero(self : Interval) -> Bool {
  self.lo <= 0.0 && self.hi >= 0.0
}
