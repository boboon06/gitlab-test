ARG BUILD_CONTAINER
FROM ${BUILD_CONTAINER} AS build

COPY * /src/
RUN mkdir build
RUN cmake -S /src -B build
RUN cmake --build build

FROM ubuntu:20.04
COPY --from=build build/simulator .
ENTRYPOINT ["simulator"]