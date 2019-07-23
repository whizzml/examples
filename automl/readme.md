# AutoML: BigML Automated Machine Learning

These WhizzML scripts will let the user run a **fully automated
Machine Learning pipeline** in BigML.

![BigML AutoML](https://littleml.files.wordpress.com/2018/05/optiml_14.gif?w=497)


From a train, validation and test datasets, the following tasks will be
automatically done:

-  [`unsupervised-generation`](./unsupervised-generation): Creating
  the following **unsupervised models**: `Cluster`, `Anomaly Detector`,
  `Association Discovery`, `PCA`, `Topic Model`
-  [`unsupervised-generation`](./unsupervised-generation): Using the
  unsupervised models created previously for scoring the datasets and
  **generating, automatically, new features** for train, validation
  and test datasets
-  [`feature-selection`](./feature-selection) Reducing, automatically,
  the number of fields of the datasets using the
  [`recursive-feature-elimination`](../recursive-feature-elimination)
  algorithm.
-  [`auto-model`](./auto-model) Using OptiML to find the best models
  and using the top 5 models to create a `Fusion` model to predict all
  the test dataset instances. If a validation dataset is given, this
  script will return an evaluation of the final model too.

## Scripts

The following scripts are used:

 - [automl-orchestrator](./automl-orchestrator)
 - [unsupervised-generation](./unsupervised-generation)
 - [feature-generation](./feature-generation)
 - [feature-selection](./feature-selection)
 - [auto-model](./auto-model)

Furthermore, we also need the
[recursive-feature-elimination](../recursive-feature-elimination)
which is not in this repo, but it can be found on its parent
folder.

## Usage
Running BigML AutoML is extremly easy because there is an
[orchestrator script](./automl-orchestrator) that will coordinate the
executions of all the others scripts. So, this is the only script that
you will need to execute.

### Step 1: Importing all the scripts
Before executing any script, you should import to your BigML account
all the script from the **Scripts** section, including the
[recursive-feature-elimination](../recursive-feature-elimination).

Alternatively, you can use
[bigmler](https://github.com/bigmlcom/bigmler) to import automatically
all the scripts into your BigML account. For doing it, you should
first clone the [examples repo](https://github.com/whizzml/examples):

```bash
git clone https://github.com/whizzml/examples
```

Then, navigate to **automl** folder and execute this command:

```bash
bigmler whizzml --package-dir ./
```

### Step 2: Executing the orchestrator
Check [automl-orchestrator readme](./automl-orchestrator/readme.md) to
see how to use the orchestrator to run AutoML executions.

## FAQ
### Why can't I see in, in the scripts inputs in the BigML's dashboard, dropdowns menus to select the dataset, script, etc?
All the input parameters of these scripts are optional. So, they use a
**string** input type instead a `dataset-id` input type,
`execution-id` input type, etc. Using a **string** input type we can
provide a **default blank value** if the user don't want to pass one
input.
