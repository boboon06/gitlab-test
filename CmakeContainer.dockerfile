FROM ubuntu:20.04

# Some of the packages required to install gcc, libboost-all-dev and cmake default to requiring an interactive dpkg session
# So we want to set the debian frontend to noninteractive during the Docker build step only.
ARG DEBIAN_FRONTEND=noninteractive

# Default the timezone to UTC, but users can override the environment variable if they want it in their timezone.
ENV TZ=UTC

RUN apt-get -y update && apt-get install -y gcc libboost-all-dev build-essential libssl-dev wget

# APT only has cmake 3.16.3 and we need >= 3.17.0 so we have to download and compile cmake from source.
ARG CMAKE_VERSION

# Download cmake source code from GitHub as a tar.gz and extract it
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz -O download.tar.gz; tar -zxf download.tar.gz; rm download.tar.gz;

# Navigate to the extracted cmake source code, and install it
RUN cd cmake-${CMAKE_VERSION}; ./bootstrap; make install; cd ..; rm -rf cmake-${CMAKE_VERSION}/
