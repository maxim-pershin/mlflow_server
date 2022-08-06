FROM python:3.8-slim-buster
RUN pip install mlflow psycopg2-binary pymysql pysftp

RUN mkdir -p $HOME/.ssh
RUN ssh-keyscan -H "sftp" >> /etc/ssh/ssh_known_hosts
RUN ssh-keyscan -H "localhost" >> /etc/ssh/ssh_known_hosts
RUN ssh-keyscan -H "mlflow_sftp" >> /etc/ssh/ssh_known_hosts
RUN ssh-keyscan -H "sftp" >> ~/.ssh/known_hosts
RUN ssh-keyscan -H "mlflow_sftp" >> ~/.ssh/known_hosts
RUN ssh-keyscan -H "localhost" >> ~/.ssh/known_hosts