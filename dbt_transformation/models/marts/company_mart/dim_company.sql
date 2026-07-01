with companies as (
    select * from {{ ref('stg_company') }}
)
select distinct 
    company_id, 
    company_name
from companies