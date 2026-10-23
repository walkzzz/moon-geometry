///|
/// # Big Rational Number
/// # 大有理数
///
/// Exact rational arithmetic for robust geometric computation.
/// 精确有理数算术，用于鲁棒几何计算。

///|
pub struct Rational {
  num : Int32
  den : Int32
}

///|
pub fn Rational::new(num : Int32, den : Int32) -> Rational {
  if den == 0 {
    { num: 0, den: 1, }
  } else {
    { num, den, }
  }
}

///|
pub fn rational_add(a : Rational, b : Rational) -> Rational {
  { num: a.num * b.den + b.num * a.den, den: a.den * b.den, }
}

///|
pub fn rational_mul(a : Rational, b : Rational) -> Rational {
  { num: a.num * b.num, den: a.den * b.den, }
}

///|
pub fn rational_to_double(r : Rational) -> Double {
  r.num.to_double() / r.den.to_double()
}

///|
pub fn rational_equal(a : Rational, b : Rational) -> Bool {
  a.num * b.den == b.num * a.den
}

///|
pub fn rational_sub(a : Rational, b : Rational) -> Rational {
  { num: a.num * b.den - b.num * a.den, den: a.den * b.den, }
}
