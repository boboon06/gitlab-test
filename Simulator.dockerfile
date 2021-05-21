ARG BUILD_CONTAINER
FROM ${BUILD_CONTAINER} AS build

RUN mkdir build
RUN ls -al
RUN cmake -S . -B build
RUN cmake --build build
RUN chmod +x build/simulator.exe

FROM ubuntu:20.04
COPY --from=build build .
ENTRYPOINT ["simulator.exe"]