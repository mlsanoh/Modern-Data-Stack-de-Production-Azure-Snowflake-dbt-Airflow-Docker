with jobs as (
    select * from {{ ref('stg_job_postings') }}
),

companies as (
    select * from {{ ref('stg_company') }}
),

skills_jobs as (
    select * from {{ ref('stg_skills_jobs') }}
),

skills as (
    select * from {{ ref('stg_skills') }}
)

select
    j.job_id,
    j.job_title,
    j.job_title_short,
    j.job_location,
    j.job_via,
    j.job_schedule_type,
    j.job_work_from_home,
    j.job_posted_date,
    j.job_country,
    j.salary_rate,
    j.salary_year_avg,
    j.salary_hour_avg,
    c.company_name,
    s.skill_name,
    s.skill_type
from jobs j
left join companies c on j.company_id = c.company_id
left join skills_jobs sj on j.job_id = sj.job_id
left join skills s on sj.skill_id = s.skill_id