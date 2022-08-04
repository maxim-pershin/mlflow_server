FROM nginx:1.23.0
RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx
COPY mlflow.conf /etc/nginx/sites-enabled/
