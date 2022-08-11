FROM python:3.9-alpine

ARG HOME="/home/dev"
ARG BUILD_DEPS="curl unzip"
ARG TERRAFORM_VERSION=1.2.6
ARG TERRAFORM_DOWNLOAD_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ARG TERRAFORM_ZIP=terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN apk update \
    && apk add --no-cache $BUILD_DEPS bash groff

RUN curl $TERRAFORM_DOWNLOAD_URL -o $TERRAFORM_ZIP \
    && unzip ${TERRAFORM_ZIP} \
    && mv terraform /usr/bin/terraform \
    && rm ${TERRAFORM_ZIP}
    

RUN pip install awscli

RUN apk del $BUILD_DEPS


USER root
WORKDIR $HOME
COPY . .

CMD ["/bin/bash"]