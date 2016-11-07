# Generating Benchmarking Datasets for Anomaly Detection

This script takes a list of datasets and transforms them into a suite
of ground-truthed benchmark datasets for anomaly detection as laid out
in the ODD paper
http://www.outlier-analytics.org/odd13kdd/papers/emmott,das,dietterich,fern,wong.pdf. It depends on the library "make-binary". (See [readme](../make-binary/readme.md))

These output datasets vary along the dimensions point difficulty, relative
frequency of anomalies, and clusteredness.

For each dataset id in the list, this script: 

- Transforms the dataset into a binary classification using `make-binary`.

- Seperates out the "normal" rows.

- Point difficulty: Models the dataset with a logistic regression, and
  uses a batchprediciton to labels each row with the probability of it
  being labeled "normal". The rows labeled "anomalous" are sorted into
  one of four datasets based on this probability. ("Easy" (0, 0.1666),
  "medium" [0.1666, 0.3333), "hard" [0.3333, 0.5), "very hard" [0.5,
  1))

- Clusteredness: For each of the point difficulty datasets, an anomaly
  detector (isolation forest) and batchprediction are used to label
  each row with an anomaly score. This is a rough gauge for
  clusteredness, and new datasets are created from the top and bottom
  20% anomaly scores. The actual clusteredness is calculated by
  finding the ratio of the variance of the "normal" rows to the
  variance of the new dataset (which has N rows). Actual clusteredness
  is sorted into one of six categories: high scatter (0, 0.25), medium
  scatter [0.25, 0.5), low scatter [0.5, 1), low clusteredness [1,2),
  medium clusteredness [2, 4), and high clusteredness [4, infinity).

- Frequency: As long as the dataset has at least 10 rows, a new
  dataset (which has K rows) is created through a sample rate set to
  create the goal frequency. Goal frequencies are 0.001, 0.005, 0.01,
  0.05, and 0.1.

- If enough rows are availible, ten replicate datasets are created at
  each combination of difficulty, clusteredness, and frequency. A
  maxiumum of N/K replicates are created.

- These datasets are merged back with the "normal" rows.

- The final output is a list of maps with keys "difficulty",
  "frequency", "variance", and "resource" (the resource id of the
  final merged dataset).

If `delete-resources` is true, it deletes all intermediate resources.