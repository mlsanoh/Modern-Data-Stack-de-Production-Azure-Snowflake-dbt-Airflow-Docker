with source_data as (
    select * from {{source('snowflake_raw', 'job_postings_raw')}}
)

select 
    job_id, 
    company_id, 
    job_title_short, 
    job_title, 
    job_location, 
    job_via, 
    job_schedule_type, 
    job_work_from_home,
    search_location,
    job_posted_date, 
    job_no_degree_mention, 
    job_health_insurance, 
    job_country, 
    salary_rate, 
    salary_year_avg, 
    salary_hour_avg
from source_data