# Balanced OptiML Library

This `WhizzML library` contains some functions that will abstract away
the complexity of the Balanced OptiML script from the main
[script](../bal-optiml-script)

Private functions, that are only used inside the library, start with
 `_`, to differentiate them from public functions that are invoked
 from the script. In particular:

 - positive-stratified-split-fn: Splits the dataset in a pair of training/test
   datasets keeping the proportion of instances between the minority positive
   class and the rest of classes
 - undersample-fn: Creates a list of datasets by keeping all the instances
   of the minority positive class and sampling some instances of the rest
   of classes. The user provides the number of samples to be created,
   the objective field, the positive class and a proportion
   that will determine the ratio of instances that belong to the negative
   classes to the number of instances that belong to the positive class (e.g:
   proportion=2 means that the number of instances that are sampled for the
   negative classes doubles the positive class number of instances).
