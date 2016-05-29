# SMACdown example: best parameters for an ensemble

Given an input dataset, we use SMACdown to find the best parameters
for creating an ensemble from that dataset.

The script uses as inputs, beside the identifier of the dataset, the
evaluation metric we maximize (defaulting to average_phi), the
objective field and a string used as a prefix when naming intermediate
resources created by the workflow.

This workflow will generate a big number of auxiliary resources when
executed.  To instruct the script to delete all of them before
finishing set the `delete-resources` execution input parameter to
`true`.
