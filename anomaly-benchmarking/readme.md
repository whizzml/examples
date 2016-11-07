# Generating Benchmarking Datasets for Anomaly Detection

This package takes a list of datasets and transforms them into a suite
of ground-truthed benchmark datasets for anomaly detection as laid out
in the ODD paper
http://www.outlier-analytics.org/odd13kdd/papers/emmott,das,dietterich,fern,wong.pdf. It
is composed of the script "generate-datasets" and the library
"make-binary". (See readmes:
[generate-datasets](/generate-datasets/readme.md) and
[make-binary](/make-binary/readme.md))

These output datasets vary along the following dimensions:

(a) point difficulty ("easy" (0, 0.1666), "medium" [0.1666, 0.3333),
"hard" [0.3333, 0.5), "very hard" [0.5, 1),

(b) relative frequency of anomalies (0.001, 0.005, 0.01, 0.05, and
0.1), and

(c) clusteredness (high scatter (0, 0.25), medium scatter [0.25, 0.5),
low scatter [0.5, 1), low clusteredness [1,2), medium clusteredness
[2, 4), and high clusteredness [4, infinity)).

# Inputs

- A list of dataset resource ids to be used as the "mother" sets for
  generation.

- A boolean delete-resources to indicate whether intermediate
  resources should be deleted. (Default is true.)

# How to Install

Please see the [top-level readme](../readme.md) for WhizzML package
installation instructions.

