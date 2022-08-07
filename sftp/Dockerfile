FROM atmoz/sftp:alpine

RUN apk add --no-cache alpine-sdk \
	openssh \
	openssl-dev \
	libffi-dev

# RUN mkdir -p $HOME/.ssh
# COPY ./ssh/id_rsa.pub ./.ssh/id_rsa.pub
# COPY ./ssh/id_rsa ./.ssh/id_rsa
# COPY ./ssh/config /root/.ssh/config
# RUN chmod 700 /root/.ssh && \
#     chmod 600 /root/.ssh/id_rsa && \
#     chmod 644 /root/.ssh/id_rsa.pub

RUN mkdir -p $HOME/.ssh
COPY ssh/id_rsa.pub ssh/id_rsa ssh/config /root/.ssh/
RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub

COPY ./ssh/id_rsa.pub /root/.ssh/id_rsa.pub
COPY ./ssh/id_rsa /root/.ssh/id_rsa
COPY ./ssh/config /root/.ssh/config