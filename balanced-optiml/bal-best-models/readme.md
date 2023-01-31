# Balanced Best Models

This script extracts the best models found in an existing Balanced OptiML
script execution. The Balanced OptiML script creates undersampled datasets to
balance an imbalanced dataset with a minority positive class. Builds
OptiMLs for them to provide a Balanced Automated search for the best model. You
should first execute such a script to be able to use the Balanced Best Models
script.

The Inputs and Outputs of a Balanced OptiML script are described in its
[readme file](../bal-optiml-script) and contain information about the original
unbalanced dataset, the positive class, the best model found by applying OptiML
to the unbalanced train dataset, the best models found by applying OptiML to
a set of undersampled datasets and the unbalanced test dataset to be used
for their final evaluation.

The Balanced Best Models script will use the unbalanced Test Dataset to compare
the best model for the unbalanced Train Dataset to the best models for the
undersampled versions of the Train Dataset (as found by their corresponding
OptiMLs). The sorted list of Best available Models will be produced.

## Inputs

- The execution ID of the Balanced OptiML script execution.

## Output

- The best unbalanced model built on the entire Train Dataset.

- The best models for the undersamples built from the Train Dataset.

- The list of models whose validation metrics are better than the one achieved
  by the best unbalanced model.

- The final Evaluation of the best unbalanced model using the Test Dataset.

- The final Evaluations of the list of best udersampled models uisng the Test
  Dataset.
