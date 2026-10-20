///| Interval Arithmetic | 区间算术
///| Interval operations for robust geometric computation
///| 区间运算用于鲁棒几何计算

pub struct GeoInterval {
  center : Double
  radius : Double
} derive(Debug)

///|
pub extend GeoInterval with @moonbitlang/core/debug.Debug::{to_repr}

pub fn GeoInterval::new(center : Double, radius : Double) -> GeoInterval {
  { center, radius }
}

pub fn GeoInterval::add(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  { center: self.center + other.center, radius: self.radius + other.radius }
}

pub fn GeoInterval::sub(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  { center: self.center - other.center, radius: self.radius + other.radius }
}

pub fn GeoInterval::mul(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  let c = self.center * other.center
  let r = self.radius * other.center.abs() + other.radius * self.center.abs() + self.radius * other.radius
  { center: c, radius: r }
}

pub fn GeoInterval::contains(self : GeoInterval, val : Double) -> Bool {
  (val - self.center).abs() <= self.radius
}

pub fn GeoInterval::overlaps(self : GeoInterval, other : GeoInterval) -> Bool {
  (self.center - other.center).abs() <= self.radius + other.radius
}
