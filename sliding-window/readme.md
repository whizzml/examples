# Sliding window transformation for time series learning

This script applies a simple transformation to a dataset in order to
cast time series forecasting as a supervised learning problem.

The input dataset should include one or more time series as numeric
fields. For each numeric field in the input, the script generates
additional numeric fields containing row-shifted values of the
original field. The user may then use the shifted values as predictors
in any supervised learning model.

In addition to the input dataset id, the script takes as input two
integers defining the limits of the sliding window, i.e. the minimum
and maximum row shifts to consider. Naturally, to implement a
forecasting model, the maximum shift should be less than 0 in order to
only consider past values as inputs.

## Example

Given the following input dataset:

````
cat-field,num-field
a,2
a,2
a,2
b,1
b,2
c,0
d,1
d,2
d,3
d,4
d,4

````

The result of calling the sliding window script with window limits
[-3, -1] will produce the following output dataset:

````
cat-field,num-field,num-field -3,num-field -2,num-field -1
a,2,,,
a,2,,,2
a,2,,2,2
b,1,2,2,2
b,2,2,2,1
c,0,2,1,2
d,1,1,2,0
d,2,2,0,1
d,3,0,1,2
d,4,1,2,3
d,4,2,3,4

````
