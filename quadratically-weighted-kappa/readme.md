# Offset predictions to minimize Quadratically Weighted Kappa

This pair of scripts allows you to compute an offset table for a
training dataset of predictions that reduces the quadratically weighted
kappa (Cohen's kappa) statistic for the prediction dataset. You can then
use this offset table to reduce the QWK statistics for a new batch
prediction. 

Given a new predictor of any type, you must first compute an offset
training dataset by computing a batch prediction for a second
training dataset distinct from the dataset used to train the predictor.
You then use the [optimize-offsets](./optimize-offsets) script
to compute a table of offsets that minimize the quadratically weighted
kappa statistic for the offset training dataset.

One you have derived the offset table for the predictor, you can then
the use the [batch-apply-offsets](batch-apply-offsets) script to apply
the offsets to any batch prediction you generate with the same
predictor.

## Installation

Please see [the top-level readme](../readme.md) for detailed installation
instructions.
