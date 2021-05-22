ARG BUILD_CONTAINER
FROM ${BUILD_CONTAINER} AS build

COPY * /src/
RUN mkdir build
RUN cmake -S /src -B build
RUN cmake --build build

FROM ${BUILD_CONTAINER}
COPY --from=build build/Simulator .
ENTRYPOINT ["./Simulator"]