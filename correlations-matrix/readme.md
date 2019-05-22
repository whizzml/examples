# Correlation matrix CSV

In this package you'll find a script that generates as output a CSV
that contains a matrix of correlation values for the fields in a dataset.
The index used for the
correlation analysis is the `eta squared` (One-Way ANOVA). Given that this
correlation can be computed for numeric and categorical fields, only
the fields that fall into these types are used.

The **inputs** for the script are:

* `dataset-id`: (dataset-id) Dataset ID for the original data
* `fields`: (list) List of fields to be analyzed (default: [])
* `options`:  (map) Arguments for the correlation creation (default: {})
* `correlation-index`: (string) Index to be used (default: "eta_square")

The **outputs** for the script are:
* `correlations-tab`: (list) Corelation values matrix as required for the correlogram
