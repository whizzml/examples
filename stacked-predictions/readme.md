# Stacked Predictions

This script takes two datasets, a training and a holdout, a list of
predictors to be built, and a list of parameters to pass to them. (By
default they are a model, a bagging ensemble, a random decision
forest, a boosted ensemble, and a logistic regression.)  The script
then runs a batch prediction on the holdout dataset for each
predictor, and finally appends the holdout dataset with the prediction
of each predictor and the most popular prediciton over all.

# Inputs

- A training dataset to build the predictors
- A holdout dataset to predict

- A list of predictors to build. Possible values include "model",
  "ensemble", "logisticregression", and "lr". The type of ensemble
  created is dependent on the parameters passed by the parameters
  list. The default is a model, a bagging ensemble, a random decision
  forest, a boosted ensemble, and a logistic regression.

- A list of parameters to pass to your predictors. The default is the
  default BigML settings for the default predictors above


# Outputs

- A copy of the original dataset appended with all the prediction and
  the most popular prediction last
