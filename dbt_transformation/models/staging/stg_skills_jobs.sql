with source_data as (
    select * from {{ source('snowflake_raw', 'skills_jobs_raw')}}
)

select
    skill_id,
    job_id
from source_data