
# Merlin
This repository contains two task. One related with Data Engineering and the other related with Data Analysis.

## Data Engineer Test

ETL related task. In short, migrate some data from Google Spreadsheets to other Data persistence (**Big Query** in this case) and perform some *transformation* to the data in between (add two more columns).

A custom python script was developed using [df2gspread](https://df2gspread.readthedocs.io/en/latest/examples.html) library to read from Google SpreadSheets and [pytz](https://pypi.org/project/pytz/) library to transform between Time Zones.

The following python scrips were developed:

 - [data_engineer.py](https://github.com/jmarrietar/merlin/blob/engineer/data-engineer/data_engineer.py)  Perform the Task of Reading from Google Spreadsheet, perform transformations and write to BigQuery persistence. Parameters are in code as 
	 - **gpath:** Spread Sheet ID
	 -  **sheet:** Worksheet name
	 - **table:** BQ destination Table in format dataset.table
	 - **project_id:** GCP Project
	 - **col:** List of columns
 - [auxiliar.py](https://github.com/jmarrietar/merlin/blob/engineer/data-engineer/auxiliar.py) Various auxiliary functions developed to help transformations as Time Zone conversions and additional column creation.

#### Run script

    python data_engineer.py

BigQuery Table was created using UI. And link to Bigquery table was share to emails provided with view permissions.

![BigQuery Table](https://github.com/jmarrietar/merlin/blob/engineer/image/bq.png)

#### Automation propose

In order to Automate process. Google App Engine can Run daily a Virtual Machine with the provided code in a daily cron, selecting only new rows (last row number from last day could be saved for example). Python code could be extended to be more flexible and parameters could be passed as bash arguments.


## Data Analysis Test