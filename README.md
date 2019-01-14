

# Merlin
This repository contains two task. One related with Data Engineering and the other related with Data Analysis.

## Data Engineer Test

ETL related task. In short, migrate some data from Google Spreadsheets to other Data persistence (**Big Query** in this case) and perform some *transformation* to the data in between (add two more columns).

A custom python script was developed using [df2gspread](https://df2gspread.readthedocs.io/en/latest/examples.html) library to read from Google SpreadSheets and [pytz](https://pypi.org/project/pytz/) library to transform between Time Zones.

The following python scrips were developed:

 - [data_engineer.py](https://github.com/jmarrietar/merlin/blob/master/data-engineer/data_engineer.py)  Perform the Task of Reading from Google Spreadsheet, perform transformations and write to BigQuery persistence. Parameters are in code as 
	 - **gpath:** Spread Sheet ID
	 -  **sheet:** Worksheet name
	 - **table:** BQ destination Table in format dataset.table
	 - **project_id:** GCP Project
	 - **col:** List of columns
 - [auxiliar.py](https://github.com/jmarrietar/merlin/blob/master/data-engineer/auxiliar.py) Various auxiliary functions developed to help transformations as Time Zone conversions and additional column creation.

#### Run script

    python data_engineer.py

BigQuery Table Schema was created using UI. And link to Bigquery table was share to emails provided with view permissions.

![BigQuery Table](https://github.com/jmarrietar/merlin/blob/master/image/bq.png)

#### Automation propose

In order to Automate process. Google App Engine can Run daily a Virtual Machine with the provided code in a daily cron, selecting only new rows (last row number from last day could be saved for example). Python code could be extended to be more flexible and parameters could be passed as bash arguments.


## Data Analysis Test
The following section consist on a series of Data Analysis questions.


### 1st Part
#### 1. Candidate quality
Looking the different tables on the database and taking into account the business I defined the candidate quality in a very straightforward way.

- <b>Quality candidate: </b> Candidate that was shortlisted for the job he applied.

#### 2. Weekly application from Qualified candidates

In order to calculate the percentage of weekly applications coming from qualified candidates based on the previous definition a new table called <b> shorlisted </b>  was created LINK and populated flattening the event table, separating candidates that were shortlisted (1) or not (0).

The following graph show the percentage of Weekley applications  ranging from weeks 34 to 38, data was gathered using query <b>qualified_per_week.sql</b> LINK. 


| week | percentage_quality_candidates (%) |
|--|--|
|34  | 3.0303 |
|35|3.0769|
| 36 |  3.8808|
| 37 |  3.9812|
| 38 |  2.2271|

![Quality candidates per week](https://github.com/jmarrietar/merlin/blob/analysis/data-analysis/plots/quality_candidates.png)


#### 3. What matters most to Candidates?
Approach for this question consist on a descriptive and a predictive analysis in order to determine what features make candidates apply more to more jobs than others. 

<i> Dataset for this point was created using [applications_per_job.sql](https://github.com/jmarrietar/merlin/blob/analysis/data-analysis/sql/applications_per_job.sql) query, that concatenates jobs applications and counts how many each one received. </i> 

From the Prescritive Analysis we can say that Required work experience and Salary are the two most important features for candidates to apply for jobs. 
![Descriptive Analysis](https://github.com/jmarrietar/merlin/blob/analysis/data-analysis/plots/descriptive.png)

A predictive approach was used, training a Random Forest Regressor and ranking feature importance. From results features from more imporante to less important are :

* ***required_work_experience***
* ***Salary***
* ***salary_period*** 
* ***duration*** 
* ***job_type***


From the predictive analysis we can conclude that the variables that most will affect the number of applications are the <b> Required work experience </b> and the <b> salary </b> and looking to the graphs from the descriptive analysis we can see that most variables candidates apply for are ‘PERMANENT’ for Job duration.  ‘FULL_TIME’ for Job Type and ‘1-2 Years’ from required work experience.

-  <i> Complete Analysis with python code at  [job-application-analys.ipynb](https://github.com/jmarrietar/merlin/blob/analysis/data-analysis/notebooks/job-application-analys.ipynb) </i>


#### 4. Employer Behavior when shortlisting. 

An interesting Idea I wanted to pursue is how likely is an employer to shortlist a candidate that have had similar work experience titles than the one in the job posted.

This dataset was created using <b> job_candidate_match.sql </b> , a query that would join job information with candidate work_experience flattened into a column called <b> cv </b>, and a column <b> shortlisted </b> indicating if the candidate was shortlisted (1) or not (0). 

I would like to know if applying some function of string similarity between past experience cv previously constructed and the position_name would indicate a difference in the average of being shortlisted or not. 


![Similarity ](https://github.com/jmarrietar/merlin/blob/analysis/data-analysis/plots/point4.png)

Employers tend to shortlist in average a little more from candidates with a higher string match score  between past job titles and job title posted but might not be significant, is important to take into account that similarity was made on the fly and not very rigorous. Future job could be improve this score marching with maybe a <b> [Bag of Words](https://en.wikipedia.org/wiki/Bag-of-words_model) </b> approach. 

-  <i> Complete Analysis with python code at  [job-application-analys.ipynb](https://github.com/jmarrietar/merlin/blob/analysis/data-analysis/notebooks/employer-shortlisting-behaviour.ipynb) </i>

---
### 2nd Part
#### How to improve employer-candidate matching?
I would combine some quick wings using business heuristics with user perfilation. Also exploring method as <b> [Bag of Words](https://en.wikipedia.org/wiki/Bag-of-words_model) </b> modeling with distances could be interesting. 