with job_postings as (
    select * from {{ ref('stg_job_postings') }}
),

dim_company as (
    select * from {{ ref('dim_company') }}
),

dim_location as (
    select * from {{ ref('dim_location') }}
)

select distinct 
    dc.company_id, 
    dl.location_id
from job_postings as jpf
inner join dim_company as dc
    on jpf.company_id = dc.company_id
inner join dim_location as dl
    on jpf.job_location = dl.job_location