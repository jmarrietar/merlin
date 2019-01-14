"""
4. Point.
---------

Job Posted with ID Requirements and candidate work_experience

"""


SELECT 
n.id_job,
n.id_candidate,
n.duration,
n.required_work_experience,
n.job_type,
n.salary_period,
n.salary,
n.position_name,
m.cv,
m.experience,
n.shortlisted
FROM 
(
	SELECT 
	shortlisted.id_job,
	shortlisted.id_candidate,
	job.duration,
	job.required_work_experience,
	job.job_type,
	job.salary_period,
	job.salary,
	job.position_name,
	shortlisted.shortlisted
	FROM 
	shortlisted
	LEFT JOIN 
	job
	ON
	shortlisted.id_job = job.id_job
	WHERE
	shortlisted.id_candidate IS NOT NULL
) AS n
LEFT JOIN
(
	SELECT 
	id_candidate, 
	GROUP_CONCAT(DISTINCT position_name SEPARATOR ' ') AS cv,
	GROUP_CONCAT(DISTINCT duration SEPARATOR ' ') AS experience
	FROM work_experience 
	GROUP BY id_candidate
) AS m 
ON n.id_candidate = m.id_candidate
ORDER BY n.id_job
