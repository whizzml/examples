# Feature Generation scripts

These WhizzML packages will let the user extend a dataset with new
**auto-generated features**. These features are the result of
applying, automatically, unsupervised models to the dataset.

This is the first part of a **fully automated Machine Learning
pipeline** in BigML. The pipeline will have the following steps:

- **Automated Feature Generation** using these scripts
- **Automated Feature Selection** using one of these scripts:
  - [**Best-First Feature Selection**](https://github.com/whizzml/examples/tree/master/best-first-cv)
  - [**Boruta**](https://github.com/whizzml/examples/tree/master/boruta)
  - [**Recursive Feature Elimination**](https://github.com/whizzml/examples/tree/master/recursive-feature-elimination)
- **Automatic Model Optimization** using [OptiML](https://bigml.com/whatsnew/optiml)

This repository contains two different folders with one WhizzML
package each. You need to execute both in the correct order to
generate the new features. Check the **Execution steps** below.

## Execution steps

### 1. Generating unsupervised models
Firstly, you have to generate all the needed unsupervised models.

For this, check out the first package:
[unsupervisqed-models](./unsupervised-models)

### 2. Extending the dataset
Then, you will have to execute the second script,
[feature-generation](./feature-generation), passing to it a reference
of the execution you did in the **Step 1**. It will generate the
extended dataset with new auto-generated features.
