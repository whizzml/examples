# SMACdown example: best parameters for an ensemble

Given an input dataset, we use SMACdown to find the best parameters
for creating an ensemble from that dataset.

The script uses as inputs, beside the identifier of the dataset, the
evaluation metric we maximize (defaulting to average_phi), the
objective field and a string used as a prefix when naming intermediate
resources created by the workflow.  Since most of the time we will
want to simply delete all intermediate resources, we use an empty
prefix to indicate it, and use the empty string as the default.
