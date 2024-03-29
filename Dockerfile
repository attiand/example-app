FROM registry.access.redhat.com/ubi8/openjdk-17-runtime@sha256:3d0eadd123534c1882fd201a9ea78eb42cdde8ed6ab564784c7ec2b3ad926fa6

USER root

ENV TZ=Europe/Stockholm HOME=/opt/example-app LANG=C.utf8

RUN groupadd --system --gid=1000 example-app && \
    useradd --system --no-log-init --gid example-app --uid=1000 example-app && \
    mkdir /var/example-app && chown example-app:example-app /var/example-app && \
    mkdir /opt/example-app && chown example-app:example-app /opt/example-app

# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=example-app:example-app target/quarkus-app/lib/ /opt/example-app/lib/
COPY --chown=example-app:example-app target/quarkus-app/*.jar /opt/example-app/
COPY --chown=example-app:example-app target/quarkus-app/app/ /opt/example-app/app/
COPY --chown=example-app:example-app target/quarkus-app/quarkus/ /opt/example-app/quarkus/

USER example-app

WORKDIR /var/example-app

EXPOSE 8080
EXPOSE 8787

CMD java \
    ${JAVA_OPTS} \
    -agentlib:jdwp=transport=dt_socket,address=*:8787,server=y,suspend=n \
    -Djava.net.preferIPv4Stack=true \
    -jar /opt/example-app/quarkus-run.jar
