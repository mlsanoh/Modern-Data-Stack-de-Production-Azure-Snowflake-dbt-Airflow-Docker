FROM apache/airflow:2.9.2-python3.11
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir "apache-airflow==2.9.2" -r /requirements.txt
