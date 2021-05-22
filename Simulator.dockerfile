ARG BUILD_CONTAINER
FROM ${BUILD_CONTAINER} AS build

COPY * /src/
RUN mkdir build
RUN cmake -S /src -B build
RUN cmake --build build

FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get install -y libboost-regex
COPY --from=build build/Simulator .
ENTRYPOINT ["./Simulator"]