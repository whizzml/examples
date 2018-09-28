# Creating a model per item

- Provide as input a dataset ID, an items field name, a model kind and
  the model configuration options.
- Uses the `items-to-features` script to generate a dataset with one additional
  binary field per item.
- Creates a model of the given kind per item by selecting the item field and
  deselecting the rest of items fields.
- Returns a map with the list of items and models to be used in predictions.

The lists are returned in a map as the execution's `result`, for later
convenience, as well as in the output named "result".
