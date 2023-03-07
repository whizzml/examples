# WhizzML: 101 - Creating and executing scripts

WhizzML is a complete language that allows creating scripts and executions
from an existing script within the platform.

These code snippets show examples to illustrate how to create and execute
simple scripts:

## Basic script, no inputs

This is the code to create a simple script that creates a source from an
existing CSV file that is available in a remote URL:

```
    ;; step 0: creating a script that uploads a remote file and creates a source
    (define script-id (create-script
                        {"source_code" "(create-source {\"remote\" \"https://static.bigml.com/csv/iris.csv\"})"}))
    ;; step 1: executing the script
    (define execution-id (create-execution script-id))
    ;; waiting for the execution to be finished before retrieving the result
    (define execution-resource (fetch (wait execution-id)))
    ;; retrieving the result (that is, a source ID)
    (define result (execution-resource["execution" "result"]))
```

You can test this code in the [WhizzML REPL](https://bigml.com/labs/repl/).

In this example. the `url` used is always the same, so no inputs are provided
to the script. This is not a realistic situation, because usually scripts
need user-provided inputs. The next example shows how to
add two variables, whose values will be provided as inputs.

## Basic script with inputs

Scripts usually need some inputs to work. When defining the script, you need
to provide booth the code and the description of the inputs that it will
accept.

```
    ;; step 0: creating a script that adds two numbers
    (define script-id (create-script {"source_code" "(+ a b)"
                                     "inputs" [{"name" "a"
                                                "type" "number"}
                                               {"name" "b"
                                                "type" "number"}]}))
    ;; step 1: executing the script with some particular inputs: a=1, b=2
    (define execution-id (create-execution script-id
                                           {"inputs" [["a" 1]
                                                      ["b" 2]]}))
    ;; waiting for the execution to be finished before retrieving the result
    (define execution-resource (fetch (wait execution-id)))
    ;; retrieving the result (e.g. 3)
    (define result (execution-resource ["execution" "result"]))
```

## Basic Execution

In a full-fledged script, you will also produce some outputs that can be used
in other scripts. This is an example of a script creating a dataset from a
source that was generated from a remote URL. Both the URL and the source
name are provided by the user. Once the script has been created, we
run it by creating an execution from it and placing the particular input values
that we want to apply it to.

```
    ;; step 0: creating a script that creates a `source` and a dataset from
    ;;         a user-given remote file
    (define script-id (create-script
                        {"source_code" "(define my-dataset (create-dataset (create-source {\"remote\" url \"name\" source-name})))"
                         "inputs" [{"name" "url"
                                    "type" "string"}
                                   {"name" "source-name"
                                    "type" "string"}]
                         "outputs" [{"name" "my-dataset"
                                     "type" "dataset"}]}))
    ;; step 1: executing the script with some particular inputs
    (define execution-id (create-execution script-id
                                           {"inputs" [["url" "https://static.bigml.com/csv/iris.csv"]
                                                   ["source-name" "my source"]]}))
    ;; waiting for the execution to be finished before retrieving the result
    (define execution-resource (fetch (wait execution-id)))
    ;; step 2: retrieving the result (e.g. "dataset/5cae5ad4b72c6609d9000356")
    (define result (execution-resource ["execution" "result"]))
```

Check the [API documentation](https://bigml.com/api/) to learn about the
available configuration options for any BigML resource.
