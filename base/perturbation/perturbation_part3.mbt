///|
pub fn sos_compare(a : Double, b : Double, ia : Int, ib : Int) -> Int {
  if a < b { -1 } else if a > b { 1 } else {
    if ia < ib { -1 } else { 1 }
  }
}
