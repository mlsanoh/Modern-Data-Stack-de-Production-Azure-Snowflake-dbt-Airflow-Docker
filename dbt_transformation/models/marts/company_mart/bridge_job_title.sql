with job_postings as (
    select * from {{ ref('stg_job_postings') }}
),

dim_job_title_short as (
    select * from {{ ref('dim_job_title_short') }}
),

dim_job_title as (
    select * from {{ ref('dim_job_title') }}
)

select distinct
    jts.job_title_short_id,
    jt.job_title_id 
from job_postings as jpf 
inner join dim_job_title_short as jts
    on jpf.job_title_short = jts.job_title_short
inner join dim_job_title as jt
    on jpf.job_title = jt.job_title