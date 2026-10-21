///| Interval Arithmetic | 区间算术
///| Interval operations for robust geometric computation
///| 区间运算用于鲁棒几何计算

pub struct GeoInterval {
  center : Double
  radius : Double
} derive(Debug)

///|
pub extend GeoInterval with @moonbitlang/core/debug.Debug::{to_repr}

///| Create interval with given center and radius. / 以给定中心和半径创建区间。
pub fn GeoInterval::new(center : Double, radius : Double) -> GeoInterval {
  { center, radius }
}

///| Add two intervals. / 两个区间相加。
pub fn GeoInterval::add(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  { center: self.center + other.center, radius: self.radius + other.radius }
}

///| Subtract interval other from self. / 区间 self 减去区间 other。
pub fn GeoInterval::sub(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  { center: self.center - other.center, radius: self.radius + other.radius }
}

///| Multiply two intervals. / 两个区间相乘。
pub fn GeoInterval::mul(self : GeoInterval, other : GeoInterval) -> GeoInterval {
  let c = self.center * other.center
  let r = self.radius * other.center.abs() + other.radius * self.center.abs() + self.radius * other.radius
  { center: c, radius: r }
}

///| Test if value lies within the interval. / 测试值是否落在区间内。
pub fn GeoInterval::contains(self : GeoInterval, val : Double) -> Bool {
  (val - self.center).abs() <= self.radius
}

///| Test if two intervals overlap. / 测试两个区间是否重叠。
pub fn GeoInterval::overlaps(self : GeoInterval, other : GeoInterval) -> Bool {
  (self.center - other.center).abs() <= self.radius + other.radius
}
