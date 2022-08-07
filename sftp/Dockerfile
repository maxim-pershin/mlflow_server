FROM atmoz/sftp:debian

RUN mkdir -p $HOME/.ssh
COPY ./ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub
COPY ./ssh/id_rsa $HOME/.ssh/id_rsa
COPY ./ssh/config $HOME/.ssh/config
RUN chmod 700 $HOME/.ssh && \
    chmod 600 $HOME/.ssh/id_rsa && \
    chmod 644 $HOME/.ssh/id_rsa.pub