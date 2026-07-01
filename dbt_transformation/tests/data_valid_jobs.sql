-- dbt s'attend à ce que cette requête renvoie 0 ligne.

select
    job_id,
    salary_year_avg,
    job_posted_date
from {{ ref('stg_job_postings') }}
where 
    (salary_year_avg <= 0) or
    (job_posted_date > current_timestamp())