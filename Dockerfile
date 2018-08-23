FROM alpine:latest

WORKDIR /app

ADD tubs_checks.xml .
ADD requirements.txt .

ENV JPLAG_VERSION=2.11.9-SNAPSHOT

RUN apk add --no-cache openjdk8 python3 curl git openssh-client make
RUN curl -sL https://github.com/jplag/jplag/releases/download/v${JPLAG_VERSION}/jplag-${JPLAG_VERSION}-jar-with-dependencies.jar -o jplag.jar
RUN pip3 install -r requirements.txt
# A version of python-gitlab that supports listing all forks of a project is needed,
# currently only the latest developement version supports this relatively new feature
# TODO: remove the following line when a new release of python-gitlab becomes available on pypi
RUN git clone https://github.com/python-gitlab/python-gitlab.git
RUN pip3 install --upgrade ./python-gitlab
