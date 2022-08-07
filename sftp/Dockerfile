FROM atmoz/sftp:debian

RUN mkdir -p $HOME/.ssh
COPY sftp/ssh/id_rsa.pub sftp/ssh/id_rsa sftp/ssh/config $HOME/.ssh/
RUN chmod 700 $HOME/.ssh && \
    chmod 600 $HOME/.ssh/id_rsa && \
    chmod 644 $HOME/.ssh/id_rsa.pub