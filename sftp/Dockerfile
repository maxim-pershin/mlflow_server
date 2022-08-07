FROM atmoz/sftp:debian

RUN mkdir -p $HOME/.ssh
COPY ssh/id_rsa.pub ssh/id_rsa ssh/config /root/.ssh/
RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub