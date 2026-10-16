test "tsne_similarity zero" {
  let s = tsne_similarity(0.0, 1.0)
  assert_true(s > 0.99 && s < 1.01)
}
test "umap_cross_entropy same" {
  let ce = umap_cross_entropy(0.5, 0.5)
  assert_true(ce.abs() < 0.001)
}
test "kl_divergence same" {
  let kl = kl_divergence([0.5, 0.5], [0.5, 0.5])
  assert_true(kl.abs() < 0.001)
}
