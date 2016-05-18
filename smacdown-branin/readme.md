# SMACdown example: optimizing the Branin function

This is a simple SMACdown use case in which we find an extreme of the
[Branin function](http://www.sfu.ca/~ssurjano/branin.html) using a
generator of random parameterizations of the functions and a SMACdown
evaluator that is simply the value returned by the function itself.

The result of running the script is an ordered list of maps.  Each
entry corresponds to the actual value computed for the Branin function
and the associated parameters that were used.

Here's an example of a few entries in the output of one execution:

```json
[
  {
    "actual_value": 0.4613817553153119,
    "parameters": {
      "x2": 2.70347110577859,
      "x1": 9.402492375811562
    }
  },
  {
    "actual_value": 0.5309405607473874,
    "parameters": {
      "x2": 2.5352928950451314,
      "x1": 9.587350724032149
    }
  },
  {
    "actual_value": 0.5543512714405487,
    "parameters": {
      "x2": 2.182815367123112,
      "x1": 9.501717750681564
    }
  },
  {
    "actual_value": 0.5811496081521472,
    "parameters": {
      "x2": 2.532762730261311,
      "x1": 9.251778199104592
    }
  },
  {
    "actual_value": 0.652257447013854,
    "parameters": {
      "x2": 12.85297485999763,
      "x1": -3.3721502602566034
    }
  }
]
```
