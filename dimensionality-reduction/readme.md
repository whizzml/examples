# Dimensionality reduction using topic models and PCA

This script performs dimensionality reduction on an input dataset
using streaming LDA topic models for text fields, and PCA for the
rest. Two possible workflows are available, controlled by the
`lda-first` boolean input. If `lda-first` is true, the text fields are
replaced by the results of a batch topic distribution, and then PCA is
performed on the resulting dataset. If `lda-first` is false, then a
PCA is fit to the non-text fields, and a topic model is fit to the
text fields. The results from the respective batchprojection and
batchtopicdistribution are then concatenated to form the output
dataset.

## Inputs

- `dataset-id` : Resource identifier for the input dataset.
- `lda-first`: Boolean flag to select between the parallel and series
workflows. Default is true (series).
- `pca-options`: Map of options for the PCA model. Default is an empty map `{}`.
- `lda-options`: Map of options for the topic model. Default is an
  empty map `{}`.
- `batch-projection-options`: Map of options for the batch projection
  model. Default is `{"variance_threshold" 0.8}`.
- `batch-lda-options`: Map of options for the batch topic
  distribution. Default is an empty map `{}`.

## Outputs

- `output-dataset`: Resource identifier for the reduced dataset.
