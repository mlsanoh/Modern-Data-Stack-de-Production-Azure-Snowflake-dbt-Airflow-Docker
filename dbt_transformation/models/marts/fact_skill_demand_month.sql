with monthly_prep as (
    select * from {{ ref('int_monthly_postings') }}
)

select 
    skill_id,
    month_start_date,
    job_title_short,
    count(*) as postings_count,
    sum(health_insurance_postings) as health_insurance_postings_count,
    sum(remote_postings) as remote_postings_count,
    sum(no_degree_mention) as no_degree_mention_count
from monthly_prep
group by all