# Batch association sets

In this package you'll find a script that generates a batch association sets
dataset. The association discovery model is used to add new features to the
user-provided dataset. Each rule will be used to create a new feature that
contains whether the row information fits into the rule. The user can select
the number of rules to be added.

The **inputs** for the script are:

* `dataset-id`: (dataset-id) Dataset ID for the dataset to be extended
* `association-id`: (association-id) Association ID to be used
* `dataset-name`: (string) Name for the generated dataset.
* `rule-ids`: (list) **optional** List of rule IDs to be included in the
              new dataset (default = [], including all available rules)
* `match`: (string) **optional** Condition to be met by the new features
           (rule, antecedent, consequent) (default = rule, rows that match
           both the antecedent and the consequent)

The **outputs** for the script are:
* `extended-dataset-id`: (dataset-id) Dataset ID for the extended dataset
