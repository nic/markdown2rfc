FROM python:3-slim-buster

RUN apt-get update && apt-get install -y wget

#RUN pip install 'xml2rfc==2.40.1'
RUN pip install 'xml2rfc'


WORKDIR /usr/local/bin

#RUN wget https://github.com/mmarkdown/mmark/releases/download/v2.1.1/mmark_2.1.1_linux_amd64.tgz -O/tmp/mmark.tgz \
RUN wget https://github.com/mmarkdown/mmark/releases/download/v2.2.25/mmark_2.2.25_linux_amd64.tgz -O/tmp/mmark.tgz \
   && tar xzf /tmp/mmark.tgz

COPY make.sh /usr/local/bin/make.sh

WORKDIR /data

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/make.sh" ]
