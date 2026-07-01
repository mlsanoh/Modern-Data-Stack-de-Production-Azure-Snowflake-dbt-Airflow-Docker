with source_data as (
    select * from {{ source('snowflake_raw', 'skills_raw') }}
)

select
    skill_id, 
    skills as skill_name,
    type as skill_type
from source_data