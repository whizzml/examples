# Name clusters
Script to give names to clusters using important field names and their values

The script takes as inputs:
  - a cluster id
  - the number of terms to use in each cluster name
  - a string used as a separator to join terms to form clusters names

and yields as output:
 - the list of used cluster names 

The script updates the clusters names using the most important field names and 
their value in the centroid. The cluster that is used as an input for this script
must be created with the **Create models** option checked. However, creating each
cluster model is not necessary, because the script creates all of them. 

