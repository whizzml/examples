# Covariate Shift

A script to determine whether there is a significant data distribution
difference between two datasets. Purpose: maybe a predictive model was trained
on data from 2010. How do we know that the model is still effective with
incoming data in 2015? We can analyze this by inspecting the covariate shift
between the datasets (2010 and 2015).

Given two datasets (one representing "Training" data (e.g., from 2010), one
representing "Production" data (e.g., from 2015):

- Create a new field in each dataset ("Origin") and give it the label either
  "Training" or "Production"
- Combine these two datasets.
- Split the combined dataset into training and test parts (80%/20%).
- Create a model using the training dataset.
- Evaluate the model using the test dataset.
- Look at the phi score of the evaultion
- Repeat these above steps multiple times
- Compute the average of the results

If the average phi score is near 0, then there is no significant change between
the "Training" and "Production" datasets.
