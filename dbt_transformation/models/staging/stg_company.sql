with source_data as (
    select * from {{source('snowflake_raw', 'company_raw')}}
)

select 
    company_id,
    name as company_name
from source_data