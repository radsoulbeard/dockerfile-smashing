FROM arm32v7/ruby:2.3.1

ENV PROJECT smashing

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && \
    apt-get -y install nodejs && \
    apt-get -y clean
RUN gem install bundler smashing
RUN mkdir /${PROJECT} && \
    smashing new ${PROJECT} && \
    cd /${PROJECT} && \
    bundle
    
COPY run.sh /

VOLUME [${PROJECT}]

ENV PORT 3030
EXPOSE $PORT
WORKDIR /${PROJECT}

CMD ["/run.sh"]

