FROM ubuntu:latest

MAINTAINER Jonas

RUN apt-get update

RUN apt-get install -y python python-pip

RUN pip install --upgrade pip

COPY main.py /home/main.py

WORKDIR /home

CMD python main.py
