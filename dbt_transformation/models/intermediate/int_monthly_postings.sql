with job_postings as (
    select * from {{ ref('stg_job_postings') }}
),

skills_jobs as (
    select * from {{ ref('stg_skills_jobs') }}
)

select
    sjd.skill_id,
    date(date_trunc('month', jpf.job_posted_date)) as month_start_date,
    jpf.job_title_short,
    case when jpf.job_health_insurance = true then 1 else 0 end as health_insurance_postings,
    case when jpf.job_work_from_home = true then 1 else 0 end as remote_postings,
    case when jpf.job_no_degree_mention = true then 1 else 0 end as no_degree_mention
from job_postings as jpf
left join skills_jobs as sjd 
    on jpf.job_id = sjd.job_id