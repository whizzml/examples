# Examples of WhizzML scripts and libraries

Each script or library is in a directory in this folder.  For each one
you will always find a readme explaining what's its purpose and usage,
the actual whizzml code in a `.whizzml` file, and the JSON metadata
for the associated BigML resource.

By convention, when the artifact is a library, the files are called
`library.whizzml` and `metadata.json`, while for a script we use
`script.whizzml` and `metadata.json`.

## Examples

- `remove-anomailes` Using Flatline and an anomaly detector, remove
  from an input dataset its anomalous rows.
- `find-neighbors`  Using cluster distances as a metric, find
  instances in a dataset close to a given row.
- `stacked-generalization` Simple
  [stacking](https://en.wikipedia.org/wiki/Ensemble_learning#Stacking)
  using decision tree, ensembles and logistic regression.
