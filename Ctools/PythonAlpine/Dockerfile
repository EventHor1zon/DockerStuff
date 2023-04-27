#syntax=docker/docker:1
FROM ubuntu
WORKDIR /src
RUN apt-get update && apt-get -y install software-properties-common && apt-add-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y python3.8 python3-pip
CMD python3.8 -c 'print("Hello, world!")'
