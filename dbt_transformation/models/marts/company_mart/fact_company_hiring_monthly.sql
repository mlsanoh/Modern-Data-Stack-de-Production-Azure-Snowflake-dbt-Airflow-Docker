with job_postings as (
    select * from {{ ref('stg_job_postings') }}
),

dim_company as (
    select * from {{ ref('dim_company') }}
),

dim_job_title_short as (
    select * from {{ ref('dim_job_title_short') }}
),

fact_company_monthly_pre as (
    select
        dc.company_id,
        jts.job_title_short_id,
        date_trunc('month', jpf.job_posted_date) as month_start_date,
        jpf.job_country, 
        jpf.salary_year_avg,
        case when job_work_from_home = true then 1 else 0 end as is_remote,
        case when job_health_insurance = true then 1 else 0 end as health_insurance,
        case when job_no_degree_mention = true then 1 else 0 end as no_degree_mention
    from job_postings as jpf
    inner join dim_company as dc
        on jpf.company_id = dc.company_id
    inner join dim_job_title_short as jts
        on jpf.job_title_short = jts.job_title_short
    where jpf.job_country is not null
)

select 
    company_id,
    job_title_short_id,
    month_start_date,
    job_country,
    count(*) as postings_count,
    median(salary_year_avg) as median_salary_year,
    min(salary_year_avg) as min_salary_year,
    max(salary_year_avg) as max_salary_year,
    avg(is_remote) as remote_share,
    avg(health_insurance) as health_insurance_share,
    avg(no_degree_mention) as no_degree_mention_share
from fact_company_monthly_pre
group by company_id, job_title_short_id, month_start_date, job_country