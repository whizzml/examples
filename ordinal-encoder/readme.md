# Encode categorical fields using ordinal encoding

This script takes as inputs a dataset, and optionally a list of categorical fields and mappings from field classes to integers. It then creates a new dataset, with additional fields containing ordinal encodings of the categorical fields.

Ordinal encoding uses a single column of integers to represent field classes. If classes have a known order (such as Like, Somewhat Like, Neutral, Somewhat Dislike, and Dislike), the integer mapping can be supplied; otherwise, integers are assigned by class count, in descending order (in the case of ties, classes are ordered alphabetically).

Original fields can optionally be removed or marked as non-preferred.

