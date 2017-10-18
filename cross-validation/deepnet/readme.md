# Deepnet's k-fold cross-validation

The objective of this script is to perform a k-fold cross validation of a
deepnet built from a dataset. The algorithm:

- Divides the dataset in k parts
- Holds out the data in one of the parts and builds a logistic regression
  with the rest of data
- Evaluates the deepnet with the hold out data
- The second and third steps are repeated with each of the k parts, so that
  k evaluations are generated
- Finally, the evaluation metrics are averaged to provide the cross-validation
  metrics.

The **inputs** for the script are:

* `dataset-id`: (dataset-id) Dataset ID for the training data
* `k-folds`: (integer) Number of folds to split the dataset into (optional,
                       default=5)
* `objective-id`: (string) ID of the objective field for the model (optional)


* `batch-normalization`: (boolean) Whether to scale each numeric field
                         (optional)
* `default-numeric-value`: (string) It accepts any of the following strings
                           to substitute missing numeric values across all
                           the numeric fields in the dataset: "mean", "median",
                           "minimum", "maximum", "zero".(optional)
* `dropout-rate`: (number) A number between 0 and 1 specifying the rate at
                   which to drop weights during training to control
                   overfitting (optional)
* `hidden-layers`: (list) List of maps describing the number and type of
                   layers in the network (other than the output layer, which
                   is determined by the type of learning problem).
                   (optional, default=[])
* `learn-residuals`: (list) Specifies whether alternate layers should learn a
                     representation of the residuals for a given layer
                     rather than the layer itself or not. (optional)
* `learning-rate`: (list) A number between 0 and 1 specifying the learning
                   rate (optional)
* `max-iterations`: (number) A number between 100 and 100000 for the maximum
                    number of gradient steps to take during the
                    optimization. (optional)
* `max-training-time`: (number) The maximum wall-clock training time, in
                       seconds, for which to train the network. (optional)
* `missing-numerics`: (boolean) Sets the deepnet missing_numerics
                                flag (optional)
* `number-of-hidden-layers`: (number) The number of hidden layers to use in
                             the network. If the number is greater than the
                             length of the list of hidden_layers, the list is
                             cycled until the desired number is reached. If
                             the number is smaller than the length of the list
                             of hidden_layers, the list is shortened.
                             (optional)
* `number-of-model-candidates`: (number) An integer specifying the number of
                                models to try during the model search.
                                (optional)
* `search`: (boolean) An integer specifying the number of models to try during
            the model search. (optional)
* `suggest-structure`: (boolean) An alternative to the search technique that
                       is usually a more efficient way to quickly train and
                       iterate deepnets and it can reach similar results.
                       BigML has learned some general rules about what makes
                       one network structure better than another for a given
                       dataset. Given your dataset, BigML will automatically
                       suggest a structure and a set of parameter values that
                       are likely to perform well for your dataset. This option
                       only builds one network. (optional)
* `tree-embedding`: (boolean) An alternative to the search technique that
                    is usually a more efficient way to quickly train and
                    iterate deepnets and it can reach similar results.
                    BigML has learned some general rules about what makes
                    one network structure better than another for a given
                    dataset. Given your dataset, BigML will automatically
                    suggest a structure and a set of parameter values that
                    are likely to perform well for your dataset. This option
                    only builds one network. (optional)
* seed: (string) Seed used in random samplings (optional)


As you can see, most of the inputs are optional. They default to the defaults
in the platform. The `objective-id` will also be inferred from the one in
the dataset if it is not provided.

# Using the deepnet's k-fold cross-validation script

One just needs to call

```
(deepnet-cross-validation dataset-id
                          k-folds
                          objective-id
                          batch_normalization
                          default-numeric-value
                          dropout_rate
                          hidden_layers
                          learn_residuals
                          learning_rate
                          max_iterations
                          max_training_time
                          missing-numerics
                          number_of_hidden_layers
                          number_of_model_candidates
                          search
                          suggest_structure
                          tree_embedding
                          seed)
```

using the previously described inputs.

The **output** of the script will be an `evaluation ID`. This evaluation is a
cross-validation, meaning that its metrics are averages of the k evaluations
created in the cross-validation process.
