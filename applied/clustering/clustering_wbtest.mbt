///|
test "kmeans basic" {
  let pts = [
    (0.0, 0.0),
    (0.5, 0.0),
    (0.0, 0.5),
    (5.0, 5.0),
    (5.5, 5.0),
    (5.0, 5.5),
  ]
  let labels = kmeans(pts, 2, 100)
  assert_eq(labels.length(), 6)
  assert_true(labels[0] != labels[3])
}

///|
test "dbscan basic" {
  let pts = [
    (0.0, 0.0),
    (0.5, 0.0),
    (0.0, 0.5),
    (5.0, 5.0),
    (5.5, 5.0),
    (5.0, 5.5),
  ]
  let labels = dbscan(pts, 1.0, 2)
  assert_eq(labels.length(), 6)
}

///|
test "cluster_centroids basic" {
  let pts = [(0.0, 0.0), (2.0, 0.0), (10.0, 10.0), (12.0, 10.0)]
  let labels = [0, 0, 1, 1]
  let centroids = cluster_centroids(pts, labels, 2)
  let (cx0, _) = centroids[0]
  assert_true((cx0 - 1.0).abs() < 0.001)
  let (cx1, _) = centroids[1]
  assert_true((cx1 - 11.0).abs() < 0.001)
}
