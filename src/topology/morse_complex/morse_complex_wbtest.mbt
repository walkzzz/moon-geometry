test "morse_complex empty" {
  let mc = morse_complex([], [])
  assert_eq(critical_point_count(mc), 0)
}

test "morse_complex single point" {
  let mc = morse_complex([1.0], [])
  assert_true(critical_point_count(mc) >= 1)
}

test "morse_complex two points" {
  let values = [0.0, 1.0]
  let edges = [(0, 1)]
  let mc = morse_complex(values, edges)
  assert_true(critical_point_count(mc) >= 2)
}

test "morse_complex path" {
  let values = [0.0, 1.0, 2.0, 1.0, 0.0]
  let edges = [(0, 1), (1, 2), (2, 3), (3, 4)]
  let mc = morse_complex(values, edges)
  assert_true(critical_point_count(mc) >= 2)
}

test "stable_manifold" {
  let values = [0.0, 1.0, 2.0]
  let edges = [(0, 1), (1, 2)]
  let mc = morse_complex(values, edges)
  let sm = stable_manifold(mc, 0)
  assert_true(sm.simplex_count() >= 1)
}

test "unstable_manifold" {
  let values = [0.0, 1.0, 2.0]
  let edges = [(0, 1), (1, 2)]
  let mc = morse_complex(values, edges)
  let um = unstable_manifold(mc, 2)
  assert_true(um.simplex_count() >= 1)
}

test "MorseCell::new" {
  let cell = MorseCell::new(0, 1, [0, 1, 2])
  assert_eq(cell.critical_idx, 0)
  assert_eq(cell.dimension, 1)
  assert_eq(cell.simplex_count(), 3)
}

test "MorseComplex::new" {
  let mc = MorseComplex::new()
  assert_eq(mc.critical_count(), 0)
}

test "stable_manifold invalid" {
  let mc = morse_complex([0.0, 1.0], [(0, 1)])
  let sm = stable_manifold(mc, 99)
  assert_eq(sm.critical_idx, 99)
  assert_eq(sm.simplex_count(), 0)
}