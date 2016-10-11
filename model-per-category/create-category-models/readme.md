# Creating a model per category

- Given an input dataset and one of its categorical fields, create a
  dataset for each field category.
- For each category dataset, create a model of the given kind.
- If the provided field has missing values in the input dataset, a
  model for instances with missing as their "category" will also be
  created.
- Return a map with the list of datasets, models and categories for
  use during predictions.

The lists are returned in a map as the execution's `result`, for later
convenience, as well as in the output named "result".
