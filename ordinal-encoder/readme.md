# Encode categorical fields using ordinal encoding

This script takes as inputs a dataset, and optionally a list of categorical fields and mappings from field classes to integers.  It then creates a new dataset, with additional fields containing ordinal encodings of the categorical fields.

Ordinal encoding uses a single column of integers to represent field classes. If classes have a known order (such as Like, Like Somewhat, Neutral, Dislike, and Somewhat Dislike), the integer mapping can be supplied; otherwise, integers are assigned at random.

