{% snapshot priority_jobs_snapshot %}

{{
    config(
      target_database='RAW',
      target_schema='PRIORITY_MART',
      unique_key='job_id',
      strategy='check',
      check_cols=['priority_lvl'],
    )
}}

with job_postings as (
    select * from {{ ref('stg_job_postings') }}
),
companies as (
    select * from {{ ref('stg_company') }}
),
priority_roles as (
    select * from {{ ref('priority_roles') }}
)

select 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    pr.priority_lvl
from job_postings as jpf 
left join companies as cd
    on jpf.company_id = cd.company_id
inner join priority_roles as pr
    on jpf.job_title_short = pr.role_name

{% endsnapshot %}