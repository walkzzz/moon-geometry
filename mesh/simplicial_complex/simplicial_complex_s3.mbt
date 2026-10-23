///|
pub fn is_valid_complex(sc : SimplicialComplex) -> Bool {
  for i in 0..<sc.simplices.length() {
    let s = sc.simplices[i]
    let seen : Array[Int32] = []
    for j in 0..<s.length() {
      for k in 0..<seen.length() {
        if s[j] == seen[k] {
          return false
        }
      }
      seen.push(s[j])
    }
  }
  true
}
