FROM python:3.9-alpine

ARG USER_WORK_DIR="/home"
ARG LAMBDA_LOCAL="/home/app/"

RUN apk add --no-cache \
    build-base \
    libtool \ 
    autoconf \ 
    automake \ 
    libexecinfo-dev \ 
    make \
    cmake \ 
    libcurl \
    bash


COPY . ${USER_WORK_DIR}
RUN pip install awslambdaric

ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie
RUN chmod 755 /usr/bin/aws-lambda-rie ${USER_WORK_DIR}/entry.sh

ENTRYPOINT [ "/home/entry.sh" ]
CMD [ "app.app.lambda_handler" ]