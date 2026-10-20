///| Geometric Algebra | 几何代数
///| Clifford algebra operations: multivectors, blades, rotors
///| Clifford 代数运算：多重向量、blade、旋量

pub struct Multivector {
  scalar : Double
  e1 : Double
  e2 : Double
  e12 : Double
} derive(Debug)

///|
pub extend Multivector with @moonbitlang/core/debug.Debug::{to_repr}

pub fn Multivector::new(scalar : Double, e1 : Double, e2 : Double, e12 : Double) -> Multivector {
  { scalar, e1, e2, e12 }
}

pub fn Multivector::add(self : Multivector, other : Multivector) -> Multivector {
  { scalar: self.scalar + other.scalar, e1: self.e1 + other.e1, e2: self.e2 + other.e2, e12: self.e12 + other.e12 }
}

pub fn Multivector::mul(self : Multivector, other : Multivector) -> Multivector {
  let s = self.scalar * other.scalar - self.e1 * other.e1 - self.e2 * other.e2 - self.e12 * other.e12
  let a1 = self.scalar * other.e1 + self.e1 * other.scalar + self.e2 * other.e12 - self.e12 * other.e2
  let a2 = self.scalar * other.e2 - self.e1 * other.e12 + self.e2 * other.scalar + self.e12 * other.e1
  let a12 = self.scalar * other.e12 + self.e1 * other.e2 - self.e2 * other.e1 + self.e12 * other.scalar
  { scalar: s, e1: a1, e2: a2, e12: a12 }
}

pub fn Multivector::reverse(self : Multivector) -> Multivector {
  { scalar: self.scalar, e1: self.e1, e2: self.e2, e12: -self.e12 }
}

pub fn Multivector::norm(self : Multivector) -> Double {
  (self.scalar * self.scalar + self.e1 * self.e1 + self.e2 * self.e2 + self.e12 * self.e12).sqrt()
}

pub fn rotor(angle : Double) -> Multivector {
  let c = angle * 0.5
  { scalar: @math.cos(c), e1: 0.0, e2: 0.0, e12: @math.sin(c) }
}

pub fn rotate_vector(vx : Double, vy : Double, angle : Double) -> (Double, Double) {
  let r = rotor(angle)
  let v = { scalar: 0.0, e1: vx, e2: vy, e12: 0.0 }
  let rrev = r.reverse()
  let rv = r.mul(v)
  let result = rv.mul(rrev)
  (result.e1, result.e2)
}
