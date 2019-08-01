# AutoML Library

This `WhizzML library` contains some functions that will abstract away
the complexity of the Automated Machine Learning from the main
[script](../automl-script)

![BigML AutoML Library](../res/automl-lib.png)

The code from the library is divided into different blocks:
- **Utils**: Common utilities that are used in the library and in the
  script
- **Checks**: Functions to check execution inputs
- **Unsupervised Generation**: Functions to create unsupervised models
  from your datasets
- **Feature Generation**: Functions to create new features from the
  created unsupervised models
- **Feature Selection**: Functions to obtain, automatically, the most
  important fields in a dataset. **Recursive Feature Elimination**
  algorithm is used.
- **Model Selection**: Functions to obtain, automatically, the best
  supervised models and their hyperparameters.

Private functions, that are only used inside the library, starts with
 `_`, to differentiate them from public functions that are invoked
from the script.
