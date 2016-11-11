# Making a Dataset Binary

This library takes any dataset and returns it extended by a new field,
"instance type". This field takes the values "normal" or "anomalous"
following the procedure laid out in the ODD paper
http://www.outlier-analytics.org/odd13kdd/papers/emmott,das,dietterich,fern,wong.pdf.

Given a dataset id, the field id of its objective, and the boolean
`delete-resources`, it:

- Determines whether the dataset is a regression, a classification
  with two classes, or a classification with multiple classes.

- If it is a regression, it assigns points greater than the median of
  the regression response as "anomalous" and those lower "normal".

- If it is a two-class classification, it assigns points with a class
  like the first row as "anomalous" and those with the other class
  "normal".

- If it is a multi-class classification, it:

  - Creates evaluation of that dataset using a random forest.  

  - Takes the confusion matrix of that evaluation, and creates a graph
    where the nodes are the classes of the confusion matrix and the
    edges (with ends j and k) have weights equal to the sum of the
    cells [j k] and [k j]. (Note: While the ODD paper uses a confusion
    matrix of probabilities, the BigML confusion matrix gives straight
    counts.)

  - Creates a maximum spanning tree of that graph, thus finding the
    "most-confusable" classes.

  - Two-colors that graph with "normal" and "anomalous".

  - Returns an extended dataset with the new field "instance type",
    determined by the coloring of the class in the old objective
    field.

- If `delete-resources` is true, it deletes all intermediate resources.