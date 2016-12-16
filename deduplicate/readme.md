# Removing duplicated keys from an ordered dataset, at random

This simple script takes a dataset identifier and the name or
identifier of one of its fields, and creates a new one that contains
only one row for each different value of that field, on the assumption
that all duplicated values of the key field are contiguous.

The scripts selects one of the rows at random, with two filters in a
row (using Flatline) that, essentially, implement reservoir sampling
for each of the row groups.

More concretely, we first perfom a filter with the following
expression:

    (let (id (f "key")
          n (count (cond-window "key" (= id (f "key")))))
      (= 0 (rand-int n)))

where "key" is the name of our key field. In the expression above, `n`
is the number of rows below the current one with the same value for
the "key" field, and we are selecting the current row with probability
`1/n`.  In a regular reservoir sample, one would stop collecting rows
once the first one is selected, but the Flatline filter would go on
for all rows, so there's a pretty good chance that more than one row
with the same key remains in the filtered dataset.  To get our final
result, we just keep the first row for each key in the filtered
dataset, which is easily accomplished via the Flatline filter

    (!= (f "key") (f "key" -1))

So the WhizzML script's job is mostly trivial: generate the Flatline
expression, request a dataset for each filter in succession, and
delete the intermediate dataset.
