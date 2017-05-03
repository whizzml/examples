# Stacked Predictions

This script takes two datasets, a training and a holdout, and builds
several predictors using the training dataset. These include a model,
a bagging ensemble, a random decision forest, a boosted tree, and a
logistic regression (for categorical datasets).  The script then runs
a batch prediction on the holdout dataset for each predictor, and
finally appends the holdout dataset with the prediction of each
predictor and the most popular prediciton over all.

# Inputs

- A training dataset to build the predictors
- A holdout dataset to predict


# Outputs

- An appened dataset with all the prediction and the most popular
  prediciton last
