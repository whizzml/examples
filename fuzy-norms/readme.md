# Fuzzy Logic norms

In this package, you will find some utilities to apply fuzzy logic
t-norms and t-conorms to datasets.

You can find all the information about the T-norms and T-conorms in
the following links:
    - [T-norms and T-conorms](https://en.wikipedia.org/wiki/T-norm)
    - [Construction of
      T-norms](https://en.wikipedia.org/wiki/Construction_of_t-norms)

The **inputs** for the script are:
* `dataset-id`: (dataset-id) Dataset where norms are applied
* `field-id1`: (string) Field ID or name of the first operand
* `field-id2`: (string) Field ID or name of the second operand
* `norms`: (list) List of norms to apply, with params if needed. See
  more information below.

The **outputs** for the script are:
* `fuzzy-dataset`: (dataset-id) Dataset with some new columns with the
  result of applying the norms (t-norms or t-conorms).

Fields used as operands must contain **real values between 0 and
1**. As they are logical values it doesn't make sense having values
outside this range. In this case, the script will raise an error.

The script will create a new column in the dataset for each one of the
norms specified in the `norms` list.


## T-norms and T-conorms
Bellow, you can find an example of the content of the `norms` input:

```
["min-tnorm","product","lukasiewicz", "drastic-tnorm",
"nilpotent-min",["schweizer-sklar", 0.5], ["hamacher", 0,5]]
```

As you can see there are some norms that need a parameter, that has to
be specified in this way.

These are the possibles t-norms:

 - **min-tnorm**: Minimum t-norm. Also called the Gödel t-norm. No
   parameters.
 - **product**: Product t-norm. The ordinary product of real
   numbers. No parameters.
 - **lukasiewicz**: Łukasiewicz t-norm.  No parameters.
 - **drastic-tnorm**: Drastic t-norm.  No parameters.
 - **nilpotent-min**: Nilpotent minimum t-norm. No parameters.
 - **[schweizer-sklar p]**: Schweizer–Sklar t-norms. Parameter *p* in
   the range [-∞, ∞]
 - **[hamacher p]**: Hamacher t-norms. Parameter *p* in the range [0,
   ∞]
 - **[yager p]**: Yager t-norms. Parameter *p* in the range [0,
   ∞]
 - **[aczel-alsina p]**: Aczél–Alsina t-norms. Parameter *p* in the range [0,
   ∞]
 - **[dombi p]**: Dombi t-norms. Parameter *p* in the range [0,
   ∞]
 - **[sugeno-weber p]**: Sugeno–Weber t-norms. Parameter *p* in the range [-1,
   ∞]


These are the possible t-conorms:

 - **max-tconorm**: Maximum t-norm. Dual to the minimum t-norm, is the
   smallest t-conorm. No parameters
 - **probabilistic**: Probabilistic t-norm. It's dual to the product
   t-norm. No parameters.
 - **bounded**: Bounded t-norm. It'ss dual to the Łukasiewicz t-norm. No
   parameters.
 - **drastic-tconorm**: Drastic t-conorm. It's dual to the drastic
   t-norm. No paramters.
 - **nilpotent-max**: Nilpotent maximum t-conorm. It's dual to the
   nilpotent minumum.
 - **einstein-sum**: Einstein t-conorm. It's a dual to one of the
   Hamacher t-norms.

## Tests

The `test` directory contains a shell script named `test.sh`
which uses `BigMLer` to perform a basic test of the WhizzML code. To run the
test:

- BigMLer must be installed. For instructions to install BigMLer
please refer to the [BigMLer
documentation](http://bigmler.readthedocs.io/en/latest/#bigmler-installation).
- Your credentials must be set as environment variables. Please refer
to the [BigML
Authentication](http://bigmler.readthedocs.io/en/latest/#bigml-authentication)
section of docs for details.

Once the setup is complete, go to the test directory and run the shell script

```bash
    cd test
    ./test.sh
```
