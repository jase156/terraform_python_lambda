FROM python:3.9-alpine

RUN apk add --no-cache \
    build-base \
    libtool \ 
    autoconf \ 
    automake \ 
    libexecinfo-dev \ 
    make \
    cmake \ 
    libcurl \
    bash \
    curl


COPY . .
# Install the runtime interface client
RUN pip install awslambdaric
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie

RUN chmod 755 /usr/bin/aws-lambda-rie /entry.sh
ENTRYPOINT [ "/entry.sh" ]
#ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]
CMD [ "app.lambda_handler" ]
#CMD ["/bin/bash"]