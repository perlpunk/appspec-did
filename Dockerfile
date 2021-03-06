FROM alpine:latest

RUN apk update \
  && apk add curl wget git tar make gcc build-base perl perl-yaml-xs

RUN curl https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm > cpanm \
  && chmod +x cpanm \
  && ./cpanm App::cpanminus \
  && rm cpanm

RUN cpanm --notest Moo JSON::Validator File::Share \
  && rm -rf /root/.cpanm

RUN git clone https://github.com/perlpunk/App-Spec-p5.git /appspeclib/App-Spec-p5 \
  && git clone https://github.com/perlpunk/App-AppSpec-p5.git /appspeclib/App-AppSpec-p5 \
  && cd /appspeclib/App-Spec-p5 \
  && git checkout completion


RUN apk del curl tar make gcc build-base git openssh wget \
  && rm -rf /var/cache/apk/*

COPY appspec /appspec
