# Use items as features

This script implements a dataset generator that, given an input
dataset and an item field in it, creates a new dataset with a column
for each of the items in the field.  Each column is an indicator of
whether the value of the field in the instance contains the item
denoted the corresponding column.

Generation of the new columns is accomplished via Flatline.  This
WhizzML script needs only to construct the adequate Flatline string
and send it to BigML's dataset service.  The expression is simple: a
list of checks, one for each possible item, using the Flatline
built-in
[contains-items?](https://github.com/jaor/flatline/blob/master/user-manual.md#items-and-itemsets).
For example, if the items fields is called "field0", its possible
items are "A", "B" or "C" and the values of the columns are to be
"YES"/"NO", the Flatline expressions for each new field would be:

      (if (contains-items? "field0" "A") "YES" "NO")
      (if (contains-items? "field0" "B") "YES" "NO")
      (if (contains-items? "field0" "C") "YES" "NO")

Generating the above Flatline string in WhizzML from input variables
is easily accomplished via WhizzML's built-in function `flatline`:

       (let (yes "YES"
             no "NO"
             items "A"
             field "field0")
         (flatline "(if (contains-items? {{field}} {{item}}) {{yes}} {{no}})"))

The only thing left to do for the WhizzML script is assigning names to
each of the new fields and composing the dataset creation request that
is sent to BigML.
