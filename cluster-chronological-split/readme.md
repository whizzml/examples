# Cluster 10 split
### Split dataset chronologically into a Training and Test dataset based on a Cluster

* **Inputs:** Given a dataset chronologically ordered, a set of input fields, a K number and a split proportion
* **Outputs:** Returns a dictionary including a test and training dataset resulting from the implemented split

1. From the input dataset, trains a K-means Cluster (cluster fields and K as an input)
2. Batch centroid over the original dataset to add K different cluster labels. This way data is separated in K groups of similarity
3. For each cluster create a new dataset
4. Split datasets linearly (using a proportion from the input parameter) keeping the latest for test
5. Merge all train and test datasets portions into the resulting training and test final datasets

Requirements: The input dataset needs to be ordered chronologically (BigML ordering capabilities can be manually used as desired)

Installation command to be executed from the local directory (bigmler needs to be previously installed):

```
    bigmler whizzml --package-dir . --output-dir ~/tmp --org-project project/yourProjectId12345

```
