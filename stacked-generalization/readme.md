# Stacked generalization

The objective of the functions in this libray is to improve
predictions by modeling the output scores of multiple trained models.

- Create a training and a holdout set
- Create *n* different models on the training set (with some
  difference among them; e.g., single-tree vs. ensemble vs. logistic
  regression)
- Make predictions from those models on the holdout set
- Train a model to predict the class based on the other models' predictions

The example library below implements this algorithm using a decision tree, a random
forest, a bagging ensemble and a logistic regression as the stack of
models.

# Using the stacking library

## To create a stack of models and their metamodel

One just needs to call `(make-stack)` and save the result as one of the
script's outputs:

```
(define stack (make-stack dataset-id))
```

The input of the script will be just the dataset that we want to model.

## To make predictions given the execution

A prediction is made by scoring the input data over the models and then
using those predictions to make a final prediction using the metamodel.
All that is needed is to call `make-stack-prediction` with the appropriate
parameters, extracted from the execution's outputs.  A simple script could look
like this:

```
(define (make-prediction exec-id input-data)
  (let (exec (fetch exec-id)
        stack (nth (head (get-in exec ["execution" "outputs"])) 1)
        models (get stack "models")
        metamodel (get stack "metamodel"))
    (when (get stack "result")
      (try (make-stack-prediction models metamodel {})
           (catch e (log-info "Error: " e) false)))))

(define prediction-id (make-prediction exec-id input-data))
(define prediction (when prediction-id (fetch prediction-id)))
```
