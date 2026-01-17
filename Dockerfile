FROM eclipse-temurin:17-jdk AS build

ENV GH_HOME=/build/graphhopper

RUN apt-get update && \
    apt-get install -y git maven && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN git clone https://github.com/graphhopper/graphhopper.git

WORKDIR ${GH_HOME}

RUN mvn -B -DskipTests clean package

FROM eclipse-temurin:25

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data

WORKDIR /graphhopper

COPY --from=build /build/graphhopper/web/target/graphhopper-web-*.jar graphhopper.jar

VOLUME [ "/data" ]

EXPOSE 8989 8990

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8989/health || exit 1

ENTRYPOINT ["sh"]