FROM docker.io/eclipse-temurin:21-jdk-alpine@sha256:b5d37df8ee5bb964bb340acca83957f9a09291d07768fba1881f6bfc8048e4f5 AS build

USER root

RUN mkdir /var/example-app

COPY . /var/example-app

WORKDIR /var/example-app

RUN chmod +x mvnw

RUN ./mvnw -B --file pom.xml package

FROM registry.access.redhat.com/ubi8/openjdk-17-runtime@sha256:d60a6c9cacbe7d99fce259d25e1fdbd32aeaa81f60769afd7a14f72886bc2330

USER root

ENV TZ=Europe/Stockholm HOME=/opt/example-app LANG=C.utf8

RUN groupadd --system --gid=1000 example-app && \
    useradd --system --no-log-init --gid example-app --uid=1000 example-app && \
    mkdir /var/example-app && chown example-app:example-app /var/example-app && \
    mkdir /opt/example-app && chown example-app:example-app /opt/example-app

# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=example-app:example-app --from=build var/example-app/target/quarkus-app/lib/ /opt/example-app/lib/
COPY --chown=example-app:example-app --from=build var/example-app/target/quarkus-app/*.jar /opt/example-app/
COPY --chown=example-app:example-app --from=build var/example-app/target/quarkus-app/app/ /opt/example-app/app/
COPY --chown=example-app:example-app --from=build var/example-app/target/quarkus-app/quarkus/ /opt/example-app/quarkus/

USER example-app

WORKDIR /var/example-app

EXPOSE 8080
EXPOSE 8787

CMD java \
    ${JAVA_OPTS} \
    -agentlib:jdwp=transport=dt_socket,address=*:8787,server=y,suspend=n \
    -Djava.net.preferIPv4Stack=true \
    -jar /opt/example-app/quarkus-run.jar
