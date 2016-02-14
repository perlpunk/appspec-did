FROM alpine:latest

RUN apk update \
  && apk add curl tar make gcc build-base

RUN apk add perl \
  && apk add git \
  && apk add vim \
  && apk add openssh

RUN apk add wget perl-yaml-xs \
  && curl https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm > cpanm \
  && chmod +x cpanm \
  && ./cpanm App::cpanminus

RUN cpanm --notest Moo JSON::Validator File::Share

RUN git clone https://github.com/perlpunk/App-Spec-p5.git /appspeclib/App-Spec-p5 \
  && git clone https://github.com/perlpunk/App-AppSpec-p5.git /appspeclib/App-AppSpec-p5 \
  && cd /appspeclib/App-Spec-p5 \
  && git checkout completion

 #  && ./cpanm File::Share YAML::XS App::cpanminus
#  && rm -rf /var/cache/apk/*

COPY appspec /appspec
