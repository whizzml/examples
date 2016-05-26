# Filter a dataset on row population percentange

Script to remove rows from a dataset that are less than `n` percent populated.
Returns a new dataset with the specified filter applied.

Given an input dataset:

- Retrieves information about each field.
- Determines whether or not each field is greater than `n` percent populated.
- Creates a list of field names that do not meet the criteria.
- Creates and returns a new dataset, excluding the fields that did not meet the criteria.

