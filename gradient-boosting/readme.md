# Gradient boosting

An implementation of gradient boosting, along the following steps:

- Given the currently predicted class probablilities, compute a
  gradient step that will push those probabilities in the right
  direction
- Learn regression trees to represent this step over the training set
- Make a prediction with each tree
- Sum this prediction with all gradient steps so far to get a set of
  scores for each point in the training data (one score for each
  class)
- Apply the *softmax* to these sums to get a set of class
  probabilities for each point.
- Iterate!

Since the algorithm works by manipulating class probabilities, the
script can only be used when the requested objective field is
categorical.
