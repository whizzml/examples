# Evaluation of category models

This script uses the result of
executing [Create category models](../create-category-models) to
evaluate the overall models performance, using an input test dataset.

The final result of the script is a map containing evaluation metrics
computed by averaging evaluations over the populations of the forced
initial split.  For classification models these metrics include the
accuracy and average (over all categories) precision, recall and
f-measure.  For regressions, you'll find the mean absolute and squared
errors and r squared.  The result map contains also a list of the
evaluations for submodels after the initial split.

See also [the package README](../readme.md).
