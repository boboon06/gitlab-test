FROM ubuntu:20.04

RUN apt-get -y update && apt-get install -y gcc libboost-all-dev cmake