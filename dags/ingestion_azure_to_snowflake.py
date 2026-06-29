from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator

# Configuration des paramètres par défaut du DAG
default_args = {
    'owner': 'mlsanoh',
    'depends_on_past': False,
    'start_date': datetime(2026, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Définition du DAG
with DAG(
    dag_id='ingestion_azure_to_snowflake',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:

    # TASK 1 : Charger la table COMPANY_RAW
    load_company = SnowflakeOperator(
        task_id='load_company_table',
        snowflake_conn_id='snowflake_conn',
        warehouse='COMPUTE_WH',
        sql="""
            COPY INTO RAW.SOURCES.COMPANY_RAW
            FROM @RAW.SOURCES.AZURE_JOBS_STAGE/company_raw.csv
            ON_ERROR = 'CONTINUE';
        """,
    )

    # TASK 2 : Charger la table JOB_POSTINGS_RAW
    load_job_postings = SnowflakeOperator(
        task_id='load_job_postings_table',
        snowflake_conn_id='snowflake_conn',
        warehouse='COMPUTE_WH',
        sql="""
            COPY INTO RAW.SOURCES.JOB_POSTINGS_RAW
            FROM @RAW.SOURCES.AZURE_JOBS_STAGE/job_postings_raw.csv
            ON_ERROR = 'CONTINUE';
        """,
    )

    # TASK 3 : Charger la table SKILLS_RAW
    load_skills = SnowflakeOperator(
        task_id='load_skills_table',
        snowflake_conn_id='snowflake_conn',
        warehouse='COMPUTE_WH',
        sql="""
            COPY INTO RAW.SOURCES.SKILLS_RAW
            FROM @RAW.SOURCES.AZURE_JOBS_STAGE/skills_raw.csv
            ON_ERROR = 'CONTINUE';
        """,
    )

    # TASK 4 : Charger la table SKILLS_JOBS_RAW
    load_skills_jobs = SnowflakeOperator(
        task_id='load_skills_jobs_table',
        snowflake_conn_id='snowflake_conn',
        warehouse='COMPUTE_WH',
        sql="""
            COPY INTO RAW.SOURCES.SKILLS_JOBS_RAW
            FROM @RAW.SOURCES.AZURE_JOBS_STAGE/skills_job_raw.csv
            ON_ERROR = 'CONTINUE';
        """,
    )

    # Exécution en parallèle
    [load_company, load_job_postings, load_skills, load_skills_jobs]