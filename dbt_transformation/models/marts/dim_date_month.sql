with job_postings as (
    select * from {{ ref('stg_job_postings') }}
)

select distinct
    date_trunc('month', job_posted_date) as month_start_date,
    extract(year from job_posted_date) as year,
    extract(month from job_posted_date) as month,
    extract(quarter from job_posted_date) as quarter,
    concat('Q', '-', extract(quarter from job_posted_date)) as quarter_name,
    concat(extract(year from job_posted_date), '-Q', extract(quarter from job_posted_date)) as year_quarter
from job_postings