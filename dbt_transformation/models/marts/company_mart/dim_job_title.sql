with job_postings as (
    select * from {{ ref('stg_job_postings') }}
)

select distinct
    dense_rank() over(order by job_title) as job_title_id,
    job_title
from job_postings
where job_title is not null