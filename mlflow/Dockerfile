FROM python:3.8-slim-buster
RUN pip install mlflow psycopg2-binary pymysql pysftp
RUN ssh-keyscan -H "sftp" >> /etc/ssh/ssh_known_hosts
RUN ssh-keyscan "sftp" >> ~/.ssh/known_hosts