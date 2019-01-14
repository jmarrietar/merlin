"""
Percentage 'Qualified' Candidates Per Week. 
Where Qualified is defined as Candidates that were shortlisted. 
"""

SELECT 
n.week_number AS week,
SUM(n.shortlisted)/SUM(n.applied)*100 AS percentage_quality_candidates
FROM
(
	SELECT 
	job.id_job,
	created_at,
	WEEK(created_at) AS week_number, 
	m.shortlisted,
	m.applied
	FROM 
	job
	INNER JOIN
	(
		SELECT 
		id_job,
		SUM(shortlisted) AS shortlisted, 
		COUNT(shortlisted) AS applied
		FROM 
		shortlisted
		WHERE 
		id_candidate IS NOT NULL
		GROUP BY id_job
	) AS m 
	on m.id_job = job.id_job
) AS n
GROUP BY n.week_number
