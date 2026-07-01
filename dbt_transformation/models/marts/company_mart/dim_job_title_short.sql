with job_postings as (
    select * from {{ ref('stg_job_postings') }}
)

select distinct
    dense_rank() over(order by job_title_short) as job_title_short_id, 
    job_title_short
from job_postings
where job_title_short is not null