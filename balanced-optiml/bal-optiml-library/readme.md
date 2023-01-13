# Balanced OptiML Library

This `WhizzML library` contains some functions that will abstract away
the complexity of the Balanced OptiML script from the main
[script](../bal-optiml-script)

Private functions, that are only used inside the library, start with
 `_`, to differentiate them from public functions that are invoked
 from the script. In particular:

 - rare-stratified-split-fn: Splits the dataset in a pair of training/test
   datasets keeping the proportion of instances between the rare and common
   classes
 - undersample-fn: Creates a list of datasets by keeping all the instances
   of the rare class and sampling some instances of the common class. The
   user provides a list of numbers to define the sampling proportion. For
   instance, providing [1, 5] will generate two datasets, one with the same
   number of instances for both classes ([1: 1] proportion)
   and another where the common class will be represented by 5 times the
   number of instances in the rare class ([1: 5] proportion).
