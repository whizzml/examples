# Model or ensemble?

A very simple script in which we decide whether it's better to use a
model or an ensemble for making predictions by creating both (given an
input source) and evaluating the results, chossing the one with best
f-1 measure in its evaluation.

Given an input dataset:

- Create a dataset with the input source.
- Split it into training and test parts (80%/20%).
- Create a model using the training dataset.
- Create an ensemble using the training dataset.
- Evaluate both the model and the ensemble using the test dataset.
- Compare their evaluations and choose the best.
