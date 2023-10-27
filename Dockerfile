FROM registry.access.redhat.com/ubi8/openjdk-17-runtime:1.17-1.1693366274

USER root

ENV TZ=Europe/Stockholm HOME=/opt/slask LANG=C.utf8

RUN groupadd --system --gid=1000 slask && \
    useradd --system --no-log-init --gid slask --uid=1000 slask && \
    mkdir /var/slask && chown slask:slask /var/slask && \
    mkdir /opt/slask && chown slask:slask /opt/slask

# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=slask:slask target/quarkus-app/lib/ /opt/slask/lib/
COPY --chown=slask:slask target/quarkus-app/*.jar /opt/slask/
COPY --chown=slask:slask target/quarkus-app/app/ /opt/slask/app/
COPY --chown=slask:slask target/quarkus-app/quarkus/ /opt/slask/quarkus/

USER slask

# Required to build with Docker on Windows
RUN chmod u+x \
    /opt/slask \
    /opt/slask/lib \
    /opt/slask/lib/main \
    /opt/slask/lib/boot \
    /opt/slask/app \
    /opt/slask/quarkus

WORKDIR /var/slask

EXPOSE 8080
EXPOSE 8787

CMD java \
    ${JAVA_OPTS} \
    -agentlib:jdwp=transport=dt_socket,address=*:8787,server=y,suspend=n \
    -Djava.net.preferIPv4Stack=true \
    -jar /opt/slask/quarkus-run.jar
