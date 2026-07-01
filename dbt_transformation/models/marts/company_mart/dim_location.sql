with job_postings as (
    select * from {{ ref('stg_job_postings') }}
)

select distinct
    dense_rank() over(order by job_location, job_country) as location_id,
    job_country,
    job_location
from job_postings
where job_location is not null