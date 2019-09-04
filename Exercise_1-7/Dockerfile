FROM ubuntu:16.04

RUN apt-get update && apt-get install curl --yes

WORKDIR /app

COPY runme.sh .

CMD [ "sh", "/app/runme.sh" ]