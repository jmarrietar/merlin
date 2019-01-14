"""
3. Point.
---------

Dataset for Jobs. 
Predict Based on Job Features, How Many Job Applications Will Have

"""

SELECT 
job.id_job,
job.duration,
job.required_work_experience,
job_type,
job.salary_period,
job.salary,
job.position_name,
job.latitude,
job.longitude,
t.applied
FROM 
job
LEFT JOIN 
(
	SELECT 
	id_job,
	COUNT(shortlisted) AS applied
	FROM 
	shortlisted
	WHERE 
	id_candidate IS NOT NULL
	GROUP BY id_job
	UNION
	SELECT 
	id_job,
	0 AS applied
	FROM 
	shortlisted
	WHERE 
	id_candidate IS  NULL
	GROUP BY id_job
) AS t
on t.id_job = job.id_job
ORDER BY t.applied DESC