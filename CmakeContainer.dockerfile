FROM ubuntu:20.04

# Some of the packages required to install gcc, libboost-all-dev and cmake default to requiring an interactive dpkg session
# So we want to set the debian frontend to noninteractive during the Docker build step only.
ARG DEBIAN_FRONTEND=noninteractive

# Default the timezone to UTC, but users can override the environment variable if they want it in their timezone.
ENV TZ=UTC

RUN apt-get -y update && apt-get install -y gcc libboost-all-dev cmake