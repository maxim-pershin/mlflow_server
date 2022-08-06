FROM python:3.8-slim-buster
RUN pip install mlflow psycopg2-binary pymysql pysftp
RUN ssh-keyscan -H "mlflow_sftp" >> /etc/ssh/ssh_known_hosts
RUN ssh-keyscan "mlflow_sftp" >> ~/.ssh/known_hosts
RUN ssh-keyscan -H "localhost" >> /etc/ssh/ssh_known_hosts
RUN ssh-keyscan "localhost" >> ~/.ssh/known_hosts