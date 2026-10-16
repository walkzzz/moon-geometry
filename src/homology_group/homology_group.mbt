///|
/// # Homology Group
/// # 同调群
///
/// Homology group computation with Betti numbers and torsion.
/// 同调群计算，含 Betti 数和挠子。

///|
pub struct HomologyGroup {
  dimension : Int
  rank : Int
  torsion : Array[Int]
}

///|
pub fn HomologyGroup::new(dimension : Int, rank : Int, torsion : Array[Int]) -> HomologyGroup {
  { dimension, rank, torsion }
}

///|
pub fn betti_number(hg : HomologyGroup) -> Int {
  hg.rank
}

///|
pub fn is_trivial(hg : HomologyGroup) -> Bool {
  hg.rank == 0 && hg.torsion.length() == 0
}

///|
pub fn euler_characteristic(groups : Array[HomologyGroup]) -> Int {
  let mut chi = 0
  for i in 0..<groups.length() {
    let g = groups[i]
    if g.dimension % 2 == 0 {
      chi += g.rank
    } else {
      chi -= g.rank
    }
  }
  chi
}

///|
pub fn has_torsion(hg : HomologyGroup) -> Bool {
  hg.torsion.length() > 0
}
