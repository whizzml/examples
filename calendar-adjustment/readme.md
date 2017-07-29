# Calendar adjustment for monthly time series.

Given a dataset containing monthly time series data with datestamps,
normalizes the time series values by the number of days per month
(with leap year detection) and extends the dataset with the normalized
values. Suitable for monthly aggregated data (e.g. total liters per
month).

# Inputs

- The dataset you wish to extend

- A list of field IDs containing time series values

- A field ID containing the month datestamp

- A field ID containing the year datestamp

- The name for the new adjusted time series field

# Output

- The dataset extended with adjusted time series values
