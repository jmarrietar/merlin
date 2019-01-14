"""
Event table was flattened into shortlisted indicating if a candidate application was shortlisted or not
"""

CREATE TABLE shortlisted(
	id_job VARCHAR(2555),
	id_candidate VARCHAR(255),
	shortlisted INTEGER
);

CREATE INDEX idx_short_candidate ON shortlisted (id_candidate);

#Populate table

INSERT INTO shortlisted (id_job, id_candidate, shortlisted)
SELECT 
job.id_job,
event.id_candidate,
1 AS shortlisted
FROM 
job 
LEFT JOIN
event 
ON 
job.id_job = event.id_job
GROUP BY  event.id_candidate, job.id_job
HAVING COUNT(*) >= 2
UNION
SELECT 
job.id_job,
event.id_candidate,
0 AS shortlisted
FROM 
job 
LEFT JOIN
event 
ON 
job.id_job = event.id_job
GROUP BY  event.id_candidate, job.id_job
HAVING COUNT(*) <= 1